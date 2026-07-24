--[[ Menu ]]
local Menu = {}
Menu.__index = Menu

function Menu:_viewportSize()
	local camera = workspace.CurrentCamera
	return camera and camera.ViewportSize or Vector2.new(1920, 1080)
end

-- All menu-owned transient UI transitions pass through this helper so reduced
-- motion is consistently instant without changing public component APIs.
function Menu:_transition(instance, duration, properties, style, direction, onCompleted)
	if not instance then
		return nil
	end
	if self._reducedMotion then
		for property, value in pairs(properties) do
			instance[property] = value
		end
		if onCompleted then
			onCompleted()
		end
		return nil
	end
	local tween = game:GetService("TweenService"):Create(
		instance,
		TweenInfo.new(duration, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out),
		properties
	)
	if onCompleted then
		tween.Completed:Connect(onCompleted)
	end
	tween:Play()
	return tween
end

-- Selection is opt-in and menu-scoped: never replace text entry or keybind capture.
function Menu:_nextSelectionOrder()
	self._selectionOrder = (self._selectionOrder or 0) + 1
	return self._selectionOrder
end

function Menu:_makeSelectable(instance)
	if not instance then
		return instance
	end
	instance.Selectable = true
	instance.Active = true
	instance.SelectionOrder = self:_nextSelectionOrder()
	return instance
end

function Menu:_selectionIsAvailable()
	if self._destroyed or self._capturingKeybind then
		return false
	end
	return game:GetService("UserInputService"):GetFocusedTextBox() == nil
end

function Menu:_isGamepadNavigation()
	return tostring(game:GetService("UserInputService"):GetLastInputType()):find("Gamepad", 1, true) ~= nil
end

function Menu:_beginTransientFocus(fallback)
	if not self:_selectionIsAvailable() or not self:_isGamepadNavigation() then
		return nil
	end
	local selected = game:GetService("GuiService").SelectedObject
	if selected and self.Gui and selected:IsDescendantOf(self.Gui) then
		return selected
	end
	return fallback
end

function Menu:_restoreTransientFocus(target)
	if not target or not target.Parent or not self:_selectionIsAvailable() then
		return
	end
	game:GetService("GuiService").SelectedObject = target
end

function Menu:_modalSize(preferredWidth, preferredHeight, minimumWidth, minimumHeight)
	local viewport = self:_viewportSize()
	local usableWidth = math.max(1, viewport.X - self.SafePadding * 2)
	local usableHeight = math.max(1, viewport.Y - self.SafePadding * 2)
	return math.min(preferredWidth, math.max(math.min(minimumWidth, usableWidth), usableWidth)),
		math.min(preferredHeight, math.max(math.min(minimumHeight, usableHeight), usableHeight))
end

function Menu:_applyResponsiveLayout()
	if self._destroyed or not self.Frame then
		return
	end
	local viewport = self:_viewportSize()
	local safe = self.SafePadding
	local scale = self.Scale or 1
	local usableWidth = math.max(1, (viewport.X - safe * 2) / scale)
	local usableHeight = math.max(1, (viewport.Y - safe * 2) / scale)
	local baseSize = self._responsiveBaseSize or self.Frame.Size
	local needsCompact = self.Responsive
		and (
			viewport.X <= self.CompactBreakpoint
			or baseSize.X.Offset > usableWidth
			or baseSize.Y.Offset > usableHeight
		)
	self._compact = needsCompact
	if not self.Responsive then
		return
	end
	if self._activePopupFrame then
		self:HideDropdownPopup()
	end

	if self.Maximized then
		self.Frame.Size = UDim2.fromOffset(usableWidth, usableHeight)
		self.Frame.Position = UDim2.fromOffset(safe, safe)
		self._responsiveApplied = true
	elseif needsCompact then
		self.Frame.Size =
			UDim2.fromOffset(math.min(baseSize.X.Offset, usableWidth), math.min(baseSize.Y.Offset, usableHeight))
		self.Frame.Position = UDim2.fromOffset(safe, safe)
		self._responsiveApplied = true
	elseif self._responsiveApplied then
		self.Frame.Size = baseSize
		self.Frame.Position = self._responsiveBasePosition or self._initialPos
		self._responsiveApplied = false
	end
	local sidebarWidth = needsCompact and math.min(self.Theme.SidebarWidth, 86) or self.Theme.SidebarWidth
	if self.Sidebar and self.ContentArea then
		self.Sidebar.Size = UDim2.new(0, sidebarWidth, 1, -(self.Theme.TopbarHeight + 4))
		self.ContentArea.Size = UDim2.new(1, -(sidebarWidth + 8), 1, -(self.Theme.TopbarHeight + 6))
		self.ContentArea.Position = UDim2.new(0, sidebarWidth + 6, 0, self.Theme.TopbarHeight + 4)
		if self.SidebarLine then
			self.SidebarLine.Position = UDim2.new(0, sidebarWidth + 4, 0, self.Theme.TopbarHeight + 6)
		end
	end
	if self.Minimized then
		self._minPrevSize = self.Frame.Size
		self._minPrevPos = self.Frame.Position
	end

	if self._updateShadow then
		self._updateShadow()
	end
	if self._tooltipActive then
		self:_updateTooltipPosition()
	end
	if self.NotifBox then
		self.NotifBox.Size = UDim2.new(0, math.min(320, viewport.X - safe * 2), 1, -(safe * 2))
		self.NotifBox.Position = UDim2.new(1, -safe, 1, -safe)
	end
	if self._paletteFrame then
		local palW, palH = self:_modalSize(380, 310, 180, 180)
		self._paletteFrame.Size = UDim2.fromOffset(palW, palH)
	end
end

function Menu:_bindResponsiveViewport()
	if not self.Responsive then
		return
	end
	local function bindCamera(camera)
		if self._cameraViewportCon then
			self._cameraViewportCon:Disconnect()
			self._cameraViewportCon = nil
		end
		if camera then
			self._cameraViewportCon = camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
				self:_applyResponsiveLayout()
			end)
		end
		self:_applyResponsiveLayout()
	end
	self._cameraCon = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
		if not self._destroyed then
			bindCamera(workspace.CurrentCamera)
		end
	end)
	bindCamera(workspace.CurrentCamera)
end

function Menu.new(options, theme)
	local self = setmetatable({}, Menu)
	self.Options = options
	self.Theme = theme
	assert(
		options.Stats == nil or type(options.Stats) == "boolean" or type(options.Stats) == "table",
		"FyyUI Menu: Stats must be a boolean or table"
	)
	assert(options.Support == nil or type(options.Support) == "table", "FyyUI Menu: Support must be a table")
	local statsOptions = type(options.Stats) == "table" and options.Stats or {}
	assert(
		statsOptions.Enabled == nil or type(statsOptions.Enabled) == "boolean",
		"FyyUI Menu: Stats.Enabled must be a boolean"
	)
	assert(
		statsOptions.TabName == nil or (type(statsOptions.TabName) == "string" and statsOptions.TabName ~= ""),
		"FyyUI Menu: Stats.TabName must be a non-empty string"
	)
	for _, key in ipairs({ "ShowProfile", "ShowGame", "ShowServer", "ShowSupport" }) do
		assert(
			statsOptions[key] == nil or type(statsOptions[key]) == "boolean",
			("FyyUI Menu: Stats.%s must be a boolean"):format(key)
		)
	end
	local supportOptions = options.Support or {}
	for _, key in ipairs({ "Title", "Description", "ButtonText", "Discord" }) do
		assert(
			supportOptions[key] == nil or type(supportOptions[key]) == "string",
			("FyyUI Menu: Support.%s must be a string"):format(key)
		)
	end
	assert(
		supportOptions.ButtonIcon == nil
			or type(supportOptions.ButtonIcon) == "string"
			or type(supportOptions.ButtonIcon) == "number"
			or type(supportOptions.ButtonIcon) == "table",
		"FyyUI Menu: Support.ButtonIcon must be a supported icon value"
	)
	assert(
		supportOptions.Callback == nil or type(supportOptions.Callback) == "function",
		"FyyUI Menu: Support.Callback must be a function"
	)
	self.StatsConfig = {
		Enabled = options.Stats == true or (type(options.Stats) == "table" and statsOptions.Enabled ~= false),
		TabName = statsOptions.TabName or "Overview",
		TabIcon = statsOptions.TabIcon or "user-round",
		ShowProfile = statsOptions.ShowProfile ~= false,
		ShowGame = statsOptions.ShowGame ~= false,
		ShowServer = statsOptions.ShowServer ~= false,
		ShowSupport = statsOptions.ShowSupport ~= false,
	}
	self.SupportConfig = supportOptions
	self.Tabs = {}
	self._flagRegistry = {}
	self._keybindList = {}
	self._capturingKeybind = nil
	self._selectionOrder = 0
	-- Command Palette state
	self._paletteOpen = false
	self._paletteOverlay = nil
	self._paletteFrame = nil
	self._paletteSearchBox = nil
	self._paletteResults = nil
	self._paletteEmpty = nil
	self._paletteIndex = {}
	self._paletteFilteredResults = {}
	self._paletteResultButtons = {}
	self._paletteSelectedIndex = 0
	self._overviewConns = {}
	self.Minimized = false
	self._restoring = false
	self._minimizeToken = 0
	local paletteMaxResults = options.PaletteMaxResults == nil and 60 or options.PaletteMaxResults
	assert(
		isFiniteNumber(paletteMaxResults) and paletteMaxResults >= 1,
		"FyyUI Menu: PaletteMaxResults must be a positive number"
	)
	self._paletteMaxResults = math.floor(paletteMaxResults)
	self._paletteConns = {}
	self.ActiveTab = nil
	self.Visible = options.Visible ~= false
	self.MinSize = options.MinSize or Vector2.new(320, 300)
	self.MaxSize = options.MaxSize or Vector2.new(850, 560)
	assert(
		typeof(self.MinSize) == "Vector2" and typeof(self.MaxSize) == "Vector2",
		"FyyUI Menu: MinSize and MaxSize must be Vector2 values"
	)
	assert(
		isFiniteNumber(self.MinSize.X) and isFiniteNumber(self.MinSize.Y) and self.MinSize.X > 0 and self.MinSize.Y > 0,
		"FyyUI Menu: MinSize must be positive"
	)
	assert(
		isFiniteNumber(self.MaxSize.X)
			and isFiniteNumber(self.MaxSize.Y)
			and self.MaxSize.X >= self.MinSize.X
			and self.MaxSize.Y >= self.MinSize.Y,
		"FyyUI Menu: MaxSize must be at least MinSize"
	)
	self.Resizable = options.Resizable or false
	assert(
		options.Responsive == nil or type(options.Responsive) == "boolean",
		"FyyUI Menu: Responsive must be a boolean"
	)
	self.Responsive = options.Responsive ~= false
	local compactBreakpoint = options.CompactBreakpoint == nil and 640 or options.CompactBreakpoint
	assert(
		isFiniteNumber(compactBreakpoint) and compactBreakpoint > 0,
		"FyyUI Menu: CompactBreakpoint must be a positive finite number"
	)
	self.CompactBreakpoint = math.floor(compactBreakpoint)
	self._compact = false
	local safePadding = options.SafePadding == nil and 12 or options.SafePadding
	assert(
		isFiniteNumber(safePadding) and safePadding >= 0,
		"FyyUI Menu: SafePadding must be a non-negative finite number"
	)
	self.SafePadding = safePadding
	local touchTargetSize = options.TouchTargetSize == nil and 36 or options.TouchTargetSize
	assert(
		isFiniteNumber(touchTargetSize) and touchTargetSize >= 24,
		"FyyUI Menu: TouchTargetSize must be a finite number of at least 24"
	)
	self.TouchTargetSize = math.floor(touchTargetSize)
	local requestedScale = options.Scale == nil and 1 or options.Scale
	assert(isFiniteNumber(requestedScale), "FyyUI Menu: Scale must be a finite number")
	self.Scale = math.clamp(requestedScale, 0.75, 1.35)
	assert(
		options.ReducedMotion == nil or type(options.ReducedMotion) == "boolean",
		"FyyUI Menu: ReducedMotion must be a boolean"
	)
	self._reducedMotion = options.ReducedMotion == true

	-- Tooltip state
	self._tooltips = {}
	self._tooltipActive = false
	self._tooltipPending = false
	self._tooltipTarget = nil
	self._tooltipTween = nil
	self._mousePos = Vector2.new(0, 0)

	local size
	if options.Size then
		assert(typeof(options.Size) == "UDim2", "FyyUI Menu: Size must be a UDim2")
		local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
		size = Vector2.new(
			options.Size.X.Offset + options.Size.X.Scale * viewport.X,
			options.Size.Y.Offset + options.Size.Y.Scale * viewport.Y
		)
	else
		size = Vector2.new(645, 365)
	end
	size = Vector2.new(
		math.clamp(size.X, self.MinSize.X, self.MaxSize.X),
		math.clamp(size.Y, self.MinSize.Y, self.MaxSize.Y)
	)
	local pos = options.Position or UDim2.new(0.5, -size.X / 2, 0.5, -size.Y / 2)
	self._initialSize = UDim2.fromOffset(size.X, size.Y)
	self._initialPos = pos
	self._responsiveBaseSize = self._initialSize
	self._responsiveBasePosition = pos

	self.GuiParent = options.Parent or game:GetService("CoreGui")

	self.Gui = U.Create("ScreenGui", {
		Name = options.Title or "FyyUI",
		DisplayOrder = 100,
		IgnoreGuiInset = true,
		Enabled = self.Visible,
	})

	self.Frame = U.Create("Frame", {
		Name = "Main",
		Size = UDim2.fromOffset(size.X, size.Y),
		Position = pos,
		BackgroundColor3 = theme.Background,
		BackgroundTransparency = options.BackgroundTransparency or (options.Transparent and 0.15 or 0),
		BorderSizePixel = 0,
		Parent = self.Gui,
	})
	self._baseBackgroundTransparency = self.Frame.BackgroundTransparency
	U.Create("UICorner", { CornerRadius = UDim.new(0, theme.CornerRadius), Parent = self.Frame })

	self._uiScale = U.Create("UIScale", { Parent = self.Frame, Scale = self.Scale })

	if options.HasOutline ~= false then
		U.Create("UIStroke", {
			Color = theme.Outline,
			Thickness = 1,
			Transparency = 0.25,
			Parent = self.Frame,
		})
	end

	if options.Shadow then
		local shadowFrame = U.Create("Frame", {
			Name = "Shadow",
			Size = UDim2.fromOffset(size.X + 16, size.Y + 16),
			Position = UDim2.fromOffset(-8, -8),
			BackgroundColor3 = theme.Shadow,
			BackgroundTransparency = 0.55,
			BorderSizePixel = 0,
			ZIndex = 0,
			Parent = self.Gui,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, theme.CornerRadius + 2), Parent = shadowFrame })
		self._shadow = shadowFrame
		self._updateShadow = function()
			if not self._shadow then
				return
			end
			local s = self.Frame.Size
			self._shadow.Size = UDim2.fromOffset(s.X.Offset + 16, s.Y.Offset + 16)
			self._shadow.Position = UDim2.fromOffset(self.Frame.Position.X.Offset - 8, self.Frame.Position.Y.Offset - 8)
		end
	end

	-- Topbar
	self.Topbar = U.Create("Frame", {
		Name = "Topbar",
		Size = UDim2.new(1, 0, 0, theme.TopbarHeight),
		BackgroundColor3 = theme.Topbar,
		BorderSizePixel = 0,
		Parent = self.Frame,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(0, theme.CornerRadius), Parent = self.Topbar })
	U.Create("Frame", {
		Name = "Fill",
		Size = UDim2.new(1, 0, 0, theme.CornerRadius),
		Position = UDim2.new(0, 0, 1, -theme.CornerRadius),
		BackgroundColor3 = theme.Topbar,
		BorderSizePixel = 0,
		Parent = self.Topbar,
	})

	local topCfg = options.Topbar or {}
	local btnType = topCfg.ButtonsType or "Default"
	local titleAlign = topCfg.TitleAlignment or "Left"
	local leftMargin = 10
	local rightMargin = 10

	-- Mac / Close buttons
	if btnType == "Mac" then
		local btnColors = {
			Close = Color3.fromRGB(255, 95, 87),
			Minimize = Color3.fromRGB(255, 189, 46),
			Maximize = Color3.fromRGB(39, 201, 63),
		}
		local btnSize = 12
		local hitSize = 44
		local spacing = 4

		local macIconNames = { Close = "x", Minimize = "minus", Maximize = "scan" }
		local function macBtn(name, color, action)
			local b = U.Create("ImageButton", {
				Name = name,
				Size = UDim2.fromOffset(hitSize, hitSize),
				Position = UDim2.new(0, rightMargin, 0, 0),
				BackgroundTransparency = 1,
				AutoButtonColor = false,
				Parent = self.Topbar,
			})
			self:_makeSelectable(b)
			local dot = U.Create("Frame", {
				Name = "Dot",
				Size = UDim2.fromOffset(btnSize, btnSize),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = color,
				BorderSizePixel = 0,
				Parent = b,
			})
			U.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = dot })
			renderIcon(b, macIconNames[name], {
				Name = "Icon",
				Size = UDim2.fromOffset(8, 8),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				ImageColor3 = Color3.fromRGB(60, 60, 72),
			})
			b.Activated:Connect(action)
			rightMargin = rightMargin + hitSize + spacing
			return b
		end

		macBtn("Close", btnColors.Close, function()
			self:_confirmClose()
		end)
		macBtn("Minimize", btnColors.Minimize, function()
			if self.Minimized then
				self:_restore()
			else
				self:_minimize()
			end
		end)
		macBtn("Maximize", btnColors.Maximize, function()
			self:_toggleMaximize()
		end)

		leftMargin = rightMargin + 8
		rightMargin = 10
	else
		local WIN_ICONS = {
			Minimize = "rbxassetid://118026365011536",
			Maximize = "rbxassetid://123104789658180",
			Close = "rbxassetid://110786993356448",
		}
		local function winBtn(name, action, xOff, hoverC)
			local b = U.Create("ImageButton", {
				Name = name,
				Size = UDim2.fromOffset(44, 44),
				Position = UDim2.new(1, xOff, 0, 0),
				BackgroundTransparency = 1,
				AutoButtonColor = false,
				Parent = self.Topbar,
			})
			self:_makeSelectable(b)
			U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = b })
			local icon = U.Create("ImageLabel", {
				Name = "Icon",
				Size = UDim2.fromOffset(18, 18),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				ImageColor3 = Color3.fromRGB(150, 150, 165),
				Image = WIN_ICONS[name],
				Parent = b,
			})
			b.MouseEnter:Connect(function()
				b.BackgroundTransparency = 0
				b.BackgroundColor3 = hoverC
				icon.ImageColor3 = Color3.fromRGB(225, 225, 235)
			end)
			b.MouseLeave:Connect(function()
				b.BackgroundTransparency = 1
				icon.ImageColor3 = Color3.fromRGB(150, 150, 165)
			end)
			b.Activated:Connect(action)
			return b
		end
		-- Helper: reset window button hover states
		local function resetWinHover()
			for _, child in ipairs(self.Topbar:GetChildren()) do
				if child:IsA("ImageButton") then
					child.BackgroundTransparency = 1
					local ic = child:FindFirstChild("Icon")
					if ic then
						ic.ImageColor3 = Color3.fromRGB(150, 150, 165)
					end
				end
			end
		end
		winBtn("Close", function()
			self:_confirmClose()
		end, -44, Color3.fromRGB(200, 60, 60))
		winBtn("Maximize", function()
			resetWinHover()
			self:_toggleMaximize()
		end, -88, Color3.fromRGB(45, 45, 55))
		winBtn("Minimize", function()
			if self.Minimized then
				resetWinHover()
				self:_restore()
			else
				self:_minimize()
			end
		end, -132, Color3.fromRGB(45, 45, 55))
	end

	-- Logo image for floating minimize icon (true=default, string=custom, nil=false)
	local _logoImage = options.Logo == true and "rbxassetid://90051950241069"
		or type(options.Logo) == "string" and options.Logo
		or nil

	self.TitleLogo = U.Create("ImageLabel", {
		Name = "TitleLogo",
		Size = UDim2.fromOffset(22, 22),
		Position = UDim2.fromOffset(leftMargin + 12, math.floor((theme.TopbarHeight - 22) / 2)),
		BackgroundTransparency = 1,
		Image = "rbxassetid://90892630150011",
		ScaleType = Enum.ScaleType.Fit,
		Parent = self.Topbar,
	})

	-- Title
	self._titleText = options.Title or "FyyUI"
	local titleX = leftMargin + 42
	local titleSize = 17
	local titleGap = 5
	self.TitleAccent = U.Create("TextLabel", {
		Name = "TitleAccent",
		Size = UDim2.fromOffset(30, theme.TopbarHeight),
		Position = UDim2.fromOffset(titleX, 0),
		BackgroundTransparency = 1,
		Text = "Fyy",
		Font = Enum.Font.BuilderSansExtraBold,
		TextSize = titleSize,
		TextColor3 = theme.Accent,
		TextXAlignment = Enum.TextXAlignment.Left,
		Visible = false,
		Parent = self.Topbar,
	})
	self.Title = U.Create("TextLabel", {
		Name = "Title",
		Size = UDim2.new(1, -(titleX + 40), 1, 0),
		Position = UDim2.fromOffset(titleX, 0),
		BackgroundTransparency = 1,
		Text = "",
		Font = Enum.Font.BuilderSansBold,
		TextSize = titleSize,
		TextColor3 = theme.TextPrimary,
		TextXAlignment = titleAlign == "Right" and Enum.TextXAlignment.Right or Enum.TextXAlignment.Left,
		Parent = self.Topbar,
	})
	self._refreshTitle = function()
		local branded = titleAlign ~= "Right" and self._titleText:sub(1, 3):lower() == "fyy"
		self._titleBranded = branded
		self.TitleAccent.Visible = branded
		if branded then
			local remainder = self._titleText:sub(4):gsub("^%s+", "")
			self.TitleAccent.Text = self._titleText:sub(1, 3)
			self.Title.Text = remainder
			self.Title.Position = UDim2.fromOffset(titleX + 30 + titleGap, 0)
			self.Title.Size = UDim2.new(1, -(titleX + 30 + titleGap + 40), 1, 0)
		else
			self.Title.Text = self._titleText
			self.Title.Position = UDim2.fromOffset(titleX, 0)
			self.Title.Size = UDim2.new(1, -(titleX + 40), 1, 0)
		end
	end
	self._refreshTitle()

	-- Accent line under topbar
	self.AccentLine = U.Create("Frame", {
		Name = "AccentLine",
		Size = UDim2.new(1, -20, 0, 2),
		Position = UDim2.new(0, 10, 1, 0),
		BackgroundColor3 = theme.AccentLine,
		BorderSizePixel = 0,
		Parent = self.Topbar,
	})
	self.Topbar.MouseEnter:Connect(function()
		if self.AccentLine then
			self.AccentLine.BackgroundColor3 = theme.Accent
		end
	end)
	self.Topbar.MouseLeave:Connect(function()
		if self.AccentLine then
			self.AccentLine.BackgroundColor3 = theme.AccentLine
		end
	end)

	-- Sidebar
	local sbw = theme.SidebarWidth
	self.Sidebar = U.Create("Frame", {
		Name = "Sidebar",
		Size = UDim2.new(0, sbw, 1, -(theme.TopbarHeight + 4)),
		Position = UDim2.new(0, 2, 0, theme.TopbarHeight + 4),
		BackgroundColor3 = theme.Sidebar,
		BorderSizePixel = 0,
		Parent = self.Frame,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = self.Sidebar })

	self.SidebarList = U.Create("ScrollingFrame", {
		Name = "TabList",
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.fromOffset(0, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 0,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Parent = self.Sidebar,
	})
	local sidebarListLayout = U.Create("UIListLayout", {
		Padding = UDim.new(0, 2),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = self.SidebarList,
	})
	sidebarListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		if self.SidebarList then
			self.SidebarList.CanvasSize = UDim2.new(0, 0, 0, sidebarListLayout.AbsoluteContentSize.Y)
		end
	end)

	-- Track SidebarList scroll to keep ActiveBar aligned with active tab
	self._sidebarScrollCon = self.SidebarList:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
		if self.ActiveTab and self.ActiveBar and self.SidebarList then
			self:_positionActiveBar(self.ActiveTab, false)
		end
	end)

	-- Shared ActiveBar — slides vertically between tabs (parented to Sidebar, NOT SidebarList, to avoid UIListLayout interference)
	self.ActiveBar = U.Create("Frame", {
		Name = "ActiveBar",
		Size = UDim2.fromOffset(4, 20),
		Position = UDim2.fromOffset(5, 0),
		BackgroundTransparency = 1,
		BackgroundColor3 = theme.Accent,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = self.Sidebar,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = self.ActiveBar })

	-- Content Area
	self.ContentArea = U.Create("Frame", {
		Name = "Content",
		Size = UDim2.new(1, -(sbw + 8), 1, -(theme.TopbarHeight + 6)),
		Position = UDim2.new(0, sbw + 6, 0, theme.TopbarHeight + 4),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Parent = self.Frame,
	})

	-- Track active dropdown popup (created/destroyed on demand)
	self._activePopupFrame = nil
	self._popupUISCon = nil

	-- Separator line between sidebar and content
	self.SidebarLine = U.Create("Frame", {
		Name = "SidebarLine",
		Size = UDim2.new(0, 1, 1, -(theme.TopbarHeight + 10)),
		Position = UDim2.new(0, sbw + 4, 0, theme.TopbarHeight + 6),
		BackgroundColor3 = theme.Border,
		BackgroundTransparency = 0.5,
		BorderSizePixel = 0,
		ZIndex = 1,
		Parent = self.Frame,
	})

	-- Notification (screen-level, bottom-right)
	self._notifGui = U.Create("ScreenGui", {
		Name = "FyyUI_Notifs",
		DisplayOrder = 200,
		IgnoreGuiInset = true,
		Enabled = self.Visible,
		Parent = self.GuiParent,
	})
	self.NotifBox = U.Create("Frame", {
		Name = "Notifications",
		Size = UDim2.new(0, 320, 1, -(self.SafePadding * 2)),
		Position = UDim2.new(1, -self.SafePadding, 1, -self.SafePadding),
		AnchorPoint = Vector2.new(1, 1),
		BackgroundTransparency = 1,
		ZIndex = 50,
		Parent = self._notifGui,
	})
	self._activeNotifs = {}

	-- Floating minimize icon (only if Logo is set)
	if _logoImage then
		self._minGui = U.Create("ScreenGui", {
			Name = "FyyUI_Min",
			DisplayOrder = 999,
			ResetOnSpawn = false,
			Enabled = false,
		})
		local iconSize = 50
		self._minInitialPos = UDim2.new(0, 16, 0.5, -(iconSize / 2))
		self._minFrame = U.Create("ImageButton", {
			Name = "MinIcon",
			Size = UDim2.fromOffset(iconSize, iconSize),
			Position = self._minInitialPos,
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Active = true,
			Parent = self._minGui,
		})
		self._minScale = U.Create("UIScale", { Parent = self._minFrame, Scale = 1 })
		U.Create("UICorner", { CornerRadius = UDim.new(0, 12), Parent = self._minFrame })
		U.Create("UIStroke", { Color = theme.Accent, Thickness = 2, Parent = self._minFrame })
		local minIcon = U.Create("ImageLabel", {
			Name = "Icon",
			Size = UDim2.new(1, -4, 1, -4),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Image = _logoImage,
			ScaleType = Enum.ScaleType.Fit,
			Parent = self._minFrame,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = minIcon })

		-- Dragging with click/drag distinction
		local dragging, dragStart, startPos, didDrag
		self._minFrame.InputBegan:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
				if self._restoring then
					return
				end
				dragging = true
				didDrag = false
				dragStart = i.Position
				startPos = self._minFrame.Position
			end
		end)
		self._minFrame.InputEnded:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
				dragging = false
				if not didDrag then
					self:_restore()
				end
			end
		end)
		self._minDragInputCon = game:GetService("UserInputService").InputChanged:Connect(function(i)
			if
				dragging
				and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch)
			then
				local delta = i.Position - dragStart
				if delta.Magnitude > 5 then
					didDrag = true
				end
				self._minFrame.Position = UDim2.new(
					startPos.X.Scale,
					startPos.X.Offset + delta.X,
					startPos.Y.Scale,
					startPos.Y.Offset + delta.Y
				)
				self._minSavedPos = self._minFrame.Position
			end
		end)
	else
		-- No-logo restore affordance: floating button to restore from minimized state
		self._noLogoRestoreGui = U.Create("ScreenGui", {
			Name = "FyyUI_NoLogoRestore",
			DisplayOrder = 999,
			ResetOnSpawn = false,
			Enabled = false,
		})
		self._noLogoRestoreBtn = U.Create("TextButton", {
			Name = "RestoreBtn",
			Size = UDim2.fromOffset(50, 50),
			Position = UDim2.new(0.5, -25, 0.5, -25),
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0,
			Text = "☰",
			Font = Enum.Font.GothamBold,
			TextSize = 24,
			TextColor3 = theme.TextPrimary,
			AutoButtonColor = false,
			Parent = self._noLogoRestoreGui,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 12), Parent = self._noLogoRestoreBtn })
		U.Create("UIStroke", { Color = theme.Accent, Thickness = 2, Parent = self._noLogoRestoreBtn })
		-- No-logo drag parity: allow repositioning the restore button
		local nlDragging, nlDragStart, nlStartPos, nlDidDrag
		self._noLogoRestoreBtn.InputBegan:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
				if self._restoring then
					return
				end
				nlDragging = true
				nlDidDrag = false
				nlDragStart = i.Position
				nlStartPos = self._noLogoRestoreBtn.Position
			end
		end)
		self._noLogoRestoreBtn.InputEnded:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
				nlDragging = false
				if not nlDidDrag then
					self:_restore()
				end
			end
		end)
		self._noLogoDragCon = game:GetService("UserInputService").InputChanged:Connect(function(i)
			if
				nlDragging
				and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch)
			then
				local delta = i.Position - nlDragStart
				if delta.Magnitude > 5 then
					nlDidDrag = true
				end
				self._noLogoRestoreBtn.Position = UDim2.new(
					nlStartPos.X.Scale,
					nlStartPos.X.Offset + delta.X,
					nlStartPos.Y.Scale,
					nlStartPos.Y.Offset + delta.Y
				)
				self._noLogoSavedPos = self._noLogoRestoreBtn.Position
			end
		end)
	end

	-- Tooltip label (reusable, hidden by default, high ZIndex to float above content)
	self._tooltipLabel = U.Create("TextLabel", {
		Name = "Tooltip",
		Size = UDim2.fromOffset(0, 0),
		BackgroundColor3 = theme.Element,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 50000,
		Visible = false,
		Text = "",
		Font = theme.Font,
		TextSize = theme.FontSize,
		TextColor3 = theme.TextPrimary,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		RichText = true,
		Parent = self.Frame,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = self._tooltipLabel })
	U.Create("UIStroke", { Color = theme.Outline, Thickness = 1, Transparency = 0.25, Parent = self._tooltipLabel })

	self:_dragging()

	self.Gui.Parent = self.GuiParent
	self:_bindResponsiveViewport()

	if self.Resizable then
		self:_resizable()
	end

	-- Keybind service router (single UIS connection for all keybinds)
	do
		local uis = game:GetService("UserInputService")
		self._keybindInputCon = uis.InputBegan:Connect(function(input, gpe)
			-- Ctrl+K: toggle command palette (before capture/gpe checks)
			if
				self.Visible
				and not self.Minimized
				and not self._capturingKeybind
				and input.UserInputType == Enum.UserInputType.Keyboard
				and input.KeyCode == Enum.KeyCode.K
				and (uis:IsKeyDown(Enum.KeyCode.LeftControl) or uis:IsKeyDown(Enum.KeyCode.RightControl))
			then
				local focusedBox = uis:GetFocusedTextBox()
				if focusedBox and focusedBox ~= self._paletteSearchBox then
					return
				end
				self:ToggleCommandPalette()
				return
			end

			-- Capture mode: intercept input for the capturing keybind
			if self._capturingKeybind then
				local kb = self._capturingKeybind
				-- Escape cancels capture
				if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Escape then
					kb:_exitCapture()
					return
				end
				-- Only capture keyboard keys and mouse buttons
				if
					input.UserInputType == Enum.UserInputType.Keyboard
					or input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.MouseButton2
					or input.UserInputType == Enum.UserInputType.MouseButton3
				then
					kb:_setFromInput(input)
					kb:_exitCapture()
				end
				return
			end

			-- When palette is open, let it handle navigation keys
			if self._paletteOpen and input.UserInputType == Enum.UserInputType.Keyboard then
				local k = input.KeyCode
				if
					k == Enum.KeyCode.Up
					or k == Enum.KeyCode.Down
					or k == Enum.KeyCode.Return
					or k == Enum.KeyCode.Escape
				then
					return
				end
			end

			-- Normal routing: skip if GUI processed the event (TextBox focused etc)
			if gpe then
				return
			end

			-- Route input to matching keybinds
			for _, kb in ipairs(self._keybindList) do
				if kb._keyCode then
					local match = false
					if input.UserInputType == Enum.UserInputType.Keyboard and kb._inputType == "Keyboard" then
						match = input.KeyCode == kb._keyCode
					elseif kb._inputType == "MouseButton" then
						match = input.UserInputType == kb._keyCode
					end
					if match then
						kb:_onInput(input)
					end
				end
			end
		end)

		self._keybindEndCon = uis.InputEnded:Connect(function(input, gpe)
			if gpe then
				return
			end
			for _, kb in ipairs(self._keybindList) do
				if kb.Mode == "Hold" and kb._keyCode then
					local match = false
					if input.UserInputType == Enum.UserInputType.Keyboard and kb._inputType == "Keyboard" then
						match = input.KeyCode == kb._keyCode
					elseif kb._inputType == "MouseButton" then
						match = input.UserInputType == kb._keyCode
					end
					if match then
						kb:_onInputEnd(input)
					end
				end
			end
		end)
	end

	-- Mouse tracking for tooltips
	local uis = game:GetService("UserInputService")
	self._mouseCon = uis.InputChanged:Connect(function(input, gpe)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			self._mousePos = input.Position
			if self._tooltipActive and self._tooltipLabel and self._tooltipLabel.Visible then
				self:_updateTooltipPosition()
			end
		end
	end)
	self:_createOverview()

	return self
end
