-- Roblox Studio / executor smoke harness.
--
-- Load the local fyyui.lua into FyyUI, then run:
--   require-or-load-this-file(FyyUI)
-- The function deliberately uses only the public API except for checking that
-- transient overlays were removed; those checks protect the lifecycle bug this
-- release fixes.
return function(FyyUI)
	assert(FyyUI.Version == "0.11.0", "library version must identify the responsive UX release")
	local callbacks = { toggle = 0, checkbox = 0, multi = 0, options = 0 }
	local menu = FyyUI.Menu({
		Title = "FyyUI hardening regression",
		Stats = false,
		Scale = 9, -- constructor must clamp to the supported range.
	})
	assert(menu:GetScale() == 1.35, "constructor scale must be clamped")
	assert(menu.Responsive and menu.CompactBreakpoint == 640 and menu.SafePadding == 12, "responsive defaults must be stable")
	assert(menu.TouchTargetSize == 36 and not menu._reducedMotion, "touch and motion defaults must be stable")
	assert(menu:ExportConfig().Version == "0.11.0", "config export must identify the responsive UX release")
	assert(not pcall(function() FyyUI.Menu({ CompactBreakpoint = 0 }) end), "invalid compact breakpoints must fail early")
	assert(not pcall(function() FyyUI.Menu({ SafePadding = -1 }) end), "invalid safe padding must fail early")
	assert(not pcall(function() FyyUI.Menu({ TouchTargetSize = math.huge }) end), "invalid touch target sizes must fail early")
	local popupShown = menu:ShowDropdownPopup(Vector2.new(0, 0), Vector2.new(36, 36), { "One" }, 0, function() end, false)
	assert(popupShown and menu._activePopupFrame, "dropdown popup must report successful UI creation")
	menu:HideDropdownPopup()

	local reducedMenu = FyyUI.Menu({
		Title = "Reduced-motion responsive regression",
		Stats = false,
		Responsive = false,
		CompactBreakpoint = 720,
		SafePadding = 16,
		TouchTargetSize = 44,
		ReducedMotion = true,
	})
	assert(not reducedMenu.Responsive and reducedMenu.CompactBreakpoint == 720 and reducedMenu.SafePadding == 16, "responsive overrides must be retained")
	assert(reducedMenu.TouchTargetSize == 44 and reducedMenu._reducedMotion, "reduced motion must be retained at menu level")
	reducedMenu:Destroy()

	local tab = menu:Tab({ Text = "Regression" })
	local toggle = tab:Toggle({ Flag = "toggle", Callback = function() callbacks.toggle += 1 end })
	local checkbox = tab:Checkbox({ Flag = "checkbox", Callback = function() callbacks.checkbox += 1 end })
	local multi = tab:Dropdown({
		Flag = "multi",
		Multi = true,
		Options = { "One", "Two" },
		Default = { "One", "Unknown" },
	})
	local single = tab:Dropdown({ Flag = "single", Options = { "One", "Two" }, Default = "One" })
	local numeric = tab:Input({ Flag = "numeric", Numeric = true, Default = "" })
	local collapsible = tab:Collapsible("Rapid toggles")
	collapsible:Toggle({ Text = "Nested" })

	assert(#multi:GetValue() == 1 and multi:GetValue()[1] == "One", "multi default must exclude unknown options")
	local rejected, rejectionDetails = menu:ImportConfig({ Values = { single = "Unknown" } })
	assert(not rejected and #rejectionDetails.Failed == 1, "rejected setter values must fail config import")
	local ok = menu:ImportConfig({ Values = { toggle = true, checkbox = true } }, { NoCallbacks = true })
	assert(ok, "valid config import should succeed")
	task.wait()
	assert(callbacks.toggle == 0 and callbacks.checkbox == 0, "NoCallbacks must suppress toggle and checkbox callbacks")

	-- An invalid import must leave every registered controller untouched.
	local atomic, atomicDetails = menu:ImportConfig({ Values = { toggle = false, single = "Unknown" } })
	assert(not atomic and #atomicDetails.Failed == 1, "invalid config must be rejected before mutation")
	assert(toggle:GetValue() == true, "invalid config import must not partially apply values")
	local malformedMulti, malformedDetails = menu:ImportConfig({ Values = { multi = { One = true } } })
	assert(not malformedMulti and #malformedDetails.Failed == 1, "multi config values must be dense arrays")
	assert(multi:GetValue()[1] == "One", "malformed multi config must not clear existing selection")

	-- Blank numeric input is a distinct user value, not the number zero.
	assert(numeric:IsEmpty(), "numeric input should start blank")
	assert(menu:ExportConfig().Values.numeric == "", "config export must preserve blank numeric inputs")
	local blankImported = menu:ImportConfig({ Values = { numeric = "" } }, { NoCallbacks = true })
	assert(blankImported and numeric:IsEmpty(), "config import must preserve blank numeric inputs")

	-- Rapid state changes must retain and replace the active tween safely.
	assert(collapsible:SetOpen(false))
	assert(collapsible:SetOpen(true))
	assert(collapsible:SetOpen(false))
	assert(collapsible:SetOpen(true))
	assert(collapsible._tween ~= nil and collapsible._isOpen, "rapid collapsible toggles must retain the final tween and state")

	-- Multi-dropdown callbacks receive an ordered snapshot, never internal selection state.
	local receivedSnapshot
	multi.Callback = function(snapshot)
		callbacks.multi += 1
		receivedSnapshot = snapshot
		snapshot[1] = "Mutated"
	end
	assert(multi:SetValue("Two"))
	task.wait()
	assert(callbacks.multi == 1 and receivedSnapshot[2] == "Two" and multi:GetValue()[1] == "One", "multi callback must receive an ordered snapshot without exposing controller state")

	multi.Callback = function() callbacks.options += 1 end
	assert(multi:SetOptions({ "One", "Two" }))
	task.wait()
	assert(callbacks.options == 0, "unchanged SetOptions must not fire a callback")
	local optionsOk, optionsErr = multi:SetOptions("invalid")
	assert(optionsOk == false and optionsErr == "expected options table", "SetOptions must validate option lists")

	assert(not pcall(function() tab:Slider({ Min = 10, Max = 0 }) end), "invalid slider bounds must fail early")
	assert(not pcall(function() tab:Slider({ Step = 0 }) end), "zero slider step must fail early")

	menu:OpenCommandPalette()
	menu:SetVisible(false)
	assert(not menu._paletteOpen and menu._paletteOverlay == nil, "hidden menu must close the command palette")

	toggle:Destroy()
	local changed, err = toggle:SetValue(false)
	assert(changed == false and err == "destroyed", "destroyed setters must be safe")
	assert(menu:ExportConfig().Values.toggle == nil, "destroyed flagged controller must not export")

	-- Factories from destroyed owners must be rejected instead of creating orphaned GUI.
	collapsible:Destroy()
	local deadNested, deadNestedErr = collapsible:Toggle({ Text = "Dead nested" })
	assert(deadNested == nil and deadNestedErr == "destroyed", "destroyed collapsibles must reject factories")
	tab:Destroy()
	local deadFactory, deadFactoryErr = tab:Toggle({ Text = "Dead tab" })
	assert(deadFactory == nil and deadFactoryErr == "destroyed", "destroyed tabs must reject factories")

	-- Repeated minimize calls must not overwrite the restoration geometry.
	local originalSize = menu.Frame.Size
	menu:_minimize()
	menu:_minimize()
	assert(menu._minPrevSize == originalSize, "minimize must be idempotent")

	menu:Destroy()
	local themeOk, themeErr = menu:SetTheme("Dark")
	assert(themeOk == false and themeErr == "destroyed", "destroyed menu theme methods must be guarded")
	local configOk, configErr = menu:ImportConfig({ Values = {} })
	assert(configOk == false and configErr == "destroyed", "destroyed menu config methods must be guarded")
	local exported, exportErr = menu:ExportConfig()
	assert(exported == nil and exportErr == "destroyed", "destroyed menu config export must be guarded")
	local scale, scaleErr = menu:GetScale()
	assert(scale == nil and scaleErr == "destroyed", "destroyed menu scale getter must be guarded")
	local setOptionsOk, setOptionsErr = multi:SetOptions({ "One" })
	assert(setOptionsOk == false and setOptionsErr == "destroyed", "destroyed dropdown options must be guarded")
	local deadTab, deadTabErr = menu:Tab({ Text = "Dead menu" })
	assert(deadTab == nil and deadTabErr == "destroyed", "destroyed menus must reject tab factories")
end
