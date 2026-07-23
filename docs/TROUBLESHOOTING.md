# Troubleshooting FyyUI

> Applies to FyyUI v0.13.0 · Updated 2026-07-24

## The library does not load

Use a trusted local ModuleScript:

```lua
local FyyUI = require(script.Parent.FyyUI)
```

Do not bootstrap FyyUI with remote HTTP code or `loadstring`. Verify that the ModuleScript path and name match your hierarchy.

## The menu is not visible

1. Ensure you called `FyyUI.Menu({ ... })`.
2. Check that `Visible` is not `false`.
3. Set `Parent` explicitly if your experience cannot use the default GUI parent.
4. Confirm the menu was not destroyed and no earlier script error interrupted execution.

`menu:GetVisible()` should return `true` after successful creation.

## A dropdown looks unexpected

Use a dense option array:

```lua
dropdown:SetOptions({ "Low", "Medium", "High" })
```

On narrow screens, FyyUI intentionally uses a centered modal dropdown instead of an unusable side panel. Use `TouchTargetSize = 44` for mobile UI.

## Configuration import fails

1. Keep flags unique and stable.
2. Use finite values for sliders and numeric inputs.
3. Store multi-dropdown values as dense arrays.
4. Pair `ExportConfigJSON()` with `ImportConfigJSON()`.
5. Inspect `details.Failed` and keep current values on failure.

FyyUI validates imports before applying them, so a rejected snapshot should not partially overwrite controls.

## Keyboard or gamepad selection feels wrong

Gamepad focus is disabled while a text box or keybind capture is active. Exit text entry/capture and navigate again. Opening a dropdown or confirmation overlay with a gamepad should move selection into it and restore focus after it closes.

## Reduced motion still shows animation

Set `ReducedMotion = true` on menu creation. It makes FyyUI menu-owned transitions immediate, but cannot remove waits, tweens, or effects inside your own callbacks.

## Information to include in a bug report

- `FyyUI.Version`
- Roblox Studio/device and input type
- Theme and menu options (`Responsive`, `ReducedMotion`, `TouchTargetSize`)
- Minimal control setup that reproduces the issue
- Configuration errors or `details.Failed`, with sensitive values removed

Related: [Getting started](GETTING_STARTED.md), [Configuration](CONFIGURATION.md), and [Accessibility](ACCESSIBILITY.md).
