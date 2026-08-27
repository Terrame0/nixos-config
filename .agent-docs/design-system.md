# Design system

The active design system lives in [`infrastructure/design-system/`](../infrastructure/design-system/). It provides typed design tokens and renders every token for each supported consumer. The dotfile pipeline injects generated partials under the virtual `{dotfiles:.design-system}` subtree.

## Data flow

[`default.nix`](../infrastructure/design-system/default.nix) loads three classes of parts:

| Class | Purpose |
| --- | --- |
| `types/` | Validate source values and render them for every consumer. |
| `tokens/` | Define named colors, dimensions, fonts, and other design values. |
| `partials/` | Flatten the token tree and generate consumer-native files. |

A token has one source `value` and a rendered `to` attribute set. [`mk-type.nix`](../infrastructure/design-system/mk-type.nix) rejects a type when it does not render all registered consumers.

Supported consumers are `scss`, `lua`, `qml`, and `rasi`. Lua and QML renderings are available on tokens, but their partial generators have not been added yet.

## Generated partials

| Consumer | Generated file | Use |
| --- | --- | --- |
| SCSS | `partial{include:sass}.scss` | `@use "partial" as *;` in a `{build:sass}` entry point. |
| Rasi | `~/.design-system/partial.rasi` | `@import "~/.design-system/partial"`, then reference a token as `@colors-base-blue`. |

Both generators flatten nested token paths with hyphens. For example, `tokens.colors.base.blue` becomes `$colors-base-blue` in SCSS and `colors-base-blue` in the Rasi global `* { ... }` section.

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

## Extending the system

- Add a token in `tokens/` by constructing it through an existing type.
- Add a type in `types/` and render every consumer registered in `mk-type.nix`.
- Add a consumer by registering its name in `mk-type.nix`, extending every type, and adding a partial generator when the consumer needs an emitted file.
