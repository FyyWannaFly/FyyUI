# FyyUI Architecture

FyyUI is developed as 19 ordered Luau source files and distributed as one generated `fyyui.lua` bundle. Runtime users still fetch one URL and execute one `loadstring`; files under `src/` are never fetched individually.

## Source tree

```text
src/
├── bootstrap.lua
├── components/
│   ├── toggle.lua
│   ├── slider.lua
│   ├── dropdown.lua
│   ├── keybind.lua
│   ├── input.lua
│   └── checkbox.lua
├── layout/
│   ├── columns.lua
│   └── collapsible.lua
├── navigation/
│   └── tab.lua
├── menu/
│   ├── constructor.lua
│   ├── navigation.lua
│   ├── overview.lua
│   ├── config.lua
│   ├── notifications.lua
│   ├── window.lua
│   ├── theme_tooltip.lua
│   └── palette.lua
└── export.lua
```

`bootstrap.lua` owns themes, utilities, validation, icon rendering, constants, and shared layout forward declarations. Components own their controllers. `columns.lua` and `collapsible.lua` share the forward-declared layout controllers because they can nest each other. `tab.lua` owns tab construction and all component factories. Menu files extend one shared `Menu` table in lifecycle order. `export.lua` creates and returns the public `FyyUI` table.

## Building

Edit source files, then regenerate the root bundle:

```bash
node scripts/build.js
```

Confirm that the committed bundle is synchronized without changing files:

```bash
node scripts/build.js --check
```

The build has a fixed source manifest, normalizes line endings, emits one shared closure, and produces deterministic output. Two consecutive builds must produce the same `fyyui.lua` hash.

The extraction helper exists only for rebuilding `src/` from a known compatible monolith:

```bash
node scripts/extract-modules.js --force path/to/monolith.lua
```

It intentionally refuses to overwrite `src/` without `--force`.

## Release rules

1. Treat `src/` as the source of truth.
2. Do not edit root `fyyui.lua` directly.
3. Keep public API and runtime behavior in the generated bundle.
4. Commit source changes and regenerated `fyyui.lua` together.
5. Run `node scripts/build.js --check`, StyLua verification, and the Roblox smoke harness before release.
6. Keep the root file because demos and users load it directly from GitHub with one request.
