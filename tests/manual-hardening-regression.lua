-- Roblox Studio / executor smoke harness.
--
-- Load the local fyyui.lua into FyyUI, then run:
--   require-or-load-this-file(FyyUI)
-- The function deliberately uses only the public API except for checking that
-- transient overlays were removed; those checks protect the lifecycle bug this
-- release fixes.
return function(FyyUI)
	assert(FyyUI.Version == "0.17.0", "library version must identify the premium overview release")
	local originalIconModule = FyyUI.GetIconModule()
	local remoteIconOk, remoteIconErr = FyyUI.LoadRemoteIconModule("https://example.invalid/icons.lua")
	assert(remoteIconOk == false and type(remoteIconErr) == "string", "failed remote icon loading must return an error")
	assert(
		FyyUI.GetIconModule() == originalIconModule,
		"failed remote icon loading must preserve the active icon module"
	)
	local callbacks = { toggle = 0, checkbox = 0, multi = 0, options = 0 }
	local menu = FyyUI.Menu({
		Title = "FyyUI hardening regression",
		Stats = false,
		Logo = true,
		Scale = 9, -- constructor must clamp to the supported range.
	})
	assert(menu:GetScale() == 1.35, "constructor scale must be clamped")
	assert(
		menu.Responsive and menu.CompactBreakpoint == 640 and menu.SafePadding == 12,
		"responsive defaults must be stable"
	)
	assert(menu.TouchTargetSize == 36 and not menu._reducedMotion, "touch and motion defaults must be stable")
	local legacyConfig = menu:ExportConfig()
	assert(
		legacyConfig.Schema == "FyyUI.Config.v1" and legacyConfig.Version == "0.17.0",
		"zero-argument config export must retain the v1 contract"
	)
	assert(not pcall(function()
		FyyUI.Menu({ CompactBreakpoint = 0 })
	end), "invalid compact breakpoints must fail early")
	assert(not pcall(function()
		FyyUI.Menu({ SafePadding = -1 })
	end), "invalid safe padding must fail early")
	assert(not pcall(function()
		FyyUI.Menu({ TouchTargetSize = math.huge })
	end), "invalid touch target sizes must fail early")
	assert(not pcall(function()
		FyyUI.Menu({ Stats = "invalid" })
	end), "invalid Stats configuration must fail early")
	assert(not pcall(function()
		FyyUI.Menu({ Stats = { ShowGame = "yes" } })
	end), "invalid Stats fields must fail early")
	assert(not pcall(function()
		FyyUI.Menu({ Support = { Callback = true } })
	end), "invalid Support fields must fail early")
	local overviewMenu = FyyUI.Menu({
		Title = "Overview regression",
		Stats = {
			Enabled = true,
			TabName = "Home",
			ShowProfile = true,
			ShowGame = true,
			ShowServer = true,
			ShowSupport = true,
		},
		Support = { Discord = "https://discord.gg/example" },
	})
	assert(
		overviewMenu._overviewTab
			and overviewMenu._overviewTab.Text == "Home"
			and not overviewMenu._overviewTab.Container.ScrollingEnabled
			and overviewMenu._overviewTab.Container.ScrollBarThickness == 0,
		"Stats table must create a fixed non-scrolling Overview tab"
	)
	assert(
		overviewMenu.StatusLabel == nil
			and overviewMenu._overviewTab.Container:FindFirstChild("Profile")
			and overviewMenu._overviewTab.Container:FindFirstChild("Game")
			and overviewMenu._overviewTab.Container:FindFirstChild("Server")
			and overviewMenu._overviewTab.Container:FindFirstChild("Support"),
		"Overview must replace topbar stats with the configured premium cards"
	)
	assert(
		overviewMenu._overviewTab.Container.Support:FindFirstChild("SupportButton"),
		"Discord support must use one compact custom button"
	)
	assert(overviewMenu:SetTheme("Light"), "Overview must support runtime theme changes")
	assert(
		overviewMenu._overviewTab.Container.Profile.BackgroundColor3 == overviewMenu.Theme.Element
			and overviewMenu._overviewTab.Container.Support.SupportButton.BackgroundColor3
				== overviewMenu.Theme.ElementHover,
		"Overview cards and support action must follow the active theme"
	)
	overviewMenu._overviewTab:Destroy()
	assert(
		overviewMenu._overviewTab == nil and #overviewMenu._overviewConns == 0,
		"destroying the Overview tab must disconnect its session listeners"
	)
	overviewMenu:Destroy()
	local minimalOverview = FyyUI.Menu({ Stats = true })
	assert(
		minimalOverview._overviewTab and not minimalOverview._overviewTab.Container:FindFirstChild("Support"),
		"Stats=true must create the default Overview without an empty support card"
	)
	minimalOverview:Destroy()
	local supportOnlyOverview = FyyUI.Menu({
		Stats = {
			ShowProfile = false,
			ShowGame = false,
			ShowServer = false,
			ShowSupport = true,
		},
		Support = { Callback = function() end },
	})
	local supportOnlyCard = supportOnlyOverview._overviewTab.Container:FindFirstChild("Support")
	assert(
		supportOnlyCard and supportOnlyCard.Position.Y.Offset >= 40 and supportOnlyCard.Position.Y.Offset + 56 <= 276,
		"support-only Overview must remain centered inside the fixed content area"
	)
	supportOnlyOverview:Destroy()
	local popupShown = menu:ShowDropdownPopup(
		Vector2.new(0, 0),
		Vector2.new(36, 36),
		{ "One" },
		0,
		function() end,
		false
	)
	assert(popupShown and menu._activePopupFrame, "dropdown popup must report successful UI creation")
	menu:HideDropdownPopup()
	assert(
		menu.NotifBox.Size.Y.Scale == 1 and menu.NotifBox.AnchorPoint == Vector2.new(1, 1),
		"notification stack must keep fixed bottom-anchored geometry"
	)
	local olderNotification = menu:Notify({ Title = "Older", Duration = 0 })
	local newerNotification = menu:Notify({ Title = "Newer", Duration = 0 })
	task.wait()
	assert(
		menu._activeNotifs[1].frame.Position.Y.Offset == 0 and menu._activeNotifs[2].frame.Position.Y.Offset < 0,
		"notification stack must keep the oldest card at the bottom"
	)
	assert(olderNotification:Dismiss() and newerNotification:Dismiss(), "stack setup notifications must dismiss")
	local notification = menu:Notify({ Title = "Exit regression", Content = "Position must stay frozen", Duration = 0 })
	task.wait()
	local notificationFrame = menu._activeNotifs[1] and menu._activeNotifs[1].frame
	local notificationY = notificationFrame and notificationFrame.Position.Y
	assert(notificationFrame and notification:Dismiss(), "notification dismiss must start successfully")
	assert(
		notificationFrame.Parent == menu.NotifBox
			and notificationFrame.Position.Y.Scale == notificationY.Scale
			and notificationFrame.Position.Y.Offset == notificationY.Offset,
		"exiting notifications must preserve their exact bottom-relative Y"
	)

	local reducedMenu = FyyUI.Menu({
		Title = "Reduced-motion responsive regression",
		Stats = false,
		Responsive = false,
		CompactBreakpoint = 720,
		SafePadding = 16,
		TouchTargetSize = 44,
		ReducedMotion = true,
	})
	assert(
		not reducedMenu.Responsive and reducedMenu.CompactBreakpoint == 720 and reducedMenu.SafePadding == 16,
		"responsive overrides must be retained"
	)
	assert(
		reducedMenu.TouchTargetSize == 44 and reducedMenu._reducedMotion,
		"reduced motion must be retained at menu level"
	)
	reducedMenu:Destroy()

	local tab = menu:Tab({ Text = "Regression" })
	local toggle = tab:Toggle({
		Flag = "toggle",
		Callback = function()
			callbacks.toggle += 1
		end,
	})
	local checkbox = tab:Checkbox({
		Flag = "checkbox",
		Callback = function()
			callbacks.checkbox += 1
		end,
	})
	assert(
		tab.TabButton.Selectable and tab.TabButton.SelectionOrder > 0,
		"tab navigation must expose an ordered selectable target"
	)
	assert(
		checkbox.Container.Selectable and checkbox.Container.SelectionOrder > tab.TabButton.SelectionOrder,
		"checkbox must expose an ordered whole-row selectable target"
	)
	assert(
		checkbox.Container.Active and checkbox.Container.AbsoluteSize.Y >= 24,
		"checkbox row must remain a practical touch target"
	)
	local multi = tab:Dropdown({
		Flag = "multi",
		Multi = true,
		Options = { "One", "Two" },
		Default = { "One", "Unknown" },
	})
	local single = tab:Dropdown({ Flag = "single", Options = { "One", "Two" }, Default = "One" })
	local columns = tab:Columns({ Ratio = { 1, 1 }, Gap = 8, StackOnCompact = true })
	local leftColumn = columns:Column()
	local rightColumn = columns:Column()
	assert(
		leftColumn and rightColumn and columns:Column(1) == leftColumn,
		"columns must expose independent child containers"
	)
	local columnToggle = leftColumn:Toggle({ Text = "Column toggle" })
	local columnDropdown = rightColumn:Dropdown({ Text = "Column dropdown", Options = { "One", "Two" } })
	local columnButton = rightColumn:Button({ Text = "Column button" })
	local columnSlider = leftColumn:Slider({ Text = "Column slider", Default = 50 })
	local columnPanel = leftColumn:Collapsible("Column panel", { DefaultOpen = true })
	local nestedColumnSlider = columnPanel:Slider({ Text = "Nested column slider", Description = "Track below text" })
	local nestedColumns = columnPanel:Columns({ Gap = 6 })
	assert(
		columnToggle and columnDropdown and columnPanel and nestedColumns:Column(),
		"columns must expose standard factories and support nesting inside collapsibles"
	)
	assert(
		columnSlider._inOneToOneColumn and nestedColumnSlider._inOneToOneColumn,
		"sliders under 1:1 columns must use the lower-row layout"
	)
	assert(
		columnSlider.Track.Size.X.Scale == 1 and columnSlider.Track.Position.Y.Scale == 1,
		"1:1 column slider track must span the lower row"
	)
	assert(columnDropdown.SelectBtn.Size.X.Offset == 88, "column dropdown selector must use the compact width")
	local columnButtonIcon = columnButton.Container:FindFirstChild("Pointer")
	assert(
		columnButtonIcon and columnButtonIcon.Size.X.Offset == 26 and columnButtonIcon.Size.Y.Offset == 26,
		"column button icon must use the compact size"
	)
	local nestedFromColumn = rightColumn:Columns({ Gap = 4 })
	assert(nestedFromColumn and nestedFromColumn:Column(), "columns must support nested columns directly")
	assert(columns:_isCompact() == menu._compact, "columns must follow the menu compact state")
	assert(multi:_displayText() == "One", "one multi selection must display the first selected option")
	multi:SetValue("Two", true)
	assert(multi:_displayText() == "One +1", "multi summary must display the first option plus additional count")
	multi:SetValue("One", true)
	assert(multi:_displayText() == "Two", "multi summary must remain stable in option order")
	multi:SetValue("Two", true)
	assert(multi:_displayText() == "Select...", "empty multi selection must display the placeholder")
	assert(
		single:SetValue("One", true) and single:GetValue() == "",
		"AllowNone single dropdown must unselect the active option"
	)
	assert(single:_displayText() == "Select...", "empty single selection must display the placeholder")
	local numeric = tab:Input({ Flag = "numeric", Numeric = true, Default = "" })
	local collapsible = tab:Collapsible("Rapid toggles")
	collapsible:Toggle({ Text = "Nested" })
	local collapsibleDropdown = collapsible:Dropdown({ Text = "Nested dropdown", Options = { "One", "Two" } })
	local collapsibleButton = collapsible:Button({ Text = "Nested button" })
	assert(
		collapsibleDropdown.SelectBtn.Size.X.Offset == 88,
		"collapsible dropdown selector must use the compact width"
	)
	local collapsibleButtonIcon = collapsibleButton.Container:FindFirstChild("Pointer")
	assert(
		collapsibleButtonIcon
			and collapsibleButtonIcon.Size.X.Offset == 26
			and collapsibleButtonIcon.Size.Y.Offset == 26,
		"collapsible button icon must use the compact size"
	)
	local regularSlider = collapsible:Slider({ Text = "Regular slider" })
	assert(
		not regularSlider._inOneToOneColumn and regularSlider.Track.Size.X.Scale == 0,
		"sliders outside 1:1 columns must keep the standard right-side layout"
	)
	tab:Button({ Text = "Theme regression button" })
	tab:Label({ Text = "Theme regression label" })
	tab:BoldLabel({ Text = "Theme regression bold label" })
	tab:Divider()
	collapsible:Button({ Text = "Nested theme regression button" })
	collapsible:Label({ Text = "Nested theme regression label" })
	collapsible:BoldLabel({ Text = "Nested theme regression bold label" })
	collapsible:Divider()
	assert(
		menu:SetTheme("Light") and menu:SetTheme("Amoled") and menu:SetTheme("Dark"),
		"theme switching must update lightweight and controller components without receiver mismatch"
	)

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

	-- v2 is explicitly selected, JSON-safe, and never partially mutates on malformed input.
	local v2 = menu:ExportConfig({ SchemaVersion = 2 })
	assert(
		v2.Schema == "FyyUI.Config.v2" and v2.SchemaVersion == 2 and v2.Version == "0.17.0",
		"explicit v2 export must use the versioned JSON-safe envelope"
	)
	assert(v2.Values.numeric == "", "v2 export must preserve blank numeric inputs")
	local json, jsonErr = menu:ExportConfigJSON()
	assert(type(json) == "string" and jsonErr == nil, "v2 config must export to JSON")
	local jsonImported, jsonDetails = menu:ImportConfigJSON(json, { NoCallbacks = true })
	assert(jsonImported and #jsonDetails.Failed == 0, "valid v2 JSON config must import without callbacks")
	local invalidJson, invalidJsonErr = menu:ImportConfigJSON("{", { NoCallbacks = true })
	assert(invalidJson == false and type(invalidJsonErr) == "string", "malformed JSON must be rejected safely")
	local nonStringJson, nonStringJsonErr = menu:ImportConfigJSON(123, { NoCallbacks = true })
	assert(
		nonStringJson == false and nonStringJsonErr == "Invalid config JSON: expected a string",
		"non-string JSON input must be rejected before using HttpService"
	)
	local invalidV2, invalidV2Details = menu:ImportConfig({
		Schema = "FyyUI.Config.v2",
		SchemaVersion = 2,
		Version = "0.12.0",
		Values = { toggle = false, multi = { One = true } },
	})
	assert(
		invalidV2 == false and type(invalidV2Details) == "string",
		"invalid v2 arrays must be rejected before applying values"
	)
	assert(
		toggle:GetValue() == true and multi:GetValue()[1] == "One",
		"invalid v2 config must preserve all existing values"
	)
	local configChunk = string.rep("x", 16 * 1024)
	local oversizedV2, oversizedV2Err = menu:ImportConfig({
		Schema = "FyyUI.Config.v2",
		SchemaVersion = 2,
		Version = "0.12.0",
		Values = {
			toggle = false,
			one = configChunk,
			two = configChunk,
			three = configChunk,
			four = configChunk,
			five = configChunk,
		},
	})
	assert(
		oversizedV2 == false and type(oversizedV2Err) == "string",
		"direct v2 imports must enforce a cumulative size budget before mutation"
	)
	assert(toggle:GetValue() == true, "oversized direct v2 config must not partially apply values")

	-- Rapid state changes must retain and replace the active tween safely.
	assert(collapsible:SetOpen(false))
	assert(collapsible:SetOpen(true))
	assert(collapsible:SetOpen(false))
	assert(collapsible:SetOpen(true))
	assert(
		collapsible._tween ~= nil and collapsible._isOpen,
		"rapid collapsible toggles must retain the final tween and state"
	)

	-- Multi-dropdown callbacks receive an ordered snapshot, never internal selection state.
	local receivedSnapshot
	multi.Callback = function(snapshot)
		callbacks.multi += 1
		receivedSnapshot = snapshot
		snapshot[1] = "Mutated"
	end
	assert(multi:SetValue("Two"))
	task.wait()
	assert(
		callbacks.multi == 1 and receivedSnapshot[2] == "Two" and multi:GetValue()[1] == "One",
		"multi callback must receive an ordered snapshot without exposing controller state"
	)

	multi.Callback = function()
		callbacks.options += 1
	end
	assert(multi:SetOptions({ "One", "Two" }))
	task.wait()
	assert(callbacks.options == 0, "unchanged SetOptions must not fire a callback")
	local optionsOk, optionsErr = multi:SetOptions("invalid")
	assert(optionsOk == false and optionsErr == "expected options table", "SetOptions must validate option lists")

	assert(not pcall(function()
		tab:Slider({ Min = 10, Max = 0 })
	end), "invalid slider bounds must fail early")
	assert(not pcall(function()
		tab:Slider({ Step = 0 })
	end), "zero slider step must fail early")

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
	if menu._minFrame then
		assert(menu._minFrame.Position == menu._minInitialPos, "first floating icon position must be left-center")
		menu._minGui.Enabled = true
		menu.Gui.Enabled = false
		menu:_restore()
		assert(menu._restoring and not menu._minFrame.Active, "floating icon must disable immediately during restore")
		task.wait(0.14)
		assert(not menu._minGui.Enabled, "floating icon must hide before menu restore finishes")
	end

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
