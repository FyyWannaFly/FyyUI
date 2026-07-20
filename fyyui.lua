--[[
	FyyUI v0.2.0
	Roblox UI Library
	@github FyyWannaFly/FyyUI
	
	local FyyUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/FyyWannaFly/FyyUI/main/fyyui.lua"))()
	local menu = FyyUI.Menu({ Title = "Hub" })
	local tab = menu:Tab({ Text = "Main" })
	tab:Toggle({ Text = "Auto Farm", Callback = function(v) end })
	menu:Notify({ Text = "Loaded!", Duration = 3 })
]]

return (function()
	local Theme = {
		Dark = {
			Background = Color3.fromRGB(18, 18, 22),
			Topbar = Color3.fromRGB(24, 24, 30),
			TopbarBorder = Color3.fromRGB(38, 38, 46),
			Accent = Color3.fromRGB(0, 130, 250),
			AccentLine = Color3.fromRGB(0, 150, 255),
			TextPrimary = Color3.fromRGB(225, 225, 235),
			TextSecondary = Color3.fromRGB(145, 145, 160),
			TextMuted = Color3.fromRGB(95, 95, 110),
			Element = Color3.fromRGB(35, 35, 42),
			ElementHover = Color3.fromRGB(45, 45, 54),
			ElementBorder = Color3.fromRGB(48, 48, 56),
			Outline = Color3.fromRGB(40, 40, 50),
			ToggleOn = Color3.fromRGB(0, 180, 80),
			ToggleOff = Color3.fromRGB(55, 55, 65),
			ToggleKnob = Color3.fromRGB(210, 210, 220),
			Border = Color3.fromRGB(40, 40, 48),
			ScrollBar = Color3.fromRGB(65, 65, 78),
			Shadow = Color3.fromRGB(0, 0, 0),
			Sidebar = Color3.fromRGB(22, 22, 28),
			SidebarText = Color3.fromRGB(130, 130, 145),
			SidebarTextActive = Color3.fromRGB(225, 225, 235),
			TabActive = Color3.fromRGB(35, 35, 42),
			TabHover = Color3.fromRGB(45, 45, 54),
			Font = Enum.Font.SourceSans,
			FontBold = Enum.Font.SourceSansBold,
			FontSize = 16,
			FontSizeTitle = 18,
			FontSizeSmall = 14,
			Padding = 10,
			CornerRadius = 8,
			TopbarHeight = 44,
			ElementHeight = 34,
			DescHeight = 52,
			Spacing = 6,
			SidebarWidth = 150,
		},
		Light = {
			Background = Color3.fromRGB(242, 242, 247),
			Topbar = Color3.fromRGB(232, 232, 240),
			TopbarBorder = Color3.fromRGB(218, 218, 228),
			Accent = Color3.fromRGB(0, 115, 235),
			AccentLine = Color3.fromRGB(0, 130, 245),
			TextPrimary = Color3.fromRGB(28, 28, 36),
			TextSecondary = Color3.fromRGB(98, 98, 112),
			TextMuted = Color3.fromRGB(148, 148, 162),
			Element = Color3.fromRGB(222, 222, 232),
			ElementHover = Color3.fromRGB(212, 212, 224),
			ElementBorder = Color3.fromRGB(208, 208, 218),
			Outline = Color3.fromRGB(200, 200, 215),
			ToggleOn = Color3.fromRGB(0, 165, 75),
			ToggleOff = Color3.fromRGB(178, 178, 190),
			ToggleKnob = Color3.fromRGB(242, 242, 248),
			Border = Color3.fromRGB(208, 208, 220),
			ScrollBar = Color3.fromRGB(178, 178, 192),
			Shadow = Color3.fromRGB(0, 0, 0),
			Sidebar = Color3.fromRGB(235, 235, 242),
			SidebarText = Color3.fromRGB(130, 130, 145),
			SidebarTextActive = Color3.fromRGB(28, 28, 36),
			TabActive = Color3.fromRGB(212, 212, 224),
			TabHover = Color3.fromRGB(200, 200, 215),
			Font = Enum.Font.SourceSans,
			FontBold = Enum.Font.SourceSansBold,
			FontSize = 16,
			FontSizeTitle = 18,
			FontSizeSmall = 14,
			Padding = 10,
			CornerRadius = 8,
			TopbarHeight = 44,
			ElementHeight = 34,
			DescHeight = 52,
			Spacing = 6,
			SidebarWidth = 150,
		},
	}

	function Theme:Override(base, overrides)
		base = type(base) == "string" and self[base] or base
		if not base then base = self.Dark end
		local m = {}
		for k, v in pairs(base) do m[k] = v end
		for k, v in pairs(overrides or {}) do m[k] = v end
		return m
	end

	local U = {}

	function U.Create(c, props, children)
		local inst = Instance.new(c)
		if props then for k, v in pairs(props) do inst[k] = v end end
		if children then for _, ch in ipairs(children) do ch.Parent = inst end end
		return inst
	end

	--[[ Toggle ]]
	local Toggle = {}
	Toggle.__index = Toggle

	function Toggle.new(parent, options, theme)
		local self = setmetatable({}, Toggle)
		self.Text = options.Text or "Toggle"
		self.Description = options.Description
		self.Value = options.Default or false
		self.Callback = options.Callback or function() end
		self.Enabled = true
		self.Theme = theme
		self.HasDesc = self.Description ~= nil and self.Description ~= ""
		local h = self.HasDesc and theme.DescHeight or theme.ElementHeight

		self.Container = U.Create("Frame", {
			Name = "Toggle",
			Size = UDim2.new(1, -12, 0, h + 6),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0.4,
			BorderSizePixel = 0,
			Parent = parent,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = self.Container })

		self.Label = U.Create("TextLabel", {
			Name = "Label",
			Size = UDim2.new(1, -68, 0, 20),
			Position = UDim2.fromOffset(10, self.HasDesc and 6 or (h + 6 - 20) / 2 + 1),
			BackgroundTransparency = 1,
			Text = self.Text,
			Font = theme.Font,
			TextSize = theme.FontSize,
			TextColor3 = theme.TextPrimary,
			TextXAlignment = Enum.TextXAlignment.Left,
			RichText = true,
			Parent = self.Container,
		})

		if self.HasDesc then
			U.Create("TextLabel", {
				Name = "Description",
				Size = UDim2.new(1, -68, 0, 16),
				Position = UDim2.fromOffset(10, 28),
				BackgroundTransparency = 1,
				Text = self.Description,
				Font = theme.Font,
				TextSize = theme.FontSizeSmall,
				TextColor3 = theme.TextMuted,
				TextXAlignment = Enum.TextXAlignment.Left,
				RichText = true,
				Parent = self.Container,
			})
		end

		self.Track = U.Create("ImageButton", {
			Name = "Track",
			Size = UDim2.fromOffset(46, 24),
			Position = UDim2.new(1, -56, 0.5, -12),
			BackgroundColor3 = self.Value and theme.ToggleOn or theme.ToggleOff,
			AutoButtonColor = false,
			Parent = self.Container,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = self.Track })

		self.Knob = U.Create("Frame", {
			Name = "Knob",
			Size = UDim2.fromOffset(18, 18),
			Position = UDim2.fromOffset(self.Value and 26 or 2, 3),
			BackgroundColor3 = theme.ToggleKnob,
			Parent = self.Track,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = self.Knob })

		self.Track.MouseButton1Click:Connect(function()
			if not self.Enabled then return end
			self:SetValue(not self.Value)
		end)

		return self
	end

	function Toggle:_animate(value)
		local ts = game:GetService("TweenService")
		local ti = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		ts:Create(self.Track, ti, { BackgroundColor3 = value and self.Theme.ToggleOn or self.Theme.ToggleOff }):Play()
		ts:Create(self.Knob, ti, { Position = UDim2.fromOffset(value and 26 or 2, 3) }):Play()
	end

	function Toggle:SetValue(value, instant)
		if self.Value == value then return end
		self.Value = value
		if instant then
			self.Track.BackgroundColor3 = value and self.Theme.ToggleOn or self.Theme.ToggleOff
			self.Knob.Position = UDim2.fromOffset(value and 26 or 2, 3)
		else
			self:_animate(value)
		end
		task.spawn(function() self.Callback(value) end)
	end

	function Toggle:GetValue() return self.Value end
	function Toggle:SetEnabled(enabled)
		self.Enabled = enabled
		local t = enabled and 0 or 0.5
		self.Track.BackgroundTransparency = t
		self.Knob.BackgroundTransparency = t
	end
	function Toggle:SetText(text) self.Text = text self.Label.Text = text end
	function Toggle:SetDescription(desc)
		self.Description = desc
		local d = self.Container:FindFirstChild("Description")
		if d then d.Text = desc or "" end
	end
	function Toggle:Destroy() if self.Container then self.Container:Destroy() end end

	--[[ Slider ]]
	local Slider = {}
	Slider.__index = Slider

	function Slider.new(parent, options, theme)
		local self = setmetatable({}, Slider)
		self.Text = options.Text or "Slider"
		self.Description = options.Description
		self.Min = options.Min or 0
		self.Max = options.Max or 100
		self.Value = math.clamp(options.Default or self.Min, self.Min, self.Max)
		self.Suffix = options.Suffix or ""
		self.Step = options.Step or 1
		self.Callback = options.Callback or function() end
		self.Theme = theme
		self.HasDesc = self.Description ~= nil and self.Description ~= ""
		local h = self.HasDesc and theme.DescHeight or theme.ElementHeight
		local trackY = self.HasDesc and 30 or 18

		self.Container = U.Create("Frame", {
			Name = "Slider",
			Size = UDim2.new(1, -12, 0, h + 8),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0.4,
			BorderSizePixel = 0,
			Parent = parent,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = self.Container })

		self.Label = U.Create("TextLabel", {
			Name = "Label",
			Size = UDim2.new(1, -70, 0, 20),
			Position = UDim2.fromOffset(10, 4),
			BackgroundTransparency = 1,
			Text = self.Text,
			Font = theme.Font,
			TextSize = theme.FontSize,
			TextColor3 = theme.TextPrimary,
			TextXAlignment = Enum.TextXAlignment.Left,
			RichText = true,
			Parent = self.Container,
		})

		self.ValueLabel = U.Create("TextLabel", {
			Name = "Value",
			Size = UDim2.fromOffset(50, 20),
			Position = UDim2.new(1, -56, 0, 4),
			BackgroundTransparency = 1,
			Text = tostring(self.Value) .. self.Suffix,
			Font = theme.FontBold,
			TextSize = theme.FontSize,
			TextColor3 = theme.Accent,
			TextXAlignment = Enum.TextXAlignment.Right,
			RichText = true,
			Parent = self.Container,
		})

		local trackH = 6
		local trackPad = 10
		local fillPct = (self.Max ~= self.Min) and (self.Value - self.Min) / (self.Max - self.Min) or 0

		self.Track = U.Create("Frame", {
			Name = "Track",
			Size = UDim2.new(1, -(trackPad * 2), 0, trackH),
			Position = UDim2.fromOffset(trackPad, trackY),
			BackgroundColor3 = theme.ToggleOff,
			BorderSizePixel = 0,
			Parent = self.Container,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = self.Track })

		self.Fill = U.Create("Frame", {
			Name = "Fill",
			Size = UDim2.new(fillPct, 0, 1, 0),
			BackgroundColor3 = theme.Accent,
			BorderSizePixel = 0,
			Parent = self.Track,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = self.Fill })

		local knobSize = 14
		self.Knob = U.Create("ImageButton", {
			Name = "Knob",
			Size = UDim2.fromOffset(knobSize, knobSize),
			BackgroundColor3 = theme.Accent,
			AutoButtonColor = false,
			ZIndex = 2,
			Parent = self.Track,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = self.Knob })
		self:_updateKnobPos()

		local uis = game:GetService("UserInputService")

		local function roundToStep(v)
			return math.round(v / self.Step) * self.Step
		end

		local dragging = false
		self.Knob.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = true
			end
		end)
		local dragCon
		dragCon = uis.InputChanged:Connect(function(input, processed)
			if processed then return end
			if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
				local absPos = self.Track.AbsolutePosition.X
				local size = self.Track.AbsoluteSize.X
				if size <= 0 then return end
				local pct = math.clamp((input.Position.X - absPos) / size, 0, 1)
				local val = self.Min + (self.Max - self.Min) * pct
				val = math.clamp(roundToStep(val), self.Min, self.Max)
				self:SetValue(val)
			end
		end)
		self.Knob.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = false
			end
		end)
		self._dragCon = dragCon

		-- Click on track to jump
		self.Track.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				local absPos = self.Track.AbsolutePosition.X
				local size = self.Track.AbsoluteSize.X
				if size <= 0 then return end
				local pct = math.clamp((input.Position.X - absPos) / size, 0, 1)
				local val = self.Min + (self.Max - self.Min) * pct
				val = math.clamp(roundToStep(val), self.Min, self.Max)
				self:SetValue(val)
			end
		end)

		if self.HasDesc then
			U.Create("TextLabel", {
				Name = "Description",
				Size = UDim2.new(1, -20, 0, 16),
				Position = UDim2.fromOffset(10, trackY + trackH + 4),
				BackgroundTransparency = 1,
				Text = self.Description,
				Font = theme.Font,
				TextSize = theme.FontSizeSmall,
				TextColor3 = theme.TextMuted,
				TextXAlignment = Enum.TextXAlignment.Left,
				RichText = true,
				Parent = self.Container,
			})
		end

		return self
	end

	function Slider:_updateKnobPos()
		local pct = (self.Max ~= self.Min) and (self.Value - self.Min) / (self.Max - self.Min) or 0
		pct = math.clamp(pct, 0, 1)
		self.Knob.Position = UDim2.new(pct, -7, 0.5, -7)
	end

	function Slider:SetValue(v, noCallback)
		v = math.clamp(v, self.Min, self.Max)
		if self.Value == v then return end
		self.Value = v
		local pct = (self.Max ~= self.Min) and (v - self.Min) / (self.Max - self.Min) or 0
		pct = math.clamp(pct, 0, 1)
		self.Fill.Size = UDim2.new(pct, 0, 1, 0)
		self.Knob.Position = UDim2.new(pct, -7, 0.5, -7)
		self.ValueLabel.Text = tostring(v) .. self.Suffix
		if not noCallback then
			task.spawn(function() self.Callback(v) end)
		end
	end

	function Slider:GetValue() return self.Value end
	function Slider:Destroy()
		if self._dragCon then self._dragCon:Disconnect() end
		if self.Container then self.Container:Destroy() end
	end

	--[[ Dropdown ]]
	local Dropdown = {}
	Dropdown.__index = Dropdown

	function Dropdown.new(parent, options, theme, menuRef)
		local self = setmetatable({}, Dropdown)
		self._menu = menuRef
		self.Text = options.Text or "Dropdown"
		self.Description = options.Description
		self.Options = options.Options or {}
		self.Value = options.Default or (self.Options[1] or "")
		self.Callback = options.Callback or function() end
		self.Theme = theme
		self.Open = false
		self.HasDesc = self.Description ~= nil and self.Description ~= ""
		local h = self.HasDesc and theme.DescHeight or theme.ElementHeight
		local selectY = self.HasDesc and 28 or 10

		self.Container = U.Create("Frame", {
			Name = "Dropdown",
			Size = UDim2.new(1, -12, 0, h + 8),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0.4,
			BorderSizePixel = 0,
			Parent = parent,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = self.Container })

		U.Create("TextLabel", {
			Name = "Label",
			Size = UDim2.new(1, -70, 0, 20),
			Position = UDim2.fromOffset(10, 4),
			BackgroundTransparency = 1,
			Text = self.Text,
			Font = theme.Font,
			TextSize = theme.FontSize,
			TextColor3 = theme.TextPrimary,
			TextXAlignment = Enum.TextXAlignment.Left,
			RichText = true,
			Parent = self.Container,
		})

		self.SelectBtn = U.Create("ImageButton", {
			Name = "Select",
			Size = UDim2.new(1, -(10 * 2), 0, 24),
			Position = UDim2.fromOffset(10, selectY),
			BackgroundColor3 = theme.Element,
			AutoButtonColor = false,
			Parent = self.Container,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = self.SelectBtn })

		self.SelectText = U.Create("TextLabel", {
			Name = "Text",
			Size = UDim2.new(1, -26, 1, 0),
			Position = UDim2.fromOffset(10, 0),
			BackgroundTransparency = 1,
			Text = tostring(self.Value),
			Font = theme.Font,
			TextSize = theme.FontSize,
			TextColor3 = theme.TextPrimary,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = self.SelectBtn,
		})

		U.Create("TextLabel", {
			Name = "Arrow",
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.new(1, -20, 0.5, -8),
			BackgroundTransparency = 1,
			Text = "v",
			Font = theme.FontBold,
			TextSize = 14,
			TextColor3 = theme.TextMuted,
			Parent = self.SelectBtn,
		})

			-- Find selected index
		local selectedIdx = 0
		for i, opt in ipairs(self.Options) do
			if opt == self.Value then selectedIdx = i; break end
		end

		self.SelectBtn.MouseButton1Click:Connect(function()
			self.Open = not self.Open
			if self.Open then
				-- Close any other open dropdown first
				if self._menu._activeDropdown and self._menu._activeDropdown ~= self then
					self._menu._activeDropdown.Open = false
					self._menu:HideDropdownPopup()
				end
				self._menu._activeDropdown = self
				local pos = self.SelectBtn.AbsolutePosition
				local siz = self.SelectBtn.AbsoluteSize
				self._menu:ShowDropdownPopup(pos, siz, self.Options, selectedIdx, function(idx, val)
					self:SetValue(val)
				end)
			else
				if self._menu._activeDropdown == self then
					self._menu._activeDropdown = nil
				end
				self._menu:HideDropdownPopup()
			end
		end)

		if self.HasDesc then
			U.Create("TextLabel", {
				Name = "Description",
				Size = UDim2.new(1, -20, 0, 16),
				Position = UDim2.fromOffset(10, selectY + 52),
				BackgroundTransparency = 1,
				Text = self.Description,
				Font = theme.Font,
				TextSize = theme.FontSizeSmall,
				TextColor3 = theme.TextMuted,
				TextXAlignment = Enum.TextXAlignment.Left,
				RichText = true,
				Parent = self.Container,
			})
		end

		return self
	end

	function Dropdown:SetValue(v)
		if v == self.Value then
			self.Open = false
			if self._menu._activeDropdown == self then
				self._menu._activeDropdown = nil
				self._menu:HideDropdownPopup()
			end
			return
		end
		self.Value = v
		self.SelectText.Text = tostring(v)
		self.Open = false
		if self._menu._activeDropdown == self then
			self._menu._activeDropdown = nil
			self._menu:HideDropdownPopup()
		end
		task.spawn(function() self.Callback(v) end)
	end

	function Dropdown:GetValue() return self.Value end
	function Dropdown:Destroy()
		if self._menu._activeDropdown == self then
			self._menu._activeDropdown = nil
		end
		if self.Container then self.Container:Destroy() end
	end

	--[[ Tab ]]
	local Tab = {}
	Tab.__index = Tab

	function Tab.new(menu, options)
		local self = setmetatable({}, Tab)
		self.Menu = menu
		self.Text = options.Text or "Tab"
		self.Theme = menu.Theme
		self.Components = {}
		local theme = self.Theme

		self.TabButton = U.Create("ImageButton", {
			Name = "TabButton",
			Size = UDim2.new(1, -6, 0, 34),
			Position = UDim2.fromOffset(3, 0),
			BackgroundTransparency = 1,
			AutoButtonColor = false,
			Parent = menu.SidebarList,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = self.TabButton })
		self._activeBar = U.Create("Frame", {
			Name = "ActiveBar",
			Size = UDim2.fromOffset(3, 18),
			Position = UDim2.new(0, 2, 0.5, -9),
			BackgroundTransparency = 1,
			BackgroundColor3 = theme.Accent,
			BorderSizePixel = 0,
			Parent = self.TabButton,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = self._activeBar })
		U.Create("TextLabel", {
			Name = "Label",
			Size = UDim2.new(1, -14, 1, 0),
			Position = UDim2.fromOffset(10, 0),
			BackgroundTransparency = 1,
			Text = self.Text,
			Font = theme.Font,
			TextSize = theme.FontSize,
			TextColor3 = theme.SidebarText,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = self.TabButton,
		})
		U.Create("Frame", {
			Name = "Line",
			Size = UDim2.new(1, -16, 0, 1),
			Position = UDim2.new(0, 8, 1, -1),
			BackgroundColor3 = theme.Border,
			BackgroundTransparency = 0.5,
			BorderSizePixel = 0,
			Parent = self.TabButton,
		})

		self.Container = U.Create("ScrollingFrame", {
			Name = "TabContent",
			Size = UDim2.new(1, -12, 1, -6),
			Position = UDim2.fromOffset(6, 3),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 3,
			ScrollBarImageColor3 = theme.ScrollBar,
			ScrollBarImageTransparency = 0.4,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			ScrollingDirection = Enum.ScrollingDirection.Y,
			Visible = false,
			Parent = menu.ContentArea,
		})
		local listLayout = U.Create("UIListLayout", {
			Padding = UDim.new(0, theme.Spacing),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = self.Container,
		})
		listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			if self.Container then
				self.Container.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
			end
		end)

		self.TabButton.MouseButton1Click:Connect(function()
			menu:SelectTab(self)
		end)
		self.TabButton.MouseEnter:Connect(function()
			if menu.ActiveTab ~= self then
				self.TabButton.BackgroundTransparency = 0
				self.TabButton.BackgroundColor3 = theme.TabHover
			end
		end)
		self.TabButton.MouseLeave:Connect(function()
			if menu.ActiveTab ~= self then
				self.TabButton.BackgroundTransparency = 1
			end
		end)

		table.insert(menu.Tabs, self)
		if #menu.Tabs == 1 then
			menu:SelectTab(self)
		end

		return self
	end

	function Tab:Toggle(options)
		local toggle = Toggle.new(self.Container, options, self.Theme)
		table.insert(self.Components, toggle)
		return toggle
	end

	function Tab:Button(options)
		options = options or {}
		local theme = self.Theme
		local hasDesc = options.Description ~= nil and options.Description ~= ""
		local h = hasDesc and theme.DescHeight or theme.ElementHeight
		local btn = {}

		btn.Container = U.Create("ImageButton", {
			Name = "Button",
			Size = UDim2.new(1, -12, 0, h + 8),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0.4,
			AutoButtonColor = false,
			BorderSizePixel = 0,
			Parent = self.Container,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = btn.Container })

		if hasDesc then
			U.Create("TextLabel", {
				Name = "Text",
				Size = UDim2.new(1, -20, 0, 20),
				Position = UDim2.fromOffset(10, 5),
				BackgroundTransparency = 1,
				Text = options.Text or "Button",
				Font = theme.Font,
				TextSize = theme.FontSize,
				TextColor3 = options.Color or theme.TextPrimary,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = btn.Container,
			})
			U.Create("TextLabel", {
				Name = "Description",
				Size = UDim2.new(1, -20, 0, 16),
				Position = UDim2.fromOffset(10, 27),
				BackgroundTransparency = 1,
				Text = options.Description,
				Font = theme.Font,
				TextSize = theme.FontSizeSmall,
				TextColor3 = theme.TextMuted,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = btn.Container,
			})
		else
			U.Create("TextLabel", {
				Name = "Text",
				Size = UDim2.new(1, -20, 0, 20),
				Position = UDim2.fromOffset(10, (h + 8 - 20) / 2),
				BackgroundTransparency = 1,
				Text = options.Text or "Button",
				Font = theme.Font,
				TextSize = theme.FontSize,
				TextColor3 = options.Color or theme.TextPrimary,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = btn.Container,
			})
		end

		btn.Container.MouseEnter:Connect(function() btn.Container.BackgroundColor3 = theme.ElementHover end)
		btn.Container.MouseLeave:Connect(function() btn.Container.BackgroundColor3 = theme.Element end)
		btn.Container.MouseButton1Click:Connect(function() if options.Callback then options.Callback() end end)
		btn.SetText = function(text)
			local t = btn.Container:FindFirstChild("Text")
			if t then t.Text = text end
		end
		btn.SetCallback = function(cb) options.Callback = cb end
		btn.Destroy = function() if btn.Container then btn.Container:Destroy() end end

		table.insert(self.Components, btn)
		return btn
	end

	function Tab:Label(options)
		options = options or {}
		local hasDesc = options.Description ~= nil and options.Description ~= ""
		local h = hasDesc and self.Theme.DescHeight or self.Theme.ElementHeight
		local lbl = {}

		lbl.Container = U.Create("Frame", {
			Name = "Label",
			Size = UDim2.new(1, 0, 0, h),
			BackgroundTransparency = 1,
			Parent = self.Container,
		})

		lbl.TextLabel = U.Create("TextLabel", {
			Name = "Text",
			Size = UDim2.new(1, 0, 0, hasDesc and 20 or h),
			Position = UDim2.fromOffset(0, hasDesc and 2 or (h - 20) / 2 + 1),
			BackgroundTransparency = 1,
			Text = options.Text or "",
			Font = self.Theme.Font,
			TextSize = options.TextSize or self.Theme.FontSize,
			TextColor3 = options.Color or self.Theme.TextSecondary,
			TextXAlignment = Enum.TextXAlignment.Left,
			RichText = true,
			Parent = lbl.Container,
		})

		if hasDesc then
			U.Create("TextLabel", {
				Name = "Description",
				Size = UDim2.new(1, 0, 0, 16),
				Position = UDim2.fromOffset(0, 24),
				BackgroundTransparency = 1,
				Text = options.Description,
				Font = self.Theme.Font,
				TextSize = self.Theme.FontSizeSmall,
				TextColor3 = self.Theme.TextMuted,
				TextXAlignment = Enum.TextXAlignment.Left,
				RichText = true,
				Parent = lbl.Container,
			})
		end

		lbl.SetText = function(text) lbl.TextLabel.Text = text end
		lbl.SetColor = function(c) lbl.TextLabel.TextColor3 = c end
		lbl.Destroy = function() if lbl.Container then lbl.Container:Destroy() end end

		table.insert(self.Components, lbl)
		return lbl
	end

	function Tab:Divider()
		local div = {}
		div.Container = U.Create("Frame", {
			Name = "Divider",
			Size = UDim2.new(1, 0, 0, 14),
			BackgroundTransparency = 1,
			Parent = self.Container,
		})
		U.Create("Frame", {
			Name = "Line",
			Size = UDim2.new(1, 0, 0, 1),
			Position = UDim2.new(0, 0, 0.5, 0),
			BackgroundColor3 = self.Theme.Border,
			BorderSizePixel = 0,
			Parent = div.Container,
		})
		div.Destroy = function() if div.Container then div.Container:Destroy() end end
		table.insert(self.Components, div)
		return div
	end

	function Tab:Slider(options)
		local slider = Slider.new(self.Container, options, self.Theme)
		table.insert(self.Components, slider)
		return slider
	end

	function Tab:Dropdown(options)
		local dd = Dropdown.new(self.Container, options, self.Theme, self.Menu)
		table.insert(self.Components, dd)
		return dd
	end

	function Tab:Destroy()
		for _, c in ipairs(self.Components) do
			if c.Destroy then c:Destroy() end
		end
		self.Components = {}
		if self.Container then self.Container:Destroy() end
		if self.TabButton then self.TabButton:Destroy() end
	end

	--[[ Menu ]]
	local Menu = {}
	Menu.__index = Menu

	function Menu.new(options, theme)
		local self = setmetatable({}, Menu)
		self.Options = options
		self.Theme = theme
		self.Tabs = {}
		self.ActiveTab = nil
		self.Visible = options.Visible ~= false
		self.MinSize = options.MinSize or Vector2.new(320, 300)
		self.MaxSize = options.MaxSize or Vector2.new(850, 560)
		self.Resizable = options.Resizable or false

		local size = options.Size and Vector2.new(options.Size.X.Offset, options.Size.Y.Offset) or Vector2.new(592, 340)
		local pos = options.Position or UDim2.new(0.5, -size.X / 2, 0.5, -size.Y / 2)

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
		U.Create("UICorner", { CornerRadius = UDim.new(0, theme.CornerRadius), Parent = self.Frame })

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
				if not self._shadow then return end
				local s = self.Frame.Size
				self._shadow.Size = UDim2.fromOffset(s.X.Offset + 16, s.Y.Offset + 16)
				self._shadow.Position = UDim2.fromOffset(
					self.Frame.Position.X.Offset - 8,
					self.Frame.Position.Y.Offset - 8
				)
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
			local spacing = 6

			local function macBtn(name, color, action)
				local b = U.Create("ImageButton", {
					Name = name,
					Size = UDim2.fromOffset(btnSize, btnSize),
					Position = UDim2.new(0, rightMargin, 0.5, -btnSize / 2),
					BackgroundColor3 = color,
					AutoButtonColor = false,
					Parent = self.Topbar,
				})
				U.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = b })
				b.MouseButton1Click:Connect(action)
				rightMargin = rightMargin + btnSize + spacing
				return b
			end

			macBtn("Close", btnColors.Close, function() self:SetVisible(false) end)
			macBtn("Minimize", btnColors.Minimize, function()
				self.Minimized = not self.Minimized
				if self.Minimized then
					self._prevSize = self.Frame.Size
					self.Frame.Size = UDim2.fromOffset(self.Frame.Size.X.Offset, theme.TopbarHeight + 8)
					self.Sidebar.Visible = false
					self.ContentArea.Visible = false
				else
					self.Frame.Size = self._prevSize or UDim2.fromOffset(size.X, size.Y)
					self.Sidebar.Visible = true
					self.ContentArea.Visible = true
				end
			end)
			macBtn("Maximize", btnColors.Maximize, function()
				self.Maximized = not self.Maximized
				if self.Maximized then
					self._prevPos = self.Frame.Position
					self._prevSize = self.Frame.Size
					local vs = game:GetService("GuiService"):GetViewportSize()
					self.Frame.Size = UDim2.fromOffset(vs.X - 40, vs.Y - 40)
					self.Frame.Position = UDim2.fromOffset(20, 20)
				else
					self.Frame.Position = self._prevPos or pos
					self.Frame.Size = self._prevSize or UDim2.fromOffset(size.X, size.Y)
				end
				if self._updateShadow then self._updateShadow() end
			end)

			leftMargin = rightMargin + 8
			rightMargin = 10
		else
			self.CloseBtn = U.Create("ImageButton", {
				Name = "Close",
				Size = UDim2.fromOffset(26, 26),
				Position = UDim2.new(1, -36, 0.5, -13),
				BackgroundColor3 = Color3.fromRGB(60, 60, 72),
				BackgroundTransparency = 0.4,
				AutoButtonColor = false,
				Parent = self.Topbar,
			})
			self.CloseBtn.MouseEnter:Connect(function()
				self.CloseBtn.BackgroundTransparency = 0
				self.CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
			end)
			self.CloseBtn.MouseLeave:Connect(function()
				self.CloseBtn.BackgroundTransparency = 0.4
				self.CloseBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 72)
			end)
			U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = self.CloseBtn })
			U.Create("TextLabel", {
				Name = "Icon",
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				BackgroundTransparency = 1,
				Text = "X",
				Font = theme.FontBold,
				TextSize = 14,
				TextColor3 = Color3.fromRGB(180, 180, 195),
				Parent = self.CloseBtn,
			})
			self.CloseBtn.MouseButton1Click:Connect(function() self:SetVisible(false) end)
		end

		-- Logo
		if options.Logo then
			local logoSize = 26
			U.Create("ImageLabel", {
				Name = "Logo",
				Size = UDim2.fromOffset(logoSize, logoSize),
				Position = UDim2.fromOffset(leftMargin, (theme.TopbarHeight - logoSize) / 2),
				BackgroundTransparency = 1,
				Image = options.Logo,
				ScaleType = Enum.ScaleType.Fit,
				Parent = self.Topbar,
			})
			leftMargin = leftMargin + logoSize + 8
		end

		-- Title
		self.Title = U.Create("TextLabel", {
			Name = "Title",
			Size = UDim2.new(1, -(leftMargin + 50), 1, 0),
			Position = UDim2.fromOffset(leftMargin, 0),
			BackgroundTransparency = 1,
			Text = options.Title or "FyyUI",
			Font = theme.FontBold,
			TextSize = theme.FontSizeTitle,
			TextColor3 = theme.TextPrimary,
			TextXAlignment = titleAlign == "Right" and Enum.TextXAlignment.Right or Enum.TextXAlignment.Left,
			RichText = true,
			Parent = self.Topbar,
		})

		-- Accent line under topbar
		U.Create("Frame", {
			Name = "AccentLine",
			Size = UDim2.new(1, -20, 0, 2),
			Position = UDim2.new(0, 10, 1, 0),
			BackgroundColor3 = theme.AccentLine,
			BorderSizePixel = 0,
			Parent = self.Topbar,
		})

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

		-- Content Area
		self.ContentArea = U.Create("Frame", {
			Name = "Content",
			Size = UDim2.new(1, -(sbw + 8), 1, -(theme.TopbarHeight + 6)),
			Position = UDim2.new(0, sbw + 6, 0, theme.TopbarHeight + 4),
			BackgroundTransparency = 1,
			Parent = self.Frame,
		})

		-- Container for dropdown popups (screen-level, above everything)
		self._popupContainer = U.Create("Frame", {
			Name = "DropdownPopup",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			ZIndex = 1000,
			Visible = false,
			Parent = self.Gui,
		})
		self._popupOverlay = U.Create("ImageButton", {
			Name = "Overlay",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			ImageTransparency = 1,
			Parent = self._popupContainer,
		})
		self._popupOverlay.MouseButton1Click:Connect(function()
			self:HideDropdownPopup()
		end)

		-- Separator line between sidebar and content
		U.Create("Frame", {
			Name = "SidebarLine",
			Size = UDim2.new(0, 1, 1, -(theme.TopbarHeight + 10)),
			Position = UDim2.new(0, sbw + 4, 0, theme.TopbarHeight + 6),
			BackgroundColor3 = theme.Border,
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
			Parent = game:GetService("CoreGui"),
		})
		self.NotifBox = U.Create("Frame", {
			Name = "Notifications",
			Size = UDim2.new(0, 320, 0, 0),
			Position = UDim2.new(1, -330, 1, -10),
			BackgroundTransparency = 1,
			ZIndex = 50,
			Parent = self._notifGui,
		})
		local notifList = U.Create("UIListLayout", {
			Padding = UDim.new(0, 4),
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Bottom,
			Parent = self.NotifBox,
		})
		self._notifList = notifList

		self:_dragging()

		self.Gui.Parent = options.Parent or game:GetService("CoreGui")

		if self.Resizable then
			self:_resizable()
		end

		return self
	end

	function Menu:SelectTab(tab)
		if self.ActiveTab == tab then return end
		self:HideDropdownPopup()
		local ts = game:GetService("TweenService")
		local ti = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		if self.ActiveTab then
			local old = self.ActiveTab
			old.Container.Visible = false
			old.TabButton.BackgroundTransparency = 1
			local lbl = old.TabButton:FindFirstChild("Label")
			if lbl then lbl.TextColor3 = self.Theme.SidebarText end
			local bar = old.TabButton:FindFirstChild("ActiveBar")
			if bar then
				ts:Create(bar, ti, { BackgroundTransparency = 1, Size = UDim2.fromOffset(0, 18) }):Play()
			end
		end
		self.ActiveTab = tab
		if tab then
			tab.Container.Visible = true
			tab.TabButton.BackgroundTransparency = 0
			tab.TabButton.BackgroundColor3 = self.Theme.TabActive
			local lbl = tab.TabButton:FindFirstChild("Label")
			if lbl then lbl.TextColor3 = self.Theme.SidebarTextActive end
			local bar = tab.TabButton:FindFirstChild("ActiveBar")
			if bar then
				bar.Size = UDim2.fromOffset(0, 18)
				bar.BackgroundTransparency = 0
				ts:Create(bar, ti, { Size = UDim2.fromOffset(3, 18) }):Play()
			end
		end
	end

	function Menu:ShowDropdownPopup(atPos, atSize, opts, selectedIdx, onClick)
		local container = self._popupContainer
		if not container then return end
		-- Clear old popup
		local oldPopup = container:FindFirstChild("Popup")
		if oldPopup then oldPopup:Destroy() end

		local itemH = 28
		local pad = 4
		local count = #opts
		local maxH = 160
		local panelH = math.min(count * itemH + pad, maxH)
		local w = atSize.X

		local popup = U.Create("Frame", {
			Name = "Popup",
			Size = UDim2.fromOffset(w, panelH),
			Position = UDim2.fromOffset(atPos.X, atPos.Y + atSize.Y),
			BackgroundColor3 = self.Theme.Element,
			BorderSizePixel = 0,
			ZIndex = 1001,
			Parent = container,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = popup })
		U.Create("UIStroke", {
			Color = self.Theme.Border,
			Thickness = 1,
			Transparency = 0.4,
			Parent = popup,
		})
		local list = U.Create("UIListLayout", {
			Padding = UDim.new(0, 2),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = popup,
		})
		for i, opt in ipairs(opts) do
			local sel = i == selectedIdx
			local btn = U.Create("TextButton", {
				Name = "Option",
				Size = UDim2.new(1, -pad * 2, 0, itemH),
				Position = UDim2.fromOffset(pad, 0),
				Text = "",
				BackgroundColor3 = sel and self.Theme.Accent or self.Theme.ElementHover,
				BackgroundTransparency = 0,
				AutoButtonColor = false,
				ZIndex = 1002,
				Parent = popup,
			})
			U.Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = btn })
			U.Create("TextLabel", {
				Name = "Label",
				Size = UDim2.new(1, -12, 1, 0),
				Position = UDim2.fromOffset(8, 0),
				BackgroundTransparency = 1,
				Text = tostring(opt),
				Font = self.Theme.Font,
				TextSize = self.Theme.FontSize,
				TextColor3 = self.Theme.TextPrimary,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 1003,
				Parent = btn,
			})
			btn.MouseButton1Click:Connect(function()
				onClick(i, opt)
				self:HideDropdownPopup()
			end)
			btn.MouseEnter:Connect(function()
				if not sel then btn.BackgroundColor3 = self.Theme.Element end
			end)
			btn.MouseLeave:Connect(function()
				if not sel then btn.BackgroundColor3 = self.Theme.ElementHover end
			end)
		end
		container.Visible = true
	end

	function Menu:HideDropdownPopup()
		local container = self._popupContainer
		if not container or not container.Visible then return end
		container.Visible = false
		if self._activeDropdown then
			self._activeDropdown.Open = false
			self._activeDropdown = nil
		end
	end

	function Menu:Tab(options)
		return Tab.new(self, options)
	end

	function Menu:Notify(options)
		options = options or {}
		local text = options.Text or ""
		local duration = options.Duration or 3
		local notifType = options.Type or "Info"
		local theme = self.Theme

		local typeColors = {
			Info = Color3.fromRGB(0, 130, 250),
			Success = Color3.fromRGB(0, 180, 80),
			Error = Color3.fromRGB(220, 60, 60),
			Warning = Color3.fromRGB(220, 180, 40),
		}
		local accent = typeColors[notifType] or typeColors.Info

		local frame = U.Create("Frame", {
			Name = "Notification",
			Size = UDim2.new(1, 0, 0, 0),
			BackgroundColor3 = theme.Element,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			Parent = self.NotifBox,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = frame })

		U.Create("Frame", {
			Name = "Bar",
			Size = UDim2.new(0, 3, 1, 0),
			BackgroundColor3 = accent,
			BorderSizePixel = 0,
			Parent = frame,
		})

		U.Create("TextLabel", {
			Name = "Text",
			Size = UDim2.new(1, -14, 1, 0),
			Position = UDim2.fromOffset(12, 0),
			BackgroundTransparency = 1,
			Text = text,
			Font = theme.Font,
			TextSize = theme.FontSize,
			TextColor3 = theme.TextPrimary,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = frame,
		})

		-- Animate in
		local h = 32
		frame.Size = UDim2.new(1, 0, 0, 0)
		local ts = game:GetService("TweenService")
		local ti = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local fadeIn = ts:Create(frame, ti, { Size = UDim2.new(1, 0, 0, h) })
		fadeIn:Play()

		-- Auto dismiss
		task.delay(duration, function()
			if not frame.Parent then return end
			local fadeOut = ts:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Size = UDim2.new(1, 0, 0, 0),
				BackgroundTransparency = 1,
			})
			fadeOut.Completed:Connect(function()
				frame:Destroy()
			end)
			fadeOut:Play()
		end)
	end

	function Menu:_dragging()
		local topbar = self.Topbar
		local frame = self.Frame
		local shadow = self._shadow
		local dragging, ds, sp

		topbar.InputBegan:Connect(function(input)
			local t = input.UserInputType
			if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
				dragging = true
				ds = input.Position
				sp = frame.Position
			end
		end)
		topbar.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
				local delta = input.Position - ds
				frame.Position = UDim2.new(
					sp.X.Scale, sp.X.Offset + delta.X,
					sp.Y.Scale, sp.Y.Offset + delta.Y
				)
				if shadow then
					shadow.Position = UDim2.new(
						sp.X.Scale, sp.X.Offset + delta.X - 8,
						sp.Y.Scale, sp.Y.Offset + delta.Y - 8
					)
				end
			end
		end)
		topbar.InputEnded:Connect(function(input)
			local t = input.UserInputType
			if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
				dragging = false
			end
		end)
	end

	function Menu:_resizable()
		local grip = U.Create("ImageButton", {
			Name = "ResizeGrip",
			Size = UDim2.fromOffset(14, 14),
			Position = UDim2.new(1, -14, 1, -14),
			BackgroundColor3 = self.Theme.TextMuted,
			BackgroundTransparency = 0.6,
			AutoButtonColor = false,
			Parent = self.Frame,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 2), Parent = grip })

		local frame = self.Frame
		local shadow = self._shadow
		local resizing, rs, rp, rsiz

		grip.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				resizing = true
				rs = input.Position
				rp = frame.Position
				rsiz = frame.Size
			end
		end)
		grip.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement and resizing then
				local delta = input.Position - rs
				local nw = math.max(200, rsiz.X.Offset + delta.X)
				local nh = math.max(140, rsiz.Y.Offset + delta.Y)
				if self.MinSize then
					nw = math.max(nw, self.MinSize.X)
					nh = math.max(nh, self.MinSize.Y)
				end
				if self.MaxSize then
					nw = math.min(nw, self.MaxSize.X)
					nh = math.min(nh, self.MaxSize.Y)
				end
				frame.Size = UDim2.fromOffset(nw, nh)
				if shadow then
					shadow.Size = UDim2.fromOffset(nw + 16, nh + 16)
				end
			end
		end)
		grip.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				resizing = false
			end
		end)
	end

	function Menu:SetVisible(v)
		self.Visible = v
		if self.Gui then self.Gui.Enabled = v end
	end

	function Menu:ToggleVisibility() self:SetVisible(not self.Visible) end
	function Menu:GetVisible() return self.Visible end
	function Menu:SetTitle(t) self.Title.Text = t end

	function Menu:Destroy()
		for _, tab in ipairs(self.Tabs) do
			tab:Destroy()
		end
		self.Tabs = {}
		if self.Gui then self.Gui:Destroy() end
	end

	--[[ Export ]]
	local FyyUI = { Version = "0.4.0", Theme = Theme }

	function FyyUI.Menu(options)
		options = options or {}
		local name = options.Theme or "Dark"
		local theme = type(name) == "string" and Theme[name] or name
		if not theme then theme = Theme.Dark end
		if options.ColorOverride then theme = Theme:Override(theme, options.ColorOverride) end
		return Menu.new(options, theme)
	end

	return FyyUI
end)()
