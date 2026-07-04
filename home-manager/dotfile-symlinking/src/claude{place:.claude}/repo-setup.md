# Repository setup

Conventions that apply whenever Claude operates inside a git repository.

## `.agent-docs/` is required

Every git repository must have an `.agent-docs/` directory at its root. It holds project-specific context that Claude reads before working. Maintain it according to [docs-style.md](docs-style.md).

If `.agent-docs/` does not exist, create it before starting any task, and populate it with at least one doc covering the project's domain.

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
