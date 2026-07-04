# Secrets (sops-nix)

Secrets are managed by [sops-nix](https://github.com/Mic92/sops-nix), wired up in [system/modules/core/sops.nix](../system/modules/core/sops.nix). Encrypted YAML files live in [system/secrets/](../system/secrets/) and are decrypted at activation with an age key.

## Secrets are auto-derived from the YAML files, not declared by hand

`sops.nix` does **not** list secrets individually. It scans every `.yaml` under `system/secrets/` (via `sundry.vfs`) and generates one `sops.secrets` entry per top-level key in every file. Adding a key to a YAML file is all it takes — no Nix edit.

The generated secret name is `<file-stem>/<yaml-key>`:

| File | YAML key | `sops.secrets."…"` name |
|---|---|---|
| `vpn.yaml` | `sub-url` | `vpn/sub-url` |
| `vpn.yaml` | `hwid` | `vpn/hwid` |
| `ssh-keys.yaml` | `<key>` | `ssh-keys/<key>` |

The file *stem* is the tag-stripped name — `password-hashes{for-users}.yaml` becomes stem `password-hashes`, so its keys are `password-hashes/<key>`.

Every generated secret gets `owner = username`, `mode = "0400"`, and `sopsFile` pointing back at its origin file.

## The `{for-users}` tag

A secret needed **before** users exist (e.g. login password hashes) must be decrypted early. Tag the file `{for-users}` in its name — `password-hashes{for-users}.yaml` — and `sops.nix` sets `neededForUsers = true` on every key it contains. Without the tag the secret is decrypted normally (after users are created).

## Age key

| What | Where |
|---|---|
| Private key | `/etc/sops/age/master.txt` (not in the repo) |
| Recipient (public) | `age1rh3ejm93aaawujhuhst4tezwneefkxhh0aede0wpqf86mpjhesks6rem3m`, hardcoded in `sops.nix` as `SOPS_AGE_RECIPIENTS` |

`SOPS_AGE_KEY_FILE` and `SOPS_AGE_RECIPIENTS` are exported as environment variables so the `sops` CLI works without passing the key path or fingerprint manually:

```bash
sops system/secrets/vpn.yaml    # edit — decrypts, opens $EDITOR, re-encrypts on save
```

## Consuming a secret in a service

sops decrypts each secret to a path under `/run/secrets/…` owned by `username`, mode `0400`. A systemd service reads it via `LoadCredential`, which copies it into the unit's private `$CREDENTIALS_DIRECTORY` — see [sing-box's systemd-service.nix](../system/modules/sing-box/systemd-service.nix):

```nix
LoadCredential = [
  "sub-url:${config.sops.secrets."vpn/sub-url".path}"
  "hwid:${config.sops.secrets."vpn/hwid".path}"
];
```

The script then reads `$CREDENTIALS_DIRECTORY/sub-url` and `$CREDENTIALS_DIRECTORY/hwid` at runtime — never the plaintext, never a Nix interpolation of the value.

## Adding a secret

1. `sops system/secrets/<file>.yaml` — add the key under an existing or new YAML file.
2. Reference it as `config.sops.secrets."<file-stem>/<key>".path` — no declaration needed; `sops.nix` picks it up from the file.
3. For a service, wire that path through `LoadCredential` and read `$CREDENTIALS_DIRECTORY/<name>`.
4. `git add` the YAML file (a flake only sees git-tracked files) and `nixos-rebuild switch`.
