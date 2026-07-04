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
2. Filters outbounds with `jq`: keeps only VLESS + XTLS-Vision nodes; injects them into the skeleton config's `auto-selector` outbound.
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
| `outbounds.nix` | Outbound definitions (including `auto-selector` placeholder) |
| `route.nix` | Routing rules |
| `misc.nix` | Misc top-level fields |
| `proxied-domains.nix` | Domain list used in routing rules |

## Secrets

Managed by sops-nix. Required secrets in the sops file:

| Secret | Used for |
|---|---|
| `vpn/sub-url` | Subscription fetch URL |
| `vpn/hwid` | Hardware ID header sent to the subscription server |

## Capabilities

The service runs with `CAP_NET_ADMIN` and `CAP_NET_BIND_SERVICE` (ambient + bounding set) — required for TUN and port binding.
