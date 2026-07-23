# Configuration and Persistence

> Applies to FyyUI v0.13.0 · Updated 2026-07-24

FyyUI exports controls with a `Flag`. Keep each flag unique and stable across releases.

## Legacy v1 table snapshots

```lua
local snapshot = menu:ExportConfig()
local ok, details = menu:ImportConfig(snapshot, { NoCallbacks = true })
assert(ok, details and details.Failed)
```

Zero-argument export remains the compatible v1 format:

```lua
{
	Schema = "FyyUI.Config.v1",
	Version = "0.13.0",
	Values = {
		music = true,
		volume = 50,
		quality = "High",
		categories = { "Graphics", "Audio" },
		limit = "", -- blank numeric input
	},
}
```

`ImportConfig` validates all known values before applying them. A bad value does not partially apply an otherwise valid snapshot.

## JSON-safe v2

Use v2 only when you need JSON persistence:

```lua
local v2 = menu:ExportConfig({ SchemaVersion = 2 })
local json, exportError = menu:ExportConfigJSON()
assert(json, exportError)

local ok, details = menu:ImportConfigJSON(json, { NoCallbacks = true })
assert(ok, details)
```

V2 uses `Schema = "FyyUI.Config.v2"`, `SchemaVersion = 2`, `Version`, and `Values`. Use `ExportConfigJSON` for canonical encoding rather than serializing UI internals yourself.

## Import results

```lua
local ok, details = menu:ImportConfig(snapshot)
if not ok then
	for _, failure in ipairs(details.Failed) do
		warn(failure.Flag, failure.Error)
	end
end
```

`details` tracks `Applied`, `Failed`, and `Unknown` flags. Unknown flags do not create controls, which lets old save files coexist with newer or smaller menus.

## Safety limits and validation

`ImportConfigJSON` rejects non-string or malformed JSON. The v2 `Values` table uses string flags whose values are JSON-safe finite primitives or dense one-based arrays; arbitrary nested objects/maps are rejected. It bounds nesting, array sizes, and total traversal/byte budget before any control mutation.

- Do not pass unbounded user-controlled data directly to an import method.
- Keep multi-dropdown values as `{ "High" }`, not `{ High = true }`.
- Persist normal Lua numbers or `""` for a blank numeric input.
- Use `{ NoCallbacks = true }` when loading a save file should not run user callbacks.

## Common errors

| Symptom | Cause | Fix |
| --- | --- | --- |
| `expected options table` | `Dropdown:SetOptions` received the wrong value. | Pass `{ "One", "Two" }`. |
| `expected dense options array` | A multi-dropdown config is sparse or map-shaped. | Re-export or make indexes contiguous from 1. |
| `expected finite number` | Numeric data is NaN or infinite. | Persist a normal number or blank string. |
| JSON returns `nil, error` | `HttpService` failed to encode/decode or data is invalid. | Keep current values, inspect the error, then retry with valid data. |

## Migration

Keep `ExportConfig()`/`ImportConfig()` for existing Luau-table persistence. Adopt v2 through `ExportConfigJSON()` and `ImportConfigJSON()` so older v1 consumers remain compatible.
