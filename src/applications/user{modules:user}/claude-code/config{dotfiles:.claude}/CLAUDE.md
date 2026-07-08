# Claude global config

Global conventions that apply across all repositories and sessions on this machine.

---

# Environment

System and tooling context for this machine.

## OS and package management

- **NixOS** — declarative, immutable OS. No `apt`, `pacman`, or similar.
- **Home Manager** — user-level config (dotfiles, packages, VS Code settings) is declared in `.nix` files and built into `/nix/store`. The resulting files are symlinks into the store and are read-only. Home Manager runs as a NixOS module (not standalone), so it is applied via `nixos-rebuild switch`, not `home-manager switch`.
- **Flakes** — both NixOS config and Home Manager use nix flakes (`flake.nix` + `flake.lock`).

To apply changes to system or user config: edit the relevant `.nix` file in `~/nixos-config`. Never edit symlinked files directly — changes are lost on the next rebuild.

Rebuilding is done via the `nixos-update` script (from the `nixos-update-script` flake input), not raw `nixos-rebuild`. **Do not run either — switching the active system generation is the user's decision.** Typical invocations for reference:

```bash
alejandra . && nixos-update --test          # format + dry-run (no switch)
alejandra . && nixos-update --branch <name> # format + build + switch on the given branch
```

## Projects

All projects live under the home directory (`~/`). Each project has a `CLAUDE.md` at its root and an `.agent-docs/` directory with project-specific context — read both before working in any repo.

`~/nixos-config` is the NixOS + Home Manager configuration for this machine. It is a constant — system and user config always lives there, and changes are applied via `nixos-rebuild switch`.

## Editing global Claude config

This file (`~/.claude/CLAUDE.md`) is managed as a dotfile in `~/nixos-config`. Edit the source at:

```
~/nixos-config/src/applications/user{modules:user}/claude-code/config{dotfiles:.claude}/CLAUDE.md
```

After editing, run `nixos-rebuild switch` to symlink the updated file into `~/.claude/`.

`~/.claude/settings.json` is also a symlink — generated from Home Manager options in:

```
~/nixos-config/src/applications/user{modules:user}/claude-code/program.nix
```

## Shell and tools

- Shell: **zsh**
- Formatter: **alejandra** (Nix)
- LSP: **nixd**
- Editor: **VS Code** (user settings managed by Home Manager — see above)

## sudo

`sudo` requires an interactive terminal to read the password and cannot be used in a non-interactive shell. Do not attempt `sudo` commands — tell the user and ask them to run the command themselves.

## Adding tools temporarily

`nix shell nixpkgs#<package>` works and is the right way to add a tool for the current session without touching any config. Example:

```bash
nix shell nixpkgs#hello --command hello
```

To make a tool permanent, add it to the Home Manager config instead.

---

# Repository setup

Conventions that apply whenever Claude operates inside a git repository.

## `.agent-docs/` is required

Every git repository must have an `.agent-docs/` directory at its root. It holds project-specific context that Claude reads before working. Maintain it according to the writing docs conventions below.

If `.agent-docs/` does not exist, create it before starting any task, and populate it with at least one doc covering the project's domain.

**Project-specific information belongs in the project's `.agent-docs/`, never in the global cross-project memory store.** The memory store is for facts that hold across every repo (who the user is, machine-wide conventions, how Claude should work in general). Anything tied to one project — its architecture, ongoing work, design decisions, tag models, gotchas — goes in that project's `.agent-docs/`, where it lives with the code and any session or contributor can read it. If a fact would be meaningless in a different repository, it is project-specific: write it to `.agent-docs/`, not to memory.

## `CLAUDE.md` is required

A `CLAUDE.md` must exist at the repository root. It is the entry point Claude reads first. It must contain:

1. **Project description** — one short paragraph: what the project is and how it's structured.
2. **Doc index** — a bullet list of every file in `.agent-docs/`, each with a one-line summary, matching this format:

   ```
   - [filename.md](.agent-docs/filename.md) — what this doc covers.
   ```

3. **Forced imports** — one `@`-prefixed path per doc, immediately after the index, so Claude loads every doc into context automatically:

   ```
   @.agent-docs/filename.md
   ```

4. **Drift guard** — a sentence reminding that adding, renaming, or removing a doc requires updating the index and import list in the same change.

### Example `CLAUDE.md` skeleton

```markdown
# project-name

One paragraph describing the project.

## Before working, read the relevant doc in `.agent-docs/`

- [data-model.md](.agent-docs/data-model.md) — …
- [authoring.md](.agent-docs/authoring.md) — …

When you add, rename, or remove a doc under `.agent-docs/`, update this index — and the import list below — in the same change so neither drifts from what's on disk.

@.agent-docs/data-model.md
@.agent-docs/authoring.md
```

## Keeping both in sync

Whenever a doc is added, renamed, or removed:

- Update the bullet in the index.
- Update the `@`-import line.
- Re-read `CLAUDE.md` top-to-bottom to verify it still reads correctly as an entry point.

A `CLAUDE.md` that lists a doc that no longer exists is worse than no `CLAUDE.md` — stale context misleads rather than helps.

---

# Writing code

Conventions for the code Claude writes, as opposed to the docs about it.

## Don't comment code inline

Don't add inline comments explaining what code does. Well-named identifiers and clear structure carry that load; a comment that restates the code is noise that drifts out of sync. If a line needs a comment to be understood, prefer renaming or restructuring it instead.

Reserve comments for the rare case where the *why* is genuinely non-obvious and cannot be expressed in the code — a workaround for an external bug, a deliberate deviation from the obvious approach. Keep those short and place them at the point they explain. Never narrate the *what*.

---

# Writing docs

Meta-rules for files under `.agent-docs/`.

## One topic per file

A doc owns one orthogonal concern — naming, layout, testing, etc. If you find yourself drafting an "extension", "appendix", or "see also at the end" section that doesn't fit the doc's main thread, the doc is probably two topics. Split it and link between them.

## Gotchas live in their own file

Non-obvious traps — behavior that already bit someone and would bite again — belong in a dedicated `gotchas.md`, not scattered as warnings across topic docs. Each entry is one trap: **the rule, one line of why, and how to avoid it.** Motivation is mandatory here; a gotcha without its *why* reads as arbitrary and gets "cleaned up" by the next person.

Keep it strictly to the counter-intuitive. It is not a FAQ, not a troubleshooting log, and not a place to restate normal architecture — if a trap is just "how the system works", it belongs in the topic doc that owns that system, linked from here if needed. A gotcha earns its entry only by surprising someone.

## No internal forward/backward references

Avoid pointers like *"see X at the end"* or *"as covered above"* within a single doc. They betray that the doc was added to over time and force the reader to skip around. Restructure so the natural reading order makes them unnecessary — either move the relevant content next to the reference, or split into a separate doc and link to it as a peer.

Cross-doc links are fine — they describe parallel concerns, not iteration history.

## Lead with the rule, not the history

A reader looking up "how do I name X" doesn't need to know which refactor produced the convention. State the rule, give an example, move on. Motivation goes in one line if it's not obvious, and only when it changes behavior at the edges.

## Concrete examples beat abstract rules

When a convention applies in multiple contexts, show one concrete example per context — don't substitute generalized prose. A reader skimming for "does this apply to my case" needs to recognize the shape, not parse abstractions.

Linked references (`[src/foo/bar.nix](../src/foo/bar.nix)`) are stronger than inline quotations: they survive code edits when prose drifts. Prefer them.

## Keep it scannable

- Tables for orthogonal axes (role × symbol, file × namespace).
- Code blocks for examples that should be visually pattern-matched or copy-pasted.
- Short paragraphs between them. If a paragraph reaches 4+ sentences, consider whether it could be a list.

## Avoid drift between docs and code

**A code change is not finished until the docs it contradicts are fixed in the same change.** Whenever you rename, move, remove, or repurpose anything a doc describes — a file path, function name, namespace, field name, or documented behavior — update the affected docs alongside the code, never as a follow-up. Find what's affected by grepping `.agent-docs/` for the old name *and* by re-reading any doc that links into the files you touched.

Cite files by linked path, never by name alone. A broken link rots loudly the first time someone navigates it; an unlinked name rots silently. When you rename or remove a file, grep `.agent-docs/` for references.

## Read it as a stranger

Before merging a doc change, re-read the file top-to-bottom. If any sentence makes sense only because *you* remember the conversation that produced it, rewrite it for someone who doesn't.
