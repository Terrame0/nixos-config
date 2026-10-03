# Design system

The active design system lives in [`meta/design-system/`](../meta/design-system/). It provides typed design tokens and renders every token for each supported consumer. It exports the generated partials as a resolved VFS subtree tagged `{dotfiles:.design-system}`, which the assembly merges into the repo's shared `root-vfs`.

## Data flow

[`default.nix`](../meta/design-system/default.nix) loads three classes of parts:

| Class | Purpose |
| --- | --- |
| `types/` | Validate source values and render them for every consumer. |
| `tokens/` | Define named colors, dimensions, fonts, and other design values. |
| `partials/` | Flatten the token tree and generate consumer-native files. |

[`default.nix`](../meta/design-system/default.nix) receives its own subtree as the `vfs` argument and reads each part through the lazy `.expr` the global `load-nix` attached — e.g. `vfs."mk-type.nix".expr args`. `load-parts` collapses a `vfs.<sub>` subtree and evaluates each leaf as `file.expr args`; it no longer builds the tree with `from-src`.

A token has a type name and two representations produced from one source value by [`mk-type.nix`](../meta/design-system/mk-type.nix):

| Field | Produced by | Consumer |
| --- | --- | --- |
| `native` | `native-repr` | Nix code, via `native-tokens` |
| `to` | `consumer-repr` | partial generators |

The source value is validated by `value-check` and is **not** stored on the token — a type that never renders a consumer does not exist. For a non-composite type `native-repr` defaults to `lib.id`; a composite overrides it to project its parts. `consumer-repr` must return a value for every registered consumer, or `mk-type` throws.

Supported consumers are `css`, `scss`, `lua`, `qml`, and `rasi`. Lua and QML renderings are available on tokens, but their partial generators have not been added yet.

## Export: `partials-vfs` and `native-tokens`

[`default.nix`](../meta/design-system/default.nix) exports `partials-vfs` and `native-tokens`.

`partials-vfs` is the resolved VFS subtree of the generated partials, tagged `{dotfiles:.design-system}` by its own `resolve-tags`:

```nix
partials-vfs = sundry.vfs.dir.resolve-tags {
  "partials{dotfiles:.design-system}" = partials;
};
```

`native-tokens` is the token tree flattened to native values. The flattener reads each token's `native`; nothing recurses into a `value` because the token no longer carries one:

```nix
native-tokens =
  sundry.attrs.walk-until is-token
  (path: attrs: attrs.native)
  tokens;
```

A composite contributes its own `native` — `native-tokens.font.body` is `{ family = "JetBrainsMono NFP"; size = 16; }`. Its `native-repr` projects each part's `native`, so no generic token-walking is needed:

```nix
native-repr = value: {
  family = value.family.native;
  size = value.size.native;
};
```

A color's native value is the full 8-digit `#rrggbbaa`; a consumer that wants an opaque 6-digit hex — or must append its own alpha, as VS Code does — slices the base with `sundry.str.slice color [7]`. The assembly does not pre-slice, so `native-tokens.colors.base.blue` stays `#7aa6daff` and each consumer decides.

The tag makes the partials indistinguishable from any other `{dotfiles}` subtree downstream. [`meta/system-assembly/each-host.nix`](../meta/system-assembly/each-host.nix) merges `partials-vfs` into `root-vfs`, so the dotfile pipeline picks them up without special-casing them. Previously `default.nix` exported the raw `partials` attrset and the dotfile pipeline injected it itself; that responsibility now belongs to the assembly, and `resolve-tags` runs on the partials tree exactly once — see [gotchas.md](gotchas.md).

## Generated partials

| Consumer | Generated file | Use |
| --- | --- | --- |
| CSS | `~/.design-system/partial.css` | Load the stylesheet, then reference a token as `var(--ds-colors-base-blue)`. |
| SCSS | `partial{include:sass}.scss` | `@use "partial" as *;` in a `{build:sass}` entry point. |
| Rasi | `~/.design-system/partial.rasi` | `@import "~/.design-system/partial"`, then reference a token as `@ds-colors-base-blue`. |

All generators flatten nested token paths with hyphens. For example, `tokens.colors.base.blue` becomes `--ds-colors-base-blue` in the CSS `:root` block, `$colors-base-blue` in SCSS, and `ds-colors-base-blue` in the Rasi global `* { ... }` section.

## Rasi rendering

Rasi values must remain valid even when a token is not used by the current Rofi theme:

| Token type | Rasi representation |
| --- | --- |
| color | `#rrggbbaa` |
| pixel dimension | `<number>px` |
| point dimension | unitless number |
| duration | integer milliseconds |
| cubic Bézier | list of four numbers |
| font family | quoted string |
| number, opacity, font weight | number |

Rasi global properties can be referenced only as complete values; they cannot be interpolated into part of another value. Define a composite token when a consumer needs a combined value.

## Composite tokens

Composite types validate their input token types and render the combined value according to each consumer's grammar. The font type combines a font-family token with a point-dimension token:

```nix
font.body = types.font font.family.propo font.size.body;
```

Its Rasi representation is `"JetBrainsMono NFP 16"`, while its SCSS representation is `16pt "JetBrainsMono NFP"`. Compose source tokens through a composite type instead of concatenating their rendered strings: quoting and value order differ between consumers.

## Extending the system

- Add a token in `tokens/` by constructing it through an existing type.
- Add a type in `types/` with a `value-check` and a `consumer-repr` covering every consumer registered in `mk-type.nix`. `native-repr` defaults to `lib.id`; override it only for a composite.
- Add a composite type when one logical consumer value is assembled from multiple tokens; its `native-repr` projects the parts' `native`.
- Add a consumer by registering its name in `mk-type.nix`, extending every type's `consumer-repr`, and adding a partial generator when the consumer needs an emitted file.
