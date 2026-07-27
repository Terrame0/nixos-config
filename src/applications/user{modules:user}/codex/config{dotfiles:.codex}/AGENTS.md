# Codex global config

Global conventions that apply across all repositories and sessions on this machine.

---

# Environment

System and tooling context for this machine.

## OS and package management

- NixOS — declarative, immutable OS. No `apt`, `pacman`, or similar.
- Home Manager — user-level config (dotfiles, packages, VS Code settings) is declared in `.nix` files and built into `/nix/store`. The resulting files are symlinks into the store and are read-only. Home Manager runs as a NixOS module, not standalone, so it is applied through the system rebuild flow.
- Flakes — both NixOS config and Home Manager use nix flakes (`flake.nix` + `flake.lock`).

To apply changes to system or user config, edit the relevant `.nix` file in `~/nixos-config`. Never edit symlinked files directly; changes are lost on the next rebuild.

Rebuilding is done via the `nixos-update` script from the `nixos-update-script` flake input. Do not run `nixos-update` or `nixos-rebuild switch`; switching the active system generation is the user's decision. Typical invocations for reference:

```bash
alejandra . && nixos-update --test
alejandra . && nixos-update --branch <name>
```

## Projects

All projects live under the home directory (`~/`). Project-specific durable context belongs in the project's `AGENTS.md` and `.agent-docs/` directory.

`~/nixos-config` is the NixOS + Home Manager configuration for this machine. It is a constant: system and user config always lives there.

## Simplified Technical English

STE reference files are managed as Codex dotfiles next to this file:

- `~/.codex/ste-writing-guidelines.md` — condensed writing rules.
- `~/.codex/allowed.md` — approved words and meanings.
- `~/.codex/prohibited.md` — prohibited words and approved alternatives.

For STE checking, rewriting, or rule explanations, read the relevant STE files before answering or changing code.

## Editing global Codex config

This file (`~/.codex/AGENTS.md`) is managed as a dotfile in `~/nixos-config`. Edit the source at:

```text
~/nixos-config/src/applications/user{modules:user}/codex/config{dotfiles:.codex}/AGENTS.md
```

After editing, run the usual system rebuild flow to symlink the updated file into `~/.codex/`.

## Shell and tools

- Shell: zsh
- Formatter: alejandra (Nix)
- LSP: nixd
- Editor: VS Code (user settings managed by Home Manager)

## sudo

`sudo` requires an interactive terminal to read the password and cannot be used in a non-interactive shell. Do not attempt `sudo` commands; tell the user and ask them to run the command themselves.

## Adding tools temporarily

`nix shell nixpkgs#<package>` works and is the right way to add a tool for the current session without touching any config. Example:

```bash
nix shell nixpkgs#hello --command hello
```

To make a tool permanent, add it to the Home Manager config instead.

---

# Repository Setup

Conventions that apply whenever Codex operates inside a git repository.

## `.agent-docs/`

Every git repository should have an `.agent-docs/` directory at its root. It holds project-specific context that Codex reads when the task calls for it. Maintain it according to the writing docs conventions below.

Project-specific information belongs in the project's `.agent-docs/`, not in the global cross-project memory store. The memory store is for facts that hold across every repo. Anything tied to one project, such as architecture, ongoing work, design decisions, tag models, or gotchas, goes in that project's `.agent-docs/`.

## `AGENTS.md`

An `AGENTS.md` should exist at the repository root. It is the entry point Codex reads automatically. It should contain:

1. Project description — one short paragraph: what the project is and how it is structured.
2. Doc index — a bullet list of every file in `.agent-docs/`, each with a one-line summary.
3. Drift guard — a sentence reminding that adding, renaming, or removing a doc requires updating the index in the same change.

### Example `AGENTS.md` skeleton

```markdown
# project-name

One paragraph describing the project.

## Before working, read the relevant doc in `.agent-docs/`

- [data-model.md](.agent-docs/data-model.md) — ...
- [authoring.md](.agent-docs/authoring.md) — ...

When you add, rename, or remove a doc under `.agent-docs/`, update this index in the same change so it does not drift from what's on disk.
```

## Keeping Docs In Sync

Whenever a doc is added, renamed, or removed:

- Update the bullet in the index.
- Re-read `AGENTS.md` top-to-bottom to verify it still reads correctly as an entry point.

An `AGENTS.md` that lists a doc that no longer exists is worse than no `AGENTS.md`: stale context misleads rather than helps.

---

# Writing Code

Conventions for code Codex writes, as opposed to docs about it.

## Do Not Comment Code Inline

Do not add inline comments explaining what code does. Well-named identifiers and clear structure carry that load; a comment that restates the code is noise that drifts out of sync.

Reserve comments for the rare case where the why is genuinely non-obvious and cannot be expressed in the code: a workaround for an external bug or a deliberate deviation from the obvious approach. Keep those short and place them at the point they explain.

---

# Writing Docs

Meta-rules for files under `.agent-docs/`.

## One Topic Per File

A doc owns one orthogonal concern: naming, layout, testing, or another focused topic. If you find yourself drafting an extension or appendix that does not fit the doc's main thread, split it and link between the files.

## Gotchas Live In Their Own File

Non-obvious traps belong in a dedicated `gotchas.md`, not scattered as warnings across topic docs. Each entry is one trap: the rule, one line of why, and how to avoid it. Motivation is mandatory.

Keep it strictly to the counter-intuitive. It is not a FAQ, not a troubleshooting log, and not a place to restate normal architecture.

## No Internal Forward Or Backward References

Avoid pointers like "see X at the end" or "as covered above" within a single doc. Restructure so the natural reading order makes them unnecessary, or split the content into a separate doc.

## Lead With The Rule, Not The History

A reader looking up "how do I name X" does not need to know which refactor produced the convention. State the rule, give an example, move on.

## Concrete Examples Beat Abstract Rules

When a convention applies in multiple contexts, show one concrete example per context. Linked references are stronger than inline quotations because they survive code edits better.

## Keep It Scannable

- Tables for orthogonal axes.
- Code blocks for examples that should be visually pattern-matched or copy-pasted.
- Short paragraphs between them.

## Avoid Drift Between Docs And Code

A code change is not finished until the docs it contradicts are fixed in the same change. Whenever you rename, move, remove, or repurpose anything a doc describes, update the affected docs alongside the code.

Cite files by linked path, never by name alone. When you rename or remove a file, grep `.agent-docs/` for references.

## Read It As A Stranger

Before merging a doc change, re-read the file top-to-bottom. If any sentence makes sense only because you remember the conversation that produced it, rewrite it for someone who does not.
