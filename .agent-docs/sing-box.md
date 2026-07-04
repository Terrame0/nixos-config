# sing-box VPN proxy

sing-box runs as a systemd service defined in [system/modules/sing-box/systemd-service.nix](../system/modules/sing-box/systemd-service.nix). It uses a subscription-based config that is fetched and validated at service start.

## Service lifecycle

On each `systemd.services.sing-box` start:

1. `ExecStartPre` runs the updater script (see below).
2. `ExecStart` launches `sing-box run -c /run/sing-box/config.json`.

Paths:

| Path | Purpose |
|---|---|
| `/run/sing-box/` | Runtime directory (mode 0700, cleared on reboot) |
| `/run/sing-box/config.json` | Active config passed to sing-box |
| `/run/sing-box/response.json` | Temporary subscription response (deleted after processing) |
| `/var/lib/sing-box/config.json` | Last known-good config (persists across reboots) |
| `/var/lib/sing-box/cache.db` | bbolt database: fakeip cache |

## Subscription updater

[config-parts{x}/updater/](../system/modules/sing-box/config-parts%7Bx%7D/updater/) builds the updater. Its `default.nix` wraps [update.sh](../system/modules/sing-box/config-parts%7Bx%7D/updater/update.sh) in a `writeShellApplication`, passing the config paths in as environment variables (`SKELETON`, `NODE_FILTER`, `RESPONSE_FILE`, `STORED_CONFIG`, `RUNTIME_CONFIG`). The script:

1. **Validates the bare skeleton with `sing-box check` first.** If the skeleton itself is invalid (a config bug — e.g. an unknown field like `store_selected`), the script exits 1 immediately **without falling back**, printing the check output. This class of failure is the author's bug, not a runtime condition, so it fails loud instead of being masked by a stale stored config. The skeleton passes `check` on its own because it ships a placeholder `dummy` outbound (see [Config skeleton](#config-skeleton)) — no real nodes are needed to validate the schema.
2. Fetches the subscription URL (from sops secret `vpn/sub-url`) with custom headers including `x-hwid` (from sops secret `vpn/hwid`).
3. Filters outbounds with `jq` (filter in [updater/node-filter.jq](../system/modules/sing-box/config-parts%7Bx%7D/updater/node-filter.jq)): keeps only VLESS + XTLS-Vision nodes; swaps the skeleton's `dummy` placeholder for the real node tags in both the `auto-selector` (urltest) and `proxy` (manual selector) outbounds, drops the `dummy` node, and appends the node definitions themselves.
4. Validates the *merged* config with `sing-box check`. On failure, the tool's output is logged to the journal alongside the fallback warning, so the reason is visible under `journalctl -u sing-box`.
5. On success: saves to `/var/lib/sing-box/config.json`, copies to runtime path.
6. On a **network/data** failure (subscription unreachable, no matching nodes, merged config rejected): falls back to the last valid stored config. If no stored config exists, exits 1 (service fails).

The two `sing-box check` calls split failures deliberately: a broken **skeleton** is a config bug → fail fast; a broken **merged** config is driven by subscription data → fall back and keep the last good config running.

## Config skeleton

The skeleton is assembled from parts in [config-parts{x}/sing-box-config/](../system/modules/sing-box/config-parts%7Bx%7D/sing-box-config/):

| File | Content |
|---|---|
| `default.nix` | Merges all parts into a single JSON derivation |
| `dns.nix` | DNS settings |
| `inbounds.nix` | Inbound listeners |
| `outbounds.nix` | Outbound definitions: `proxy` (manual selector, what route/dns point at), `auto-selector` (urltest placeholder), `direct`, and `dummy` (a placeholder node the two selectors reference so the bare skeleton passes `sing-box check`; the updater strips it when it merges in real nodes) |
| `route.nix` | Routing rules |
| `misc.nix` | Misc top-level fields |
| `proxied-domains.nix` | Domain list used in routing rules |

## Outbound selection

Two outbounds sit in front of the nodes, both filled with the node tags at runtime by the updater:

| Outbound | Type | Role |
|---|---|---|
| `proxy` | `selector` | What `route.nix` rules and the `remote-dns` detour point at. `default = auto-selector`, so out of the box it delegates to the urltest. |
| `auto-selector` | `urltest` | Latency-based automatic pick across all nodes. |

`proxy` also lists every node tag directly, so it can be **pinned to a specific node**, bypassing the urltest — useful when a node's metadata lies (e.g. a "Netherlands" node whose exit is actually in RU domain space, which the latency heuristic can't detect).

Pinning is done over the Clash control API, configured in [config-parts{x}/sing-box-config/misc.nix](../system/modules/sing-box/config-parts%7Bx%7D/sing-box-config/misc.nix):

- `external_controller = "127.0.0.1:9090"` — localhost-only, no secret.
- `access_control_allow_origin = ["https://metacubex.github.io"]` — CORS restricted to MetaCubeXD dashboard only.
- `access_control_allow_private_network = true` — required for Chrome to allow requests from a public origin (`github.io`) into localhost.

Point a Clash-compatible UI (e.g. [MetaCubeXD](https://metacubex.github.io/metacubexd)) or `curl` at it to switch the `proxy` selector:

```bash
curl -X PUT http://127.0.0.1:9090/proxies/proxy \
  -H 'Content-Type: application/json' \
  -d '{"name":"<node-tag>"}'
```

A manual pin does **not** persist across restarts: sing-box 1.13.x has no `cache_file.store_selected` field (setting it makes `sing-box check` fail with `unknown field "store_selected"`, which sends the updater into an endless fall-back-and-restart loop). On every restart the `proxy` selector resets to `default = "auto-selector"` and must be re-pinned over the Clash API. The same reset happens if the pinned node tag disappears after a subscription update.

## Secrets

Managed by sops-nix (see [secrets.md](secrets.md) for the general mechanism). Both live in [system/secrets/vpn.yaml](../system/secrets/vpn.yaml) and reach the service via `LoadCredential` → `$CREDENTIALS_DIRECTORY`:

| Secret | Used for |
|---|---|
| `vpn/sub-url` | Subscription fetch URL |
| `vpn/hwid` | Hardware ID header sent to the subscription server |

## Capabilities

The service runs with `CAP_NET_ADMIN` and `CAP_NET_BIND_SERVICE` (ambient + bounding set) — required for TUN and port binding.
