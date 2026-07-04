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

## Subscription updater

[config-parts{x}/subscription-updater.nix](../system/modules/sing-box/config-parts%7Bx%7D/subscription-updater.nix) builds a shell script that:

1. Fetches the subscription URL (from sops secret `vpn/sub-url`) with custom headers including `x-hwid` (from sops secret `vpn/hwid`).
2. Filters outbounds with `jq`: keeps only VLESS + XTLS-Vision nodes; injects the node tags into both the `auto-selector` (urltest) and `proxy` (manual selector) outbounds, and appends the node definitions themselves.
3. Validates the merged config with `sing-box check`.
4. On success: saves to `/var/lib/sing-box/config.json`, copies to runtime path.
5. On any failure (network, filter, validation): falls back to the last valid stored config. If no stored config exists, exits 1 (service fails).

## Config skeleton

The skeleton is assembled from parts in [config-parts{x}/sing-box-config/](../system/modules/sing-box/config-parts%7Bx%7D/sing-box-config/):

| File | Content |
|---|---|
| `default.nix` | Merges all parts into a single JSON derivation |
| `dns.nix` | DNS settings |
| `inbounds.nix` | Inbound listeners |
| `outbounds.nix` | Outbound definitions: `proxy` (manual selector, what route/dns point at), `auto-selector` (urltest placeholder), `direct` |
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

Pinning is done over the Clash control API, enabled in [config-parts{x}/sing-box-config/misc.nix](../system/modules/sing-box/config-parts%7Bx%7D/sing-box-config/misc.nix) as `experimental.clash_api.external_controller = "127.0.0.1:9090"`. It is localhost-only with no secret; point a Clash-compatible UI or `curl` at it to switch the `proxy` selector.

## Secrets

Managed by sops-nix. Required secrets in the sops file:

| Secret | Used for |
|---|---|
| `vpn/sub-url` | Subscription fetch URL |
| `vpn/hwid` | Hardware ID header sent to the subscription server |

## Capabilities

The service runs with `CAP_NET_ADMIN` and `CAP_NET_BIND_SERVICE` (ambient + bounding set) — required for TUN and port binding.
