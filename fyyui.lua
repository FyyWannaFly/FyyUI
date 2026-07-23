--[[
	FyyUI v0.10.5
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
			ElementHeight = 36,
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
			ElementHeight = 36,
			DescHeight = 52,
			Spacing = 6,
			SidebarWidth = 150,
		},
		Amoled = {
			Background = Color3.fromRGB(0, 0, 0),
			Topbar = Color3.fromRGB(7, 7, 10),
			TopbarBorder = Color3.fromRGB(18, 18, 26),
			Accent = Color3.fromRGB(140, 80, 255),
			AccentLine = Color3.fromRGB(140, 80, 255),
			TextPrimary = Color3.fromRGB(210, 210, 220),
			TextSecondary = Color3.fromRGB(130, 130, 145),
			TextMuted = Color3.fromRGB(75, 75, 92),
			Element = Color3.fromRGB(13, 13, 18),
			ElementHover = Color3.fromRGB(22, 22, 30),
			ElementBorder = Color3.fromRGB(25, 25, 36),
			Outline = Color3.fromRGB(16, 16, 24),
			ToggleOn = Color3.fromRGB(140, 80, 255),
			ToggleOff = Color3.fromRGB(22, 22, 32),
			ToggleKnob = Color3.fromRGB(195, 195, 210),
			Border = Color3.fromRGB(16, 16, 24),
			ScrollBar = Color3.fromRGB(40, 40, 56),
			Shadow = Color3.fromRGB(0, 0, 0),
			Sidebar = Color3.fromRGB(3, 3, 6),
			SidebarText = Color3.fromRGB(100, 100, 120),
			SidebarTextActive = Color3.fromRGB(210, 210, 220),
			TabActive = Color3.fromRGB(13, 13, 18),
			TabHover = Color3.fromRGB(22, 22, 30),
			Font = Enum.Font.SourceSans,
			FontBold = Enum.Font.SourceSansBold,
			FontSize = 16,
			FontSizeTitle = 18,
			FontSizeSmall = 14,
			Padding = 10,
			CornerRadius = 8,
			TopbarHeight = 44,
			ElementHeight = 36,
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

	--[[ Icon Module (Lucide/Solar/etc.) — auto-load dari GitHub ]]
	local IconModule = nil
	do
		local iconUrl = "https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/lucide/dist/Icons.lua"
		local raw
		-- Try multiple HTTP methods
		local httpMethods = {
			function() return game:HttpGet(iconUrl) end,
			function() return game:GetService("HttpService"):GetAsync(iconUrl) end,
		}
		for _, method in ipairs(httpMethods) do
			local ok, result = pcall(method)
			if ok and result then raw = result; break end
		end
		if raw then
			local ok2, mod = pcall(loadstring, raw)
			if ok2 and mod then
				IconModule = mod()
			end
		end
	end

	local function resolveIcon(icon)
		if not icon or type(icon) ~= "string" then return nil end
		-- Direct rbxassetid:// (no resolution needed)
		if icon:find("^rbxassetid://") then
			return { Image = icon }
		end
		-- Icon module available
		if IconModule then
			-- Class format (has Icon2 method) — from manual SetIconModule()
			if IconModule.Icon2 then
				local ok, result = pcall(IconModule.Icon2, IconModule, icon)
				if ok and result then
					return {
						Image = result[1],
						ImageRectSize = result[2].ImageRectSize,
						ImageRectOffset = result[2].ImageRectPosition,
					}
				end
			-- Flat table format (name → assetId) — from auto-load
			elseif type(IconModule) == "table" then
				-- Parse "lucide:zap" → "zap", or just "zap"
				local name = icon
				local colon = icon:find(":")
				if colon then name = icon:sub(colon + 1) end
				local assetId = IconModule[name]
				if assetId then
					return { Image = assetId }
				end
			end
		end
		-- Fallback: treat as raw asset ID
		return { Image = icon }
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
		self.Flag = options.Flag
		self.Enabled = true
		self.Theme = theme
		self.HasDesc = self.Description ~= nil and self.Description ~= ""
		local h = self.HasDesc and theme.DescHeight or theme.ElementHeight

		self.Container = U.Create("Frame", {
			Name = "Toggle",
			Size = UDim2.new(1, -12, 0, h + 6),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			Parent = parent,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = self.Container })
		U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = self.Container })

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

		self._tweenTrack = nil
		self._tweenKnob = nil
		self.Track = U.Create("ImageButton", {
			Name = "Track",
			Size = UDim2.fromOffset(48, 26),
			Position = UDim2.new(1, -58, 0.5, -13),
			BackgroundColor3 = self.Value and theme.ToggleOn or theme.ToggleOff,
			AutoButtonColor = false,
			Parent = self.Container,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = self.Track })

		self.Knob = U.Create("Frame", {
			Name = "Knob",
			Size = UDim2.fromOffset(20, 20),
			Position = UDim2.fromOffset(self.Value and 26 or 2, 3),
			BackgroundColor3 = theme.ToggleKnob,
			Parent = self.Track,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = self.Knob })
		U.Create("UIStroke", { Color = Color3.fromRGB(0,0,0), Transparency = 0.8, Thickness = 1, Parent = self.Knob })

		self.Track.MouseEnter:Connect(function()
			if not self.Enabled then return end
			self.Track.BackgroundColor3 = self.Value and theme.ToggleOn or theme.ElementHover
		end)
		self.Track.MouseLeave:Connect(function()
			if not self.Enabled then return end
			self.Track.BackgroundColor3 = self.Value and theme.ToggleOn or theme.ToggleOff
		end)
		self.Track.MouseButton1Click:Connect(function()
			if not self.Enabled then return end
			self:SetValue(not self.Value)
		end)

		return self
	end

	function Toggle:_animate(value, instant)
		if self._tweenTrack then self._tweenTrack:Cancel() end
		if self._tweenKnob then self._tweenKnob:Cancel() end
		local ts = game:GetService("TweenService")
		if instant then
			self.Track.BackgroundColor3 = value and self.Theme.ToggleOn or self.Theme.ToggleOff
			self.Knob.Position = UDim2.fromOffset(value and 26 or 2, 3)
		else
			local ti = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			self._tweenTrack = ts:Create(self.Track, ti, { BackgroundColor3 = value and self.Theme.ToggleOn or self.Theme.ToggleOff })
			self._tweenTrack:Play()
			self._tweenKnob = ts:Create(self.Knob, ti, { Position = UDim2.fromOffset(value and 26 or 2, 3) })
			self._tweenKnob:Play()
		end
	end

	function Toggle:SetValue(value, instant)
		if self.Value == value then return end
		self.Value = value
		self:_animate(value, instant)
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

	function Toggle:ApplyTheme(theme)
		self.Theme = theme
		if not self.Container then return end
		self.Container.BackgroundColor3 = theme.Element
		local stroke = self.Container:FindFirstChildOfClass("UIStroke")
		if stroke then stroke.Color = theme.ElementBorder end
		self.Label.Font = theme.Font
		self.Label.TextSize = theme.FontSize
		self.Label.TextColor3 = theme.TextPrimary
		local desc = self.Container:FindFirstChild("Description")
		if desc then
			desc.Font = theme.Font
			desc.TextSize = theme.FontSizeSmall
			desc.TextColor3 = theme.TextMuted
		end
		self.Track.BackgroundColor3 = self.Value and theme.ToggleOn or theme.ToggleOff
		self.Knob.BackgroundColor3 = theme.ToggleKnob
	end

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
		self.Flag = options.Flag
		self.Theme = theme
		self.HasDesc = self.Description ~= nil and self.Description ~= ""
		local h = self.HasDesc and theme.DescHeight or theme.ElementHeight
		local trackY = self.HasDesc and 30 or 28

		self.Container = U.Create("Frame", {
			Name = "Slider",
			Size = UDim2.new(1, -12, 0, h + 8),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			Parent = parent,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = self.Container })
		U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = self.Container })

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
		U.Create("UIStroke", { Color = Color3.fromRGB(255,255,255), Transparency = 0.5, Thickness = 1.5, Parent = self.Knob })
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

	function Slider:ApplyTheme(theme)
		self.Theme = theme
		if not self.Container then return end
		self.Container.BackgroundColor3 = theme.Element
		local stroke = self.Container:FindFirstChildOfClass("UIStroke")
		if stroke then stroke.Color = theme.ElementBorder end
		self.Label.Font = theme.Font
		self.Label.TextSize = theme.FontSize
		self.Label.TextColor3 = theme.TextPrimary
		self.ValueLabel.Font = theme.FontBold
		self.ValueLabel.TextSize = theme.FontSize
		self.ValueLabel.TextColor3 = theme.Accent
		local desc = self.Container:FindFirstChild("Description")
		if desc then
			desc.Font = theme.Font
			desc.TextSize = theme.FontSizeSmall
			desc.TextColor3 = theme.TextMuted
		end
		self.Track.BackgroundColor3 = theme.ToggleOff
		self.Fill.BackgroundColor3 = theme.Accent
		self.Knob.BackgroundColor3 = theme.Accent
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
		self.Multi = options.Multi or false  -- Multi-Select mode
		-- AllowNone: if false, single-select always retains a valid option when options exist
		self.AllowNone = options.AllowNone
		if self.AllowNone == nil then self.AllowNone = true end
		self.Value = ""  -- start empty; use Default to pre-select
		if options.Default ~= nil then
			self.Value = options.Default
		elseif self.Options[1] and not options.Placeholder then
			self.Value = self.Options[1]  -- backward compat: auto-select first
		end
		-- AllowNone=false: ensure a valid selection when options exist
		if not self.Multi and not self.AllowNone and #self.Options > 0 and (self.Value == nil or self.Value == "") then
			self.Value = self.Options[1]
		end
		self.Placeholder = options.Placeholder or "Not selected"
		self._selected = {}  -- set of selected values (multi mode)
		self._selectedCount = 0
		if self.Multi then
			local defaults = {}
			if type(options.Default) == "table" then
				defaults = options.Default
			elseif options.Default ~= nil then
				defaults = { options.Default }
			end
			for _, v in ipairs(defaults) do
				self._selected[v] = true
				self._selectedCount = self._selectedCount + 1
			end
		end
		self.Callback = options.Callback or function() end
		self.Flag = options.Flag
		self.Theme = theme
		self.Open = false
		self.HasDesc = self.Description ~= nil and self.Description ~= ""
		local h = self.HasDesc and theme.DescHeight or theme.ElementHeight
		local selectY = self.HasDesc and 32 or 28

		self.Container = U.Create("Frame", {
			Name = "Dropdown",
			Size = UDim2.new(1, -12, 0, h + 16),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			Parent = parent,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = self.Container })
		U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = self.Container })

		U.Create("TextLabel", {
			Name = "Label",
			Size = UDim2.new(1, -70, 0, 20),
			Position = UDim2.fromOffset(12, 6),
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
			BackgroundColor3 = theme.ElementHover,
			AutoButtonColor = false,
			Parent = self.Container,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = self.SelectBtn })
		self._selectStroke = U.Create("UIStroke", {
			Color = theme.Accent,
			Thickness = 1,
			Transparency = self.Value and (self.Value ~= "" and self.Value ~= (self.Options[1] or "")) and 0.5 or 0.8,
			Parent = self.SelectBtn,
		})

		local function initSelectText()
			if self.Multi then
				if self._selectedCount == 0 then return self.Placeholder end
				if self._selectedCount <= 2 then
					local p = {}
					for _, o in ipairs(self.Options) do
						if self._selected[o] then table.insert(p, o) end
					end
					return table.concat(p, ", ")
				end
				return self._selectedCount .. " selected"
			end
			return (self.Value and self.Value ~= "") and tostring(self.Value) or self.Placeholder
		end
		local function initSelectColor()
			if self.Multi then return self._selectedCount > 0 and theme.TextPrimary or theme.TextMuted end
			return (self.Value and self.Value ~= "") and theme.TextPrimary or theme.TextMuted
		end
		self.SelectText = U.Create("TextLabel", {
			Name = "Text",
			Size = UDim2.new(1, -26, 1, 0),
			Position = UDim2.fromOffset(10, 0),
			BackgroundTransparency = 1,
			Text = initSelectText(),
			TextColor3 = initSelectColor(),
			Font = theme.Font,
			TextSize = theme.FontSize,
			TextColor3 = theme.TextPrimary,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = self.SelectBtn,
		})

		self._arrowDown = (resolveIcon("chevron-down") or {}).Image or "rbxassetid://134243273101015"
		self._arrowRight = (resolveIcon("chevron-right") or {}).Image or "rbxassetid://92473583511724"
		self._arrow = U.Create("ImageLabel", {
			Name = "Arrow",
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.new(1, -20, 0.5, -8),
			BackgroundTransparency = 1,
			Image = self._arrowDown,
			Parent = self.SelectBtn,
		})

		-- Find selected index
		local selectedIdx = 0
		for i, opt in ipairs(self.Options) do
			if opt == self.Value then selectedIdx = i; break end
		end

		-- Dropdown toggle
		self.SelectBtn.MouseButton1Click:Connect(function()
			if not self._menu then return end
			if self._menu._activePopupFrame then
				self.Open = false
				if self._arrow then self._arrow.Image = self._arrowDown end
				if self._menu._activeDropdown == self then
					self._menu._activeDropdown = nil
				end
				self._menu:HideDropdownPopup()
			else
				self.Open = true
				if self._arrow then self._arrow.Image = self._arrowRight end
				if self._menu._activeDropdown and self._menu._activeDropdown ~= self then
					self._menu._activeDropdown.Open = false
					if self._menu._activeDropdown._arrow and self._menu._activeDropdown._arrowDown then
						self._menu._activeDropdown._arrow.Image = self._menu._activeDropdown._arrowDown
					end
					self._menu:HideDropdownPopup()
				end
				local pos = self.SelectBtn.AbsolutePosition
				local siz = self.SelectBtn.AbsoluteSize
				self._selIdx = 0
				for i, opt in ipairs(self.Options) do
					if opt == self.Value then self._selIdx = i; break end
				end
				self._menu:ShowDropdownPopup(pos, siz, self.Options, self._selIdx, function(idx, val)
					self:SetValue(val)
				end, self.Multi, self)
				self._menu._activeDropdown = self
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

		-- Tooltip from options
		if options.Tooltip and menuRef then
			menuRef:BindTooltip(self.Container, options.Tooltip)
		end

		return self
	end

	function Dropdown:_updateDisplay()
		-- Update display text from current state (used by SetOptions/Refresh)
		if self.Multi then
			if self._selectedCount == 0 then
				self.SelectText.Text = self.Placeholder
			elseif self._selectedCount <= 2 then
				local parts = {}
				for _, opt in ipairs(self.Options) do
					if self._selected[opt] then table.insert(parts, opt) end
				end
				self.SelectText.Text = table.concat(parts, ", ")
			else
				self.SelectText.Text = self._selectedCount .. " selected"
			end
		else
			self.SelectText.Text = (self.Value ~= "") and tostring(self.Value) or self.Placeholder
		end
	end

	function Dropdown:SetValue(v)
		if self.Multi then
			-- Multi-select: toggle the value
			if not self:_optIndex(self.Options, v) then return end
			if self._selected[v] then
				self._selected[v] = nil
				self._selectedCount = math.max(0, self._selectedCount - 1)
			else
				self._selected[v] = true
				self._selectedCount = self._selectedCount + 1
			end
			-- Update display text
			if self._selectedCount == 0 then
				self.SelectText.Text = ""
			elseif self._selectedCount <= 2 then
				local parts = {}
				for _, opt in ipairs(self.Options) do
					if self._selected[opt] then table.insert(parts, opt) end
				end
				self.SelectText.Text = table.concat(parts, ", ")
			else
				self.SelectText.Text = self._selectedCount .. " selected"
			end
			task.spawn(function() self.Callback(self._selected) end)
			return
		end

		-- Single-select
		if v == self.Value then
			if self._arrow then self._arrow.Image = self._arrowDown end
			if self._menu and self._menu._activeDropdown == self then
				self._menu._activeDropdown = nil
				self._menu:HideDropdownPopup()
			end
			return
		end
		-- AllowNone guard: prevent clearing selection when AllowNone=false and options exist
		if not self.AllowNone and #self.Options > 0 and v == "" then
			if self._arrow then self._arrow.Image = self._arrowDown end
			if self._menu and self._menu._activeDropdown == self then
				self._menu._activeDropdown = nil
				self._menu:HideDropdownPopup()
			end
			return
		end
		self.Value = v
		self.SelectText.Text = tostring(v)
		if self._selectStroke then self._selectStroke.Transparency = 0.5 end
		self._selIdx = 0
		for i, opt in ipairs(self.Options) do
			if opt == v then self._selIdx = i; break end
		end
		self.Open = false
		if self._arrow then self._arrow.Image = self._arrowDown end
		if self._menu and self._menu._activeDropdown == self then
			self._menu._activeDropdown = nil
			self._menu:HideDropdownPopup()
		end
		task.spawn(function() self.Callback(v) end)
	end

	function Dropdown:GetValue()
		if self.Multi then
			local result = {}
			for _, opt in ipairs(self.Options) do
				if self._selected[opt] then table.insert(result, opt) end
			end
			return result
		end
		return self.Value
	end

	function Dropdown:SetOptions(options, preferredValue, noCallback)
		options = options or {}
		local oldValue = self:GetValue()

		-- Replace options list
		self.Options = options

		if self.Multi then
			-- Multi: remove selections that no longer exist in new options
			local optSet = {}
			for _, opt in ipairs(options) do optSet[opt] = true end
			for k in pairs(self._selected) do
				if not optSet[k] then
					self._selected[k] = nil
					self._selectedCount = math.max(0, self._selectedCount - 1)
				end
			end
		else
			-- Single-select: determine new value
			local newValue
			if preferredValue ~= nil then
				if self:_optIndex(options, preferredValue) then
					newValue = preferredValue
				elseif #options == 0 or self.AllowNone then
					newValue = ""
				else
					newValue = options[1]
				end
			elseif self.Value ~= "" and self:_optIndex(options, self.Value) then
				newValue = self.Value
			elseif #options == 0 or self.AllowNone then
				newValue = ""
			else
				newValue = options[1]
			end

			self.Value = newValue

			-- Update stroke
			if self._selectStroke then
				self._selectStroke.Transparency = (self.Value ~= "" and self.Value ~= (options[1] or "")) and 0.5 or 0.8
			end

			-- Update _selIdx
			self._selIdx = 0
			for i, opt in ipairs(options) do
				if opt == self.Value then self._selIdx = i; break end
			end
		end

		-- Update display text
		self:_updateDisplay()

		-- Handle active popup: close and optionally re-open with new options
		if self._menu and self._menu._activeDropdown == self and self._menu._activePopupFrame then
			self._menu._activeDropdown = nil
			self._menu:HideDropdownPopup()
			if #options > 0 then
				local pos = self.SelectBtn.AbsolutePosition
				local siz = self.SelectBtn.AbsoluteSize
				local selIdx = 0
				for i, opt in ipairs(options) do
					if opt == self.Value then selIdx = i; break end
				end
				self._menu:ShowDropdownPopup(pos, siz, options, selIdx, function(idx, val)
					self:SetValue(val)
				end, self.Multi, self)
				self._menu._activeDropdown = self
			end
		end

		-- Fire callback if selection changed (and noCallback is not set)
		if not noCallback then
			if self.Multi then
				task.spawn(function() self.Callback(self._selected) end)
			else
				local newValue = self.Value
				if newValue ~= oldValue then
					task.spawn(function() self.Callback(newValue) end)
				end
			end
		end
	end

	function Dropdown:_optIndex(list, value)
		for i, v in ipairs(list) do
			if v == value then return i end
		end
		return nil
	end

	function Dropdown:Refresh(options, preferredValue, noCallback)
		if options ~= nil then
			self:SetOptions(options, preferredValue, noCallback)
		else
			-- Refresh from current options, preserve current selection
			self:SetOptions(self.Options, self.Value, noCallback)
		end
	end

	function Dropdown:Destroy()
		if self._menu and self._menu._activeDropdown == self then
			self._menu._activeDropdown = nil
		end
		if self.Container then self.Container:Destroy() end
	end

	function Dropdown:ApplyTheme(theme)
		self.Theme = theme
		if not self.Container then return end
		self.Container.BackgroundColor3 = theme.Element
		local stroke = self.Container:FindFirstChildOfClass("UIStroke")
		if stroke then stroke.Color = theme.ElementBorder end
		local lbl = self.Container:FindFirstChild("Label")
		if lbl then
			lbl.Font = theme.Font
			lbl.TextSize = theme.FontSize
			lbl.TextColor3 = theme.TextPrimary
		end
		local desc = self.Container:FindFirstChild("Description")
		if desc then
			desc.Font = theme.Font
			desc.TextSize = theme.FontSizeSmall
			desc.TextColor3 = theme.TextMuted
		end
		self.SelectBtn.BackgroundColor3 = theme.ElementHover
		self.SelectText.Font = theme.Font
		self.SelectText.TextSize = theme.FontSize
		self.SelectText.TextColor3 = theme.TextPrimary
		if self._selectStroke then self._selectStroke.Color = theme.Accent end
	end

	--[[ Keybind ]]
	local Keybind = {}
	Keybind.__index = Keybind

	function Keybind.new(parent, options, theme, menuRef)
		local self = setmetatable({}, Keybind)
		self.Text = options.Text or "Keybind"
		self.Description = options.Description
		self.Mode = options.Mode or "Toggle"
		self.Callback = options.Callback or function() end
		self.Flag = options.Flag
		self.Theme = theme
		self._menu = menuRef
		self._inputType = nil  -- "Keyboard" or "MouseButton"
		self._keyCode = nil
		self._capturing = false
		self._active = false

		-- Parse Default
		if options.Default ~= nil then
			self:SetValue(options.Default)
		end

		self.HasDesc = self.Description ~= nil and self.Description ~= ""
		local h = self.HasDesc and theme.DescHeight or theme.ElementHeight
		local btnW = 100
		local btnOff = btnW + 12

		self.Container = U.Create("Frame", {
			Name = "Keybind",
			Size = UDim2.new(1, -12, 0, h + 6),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			Parent = parent,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = self.Container })
		U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = self.Container })

		-- Label
		self.Label = U.Create("TextLabel", {
			Name = "Label",
			Size = UDim2.new(1, -(btnW + 20), 0, 20),
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

		-- Capture button (right side)
		self.CaptureBtn = U.Create("TextButton", {
			Name = "CaptureBtn",
			Size = UDim2.fromOffset(btnW, 26),
			Position = UDim2.new(1, -btnOff, 0.5, -13),
			BackgroundColor3 = theme.ElementHover,
			BackgroundTransparency = 0,
			Text = "",
			AutoButtonColor = false,
			Parent = self.Container,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = self.CaptureBtn })

		self.KeyLabel = U.Create("TextLabel", {
			Name = "KeyLabel",
			Size = UDim2.new(1, -8, 1, 0),
			Position = UDim2.fromOffset(4, 0),
			BackgroundTransparency = 1,
			Text = "None",
			Font = theme.FontBold,
			TextSize = theme.FontSizeSmall,
			TextColor3 = theme.TextMuted,
			TextXAlignment = Enum.TextXAlignment.Center,
			Parent = self.CaptureBtn,
		})

		-- Description
		if self.HasDesc then
			U.Create("TextLabel", {
				Name = "Description",
				Size = UDim2.new(1, -(btnW + 20), 0, 16),
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

		-- Hover / Click for capture button
		self.CaptureBtn.MouseEnter:Connect(function()
			if self._capturing then return end
			self.CaptureBtn.BackgroundColor3 = theme.Element
		end)
		self.CaptureBtn.MouseLeave:Connect(function()
			if self._capturing then return end
			self.CaptureBtn.BackgroundColor3 = theme.ElementHover
		end)
		self.CaptureBtn.MouseButton1Click:Connect(function()
			self:_toggleCapture()
		end)

		-- Register with menu's keybind router
		if menuRef then
			menuRef:_registerKeybind(self)
		end

		-- Tooltip from options
		if options.Tooltip and menuRef then
			menuRef:BindTooltip(self.Container, options.Tooltip)
		end

		return self
	end

	function Keybind:_formatKeyName()
		if not self._keyCode then return "None" end
		local s = tostring(self._keyCode)
		if self._inputType == "MouseButton" then
			return (s:match("Enum%.UserInputType%.(.+)")) or s
		end
		return (s:match("Enum%.KeyCode%.(.+)")) or "?"
	end

	function Keybind:_updateDisplay()
		local name = self:_formatKeyName()
		self.KeyLabel.Text = name
		self.KeyLabel.TextColor3 = self._keyCode and self.Theme.TextPrimary or self.Theme.TextMuted
	end

	function Keybind:_toggleCapture()
		if self._capturing then self:_exitCapture(); return end
		self._capturing = true
		self.KeyLabel.Text = "..."
		self.KeyLabel.TextColor3 = self.Theme.Accent
		self.CaptureBtn.BackgroundColor3 = self.Theme.Accent
		if self._menu then self._menu._capturingKeybind = self end
	end

	function Keybind:_exitCapture()
		self._capturing = false
		if self._menu then self._menu._capturingKeybind = nil end
		self.CaptureBtn.BackgroundColor3 = self.Theme.ElementHover
		self:_updateDisplay()
	end

	function Keybind:_onInput(input)
		if self.Mode == "Hold" then
			self._active = true
			self.Callback(true, input)
		else
			self._active = not self._active
			self.Callback(self._active, input)
		end
	end

	function Keybind:_onInputEnd(input)
		if self.Mode == "Hold" then
			self._active = false
			self.Callback(false, input)
		end
	end

	function Keybind:_setFromInput(input)
		if input.UserInputType == Enum.UserInputType.Keyboard then
			self._inputType = "Keyboard"
			self._keyCode = input.KeyCode
		elseif input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.MouseButton2
			or input.UserInputType == Enum.UserInputType.MouseButton3 then
			self._inputType = "MouseButton"
			self._keyCode = input.UserInputType
		end
		self:_updateDisplay()
	end

	function Keybind:SetValue(v)
		if v == nil then
			self._inputType = nil
			self._keyCode = nil
			self:_updateDisplay()
			return
		end
		if typeof(v) == "EnumItem" then
			if v.EnumType == Enum.KeyCode then
				self._inputType = "Keyboard"
				self._keyCode = v
				self:_updateDisplay()
				return
			elseif v.EnumType == Enum.UserInputType then
				self._inputType = "MouseButton"
				self._keyCode = v
				self:_updateDisplay()
				return
			end
		end
		if type(v) == "string" then
			-- Try KeyCode first, then UserInputType
			for _, item in ipairs(Enum.KeyCode:GetEnumItems()) do
				if item.Name == v then
					self._inputType = "Keyboard"
					self._keyCode = item
					self:_updateDisplay()
					return
				end
			end
			for _, item in ipairs(Enum.UserInputType:GetEnumItems()) do
				if item.Name == v then
					self._inputType = "MouseButton"
					self._keyCode = item
					self:_updateDisplay()
					return
				end
			end
		end
	end

	function Keybind:GetValue()
		if not self._keyCode then return nil end
		local s = tostring(self._keyCode)
		if self._inputType == "Keyboard" then
			return (s:match("Enum%.KeyCode%.(.+)"))
		else
			return (s:match("Enum%.UserInputType%.(.+)"))
		end
	end

	function Keybind:SetMode(mode)
		self.Mode = mode
	end

	function Keybind:Destroy()
		if self._menu then
			self._menu:_unregisterKeybind(self)
			if self._menu._capturingKeybind == self then
				self._menu._capturingKeybind = nil
			end
		end
		if self.Container then self.Container:Destroy() end
	end

	function Keybind:ApplyTheme(theme)
		self.Theme = theme
		if not self.Container then return end
		self.Container.BackgroundColor3 = theme.Element
		local stroke = self.Container:FindFirstChildOfClass("UIStroke")
		if stroke then stroke.Color = theme.ElementBorder end
		self.Label.Font = theme.Font
		self.Label.TextSize = theme.FontSize
		self.Label.TextColor3 = theme.TextPrimary
		local desc = self.Container:FindFirstChild("Description")
		if desc then
			desc.Font = theme.Font
			desc.TextSize = theme.FontSizeSmall
			desc.TextColor3 = theme.TextMuted
		end
		if not self._capturing then
			self.CaptureBtn.BackgroundColor3 = theme.ElementHover
		end
		self.KeyLabel.Font = theme.FontBold
		self.KeyLabel.TextSize = theme.FontSizeSmall
		self:_updateDisplay()
	end

	--[[ TextInput ]]
	local TextInput = {}
	TextInput.__index = TextInput

	function TextInput.new(parent, options, theme)
		local self = setmetatable({}, TextInput)
		self.Text = options.Text or "Input"
		self.Description = options.Description
		self.Placeholder = options.Placeholder or ""
		self.ClearTextOnFocus = options.ClearTextOnFocus or false
		self.Numeric = options.Numeric or false
		self.Callback = options.Callback or function() end
		self.Flag = options.Flag
		self.Theme = theme
		self._lastValidValue = nil
		self._value = ""

		self.HasDesc = self.Description ~= nil and self.Description ~= ""
		local h = self.HasDesc and theme.DescHeight or theme.ElementHeight
		local textBoxW = 100
		local textBoxOff = textBoxW + 12

		self.Container = U.Create("Frame", {
			Name = "TextInput",
			Size = UDim2.new(1, -12, 0, h + 6),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			Parent = parent,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = self.Container })
		U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = self.Container })

		-- Label
		self.Label = U.Create("TextLabel", {
			Name = "Label",
			Size = UDim2.new(1, -(textBoxW + 20), 0, 20),
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

		-- TextBox (right side)
		self.TextBox = U.Create("TextBox", {
			Name = "TextBox",
			Size = UDim2.fromOffset(textBoxW, 26),
			Position = UDim2.new(1, -textBoxOff, 0.5, -13),
			BackgroundColor3 = theme.ElementHover,
			BackgroundTransparency = 0,
			Text = "",
			PlaceholderText = self.Placeholder,
			Font = theme.Font,
			TextSize = theme.FontSizeSmall,
			TextColor3 = theme.TextPrimary,
			PlaceholderColor3 = theme.TextMuted,
			ClearTextOnFocus = self.ClearTextOnFocus,
			TextXAlignment = Enum.TextXAlignment.Center,
			Parent = self.Container,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = self.TextBox })

		-- Set default value
		if options.Default ~= nil then
			self:SetValue(tostring(options.Default), true)
		end

		-- Hover
		self.TextBox.MouseEnter:Connect(function()
			self.TextBox.BackgroundColor3 = theme.Element
		end)
		self.TextBox.MouseLeave:Connect(function()
			self.TextBox.BackgroundColor3 = theme.ElementHover
		end)

		-- Focus gained
		self.TextBox.Focused:Connect(function()
			self.TextBox.BackgroundColor3 = theme.Element
		end)

		-- Focus lost: validate numeric, commit value
		self.TextBox.FocusLost:Connect(function(enterPressed)
			self.TextBox.BackgroundColor3 = theme.ElementHover
			if self.Numeric then
				local num = tonumber(self.TextBox.Text)
				if num ~= nil then
					self._lastValidValue = num
					self._value = tostring(num)
					self.TextBox.Text = self._value
				else
					-- Revert to last valid value
					if self._lastValidValue ~= nil then
						self._value = tostring(self._lastValidValue)
					else
						self._value = ""
					end
					self.TextBox.Text = self._value
				end
			else
				self._value = self.TextBox.Text
			end
			task.spawn(function() self.Callback(self._value, enterPressed) end)
		end)

		-- Description
		if self.HasDesc then
			U.Create("TextLabel", {
				Name = "Description",
				Size = UDim2.new(1, -(textBoxW + 20), 0, 16),
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

		return self
	end

	function TextInput:SetValue(value, noCallback)
		if self.Numeric then
			local num = tonumber(value)
			if num ~= nil then
				self._lastValidValue = num
				self._value = tostring(num)
				if self.TextBox then self.TextBox.Text = self._value end
			end
		else
			self._value = tostring(value)
			if self.TextBox then self.TextBox.Text = self._value end
		end
		if not noCallback then
			task.spawn(function() self.Callback(self._value, false) end)
		end
	end

	function TextInput:GetValue()
		if self.Numeric then
			return tonumber(self._value) or 0
		end
		return self._value
	end

	function TextInput:Focus()
		if self.TextBox then
			self.TextBox:CaptureFocus()
		end
	end

	function TextInput:Destroy()
		if self.Container then self.Container:Destroy() end
	end

	function TextInput:ApplyTheme(theme)
		self.Theme = theme
		if not self.Container then return end
		self.Container.BackgroundColor3 = theme.Element
		local stroke = self.Container:FindFirstChildOfClass("UIStroke")
		if stroke then stroke.Color = theme.ElementBorder end
		self.Label.Font = theme.Font
		self.Label.TextSize = theme.FontSize
		self.Label.TextColor3 = theme.TextPrimary
		local desc = self.Container:FindFirstChild("Description")
		if desc then
			desc.Font = theme.Font
			desc.TextSize = theme.FontSizeSmall
			desc.TextColor3 = theme.TextMuted
		end
		self.TextBox.BackgroundColor3 = theme.ElementHover
		self.TextBox.Font = theme.Font
		self.TextBox.TextSize = theme.FontSizeSmall
		self.TextBox.TextColor3 = theme.TextPrimary
		self.TextBox.PlaceholderColor3 = theme.TextMuted
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
			Size = UDim2.new(1, -6, 0, 38),
			Position = UDim2.fromOffset(3, 0),
			BackgroundTransparency = 1,
			AutoButtonColor = false,
			Parent = menu.SidebarList,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = self.TabButton })
		-- Active glow overlay (subtle white, visible when tab is selected)
		self._glow = U.Create("Frame", {
			Name = "Glow",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 0,
			Parent = self.TabButton,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = self._glow })
		-- Icon (optional, rbxassetid://...)
		local iconProps = resolveIcon(options.Icon)
		if iconProps then
			U.Create("ImageLabel", {
				Name = "Icon",
				Size = UDim2.fromOffset(18, 18),
				Position = UDim2.fromOffset(14, 10),
				BackgroundTransparency = 1,
				Image = iconProps.Image,
				ImageRectSize = iconProps.ImageRectSize,
				ImageRectOffset = iconProps.ImageRectOffset,
				Parent = self.TabButton,
			})
		end
		local textX = iconProps and 40 or 18
		local textW = iconProps and -44 or -22
		U.Create("TextLabel", {
			Name = "Label",
			Size = UDim2.new(1, textW, 1, 0),
			Position = UDim2.fromOffset(textX, 0),
			BackgroundTransparency = 1,
			Text = self.Text,
			Font = theme.Font,
			TextSize = theme.FontSize,
			TextColor3 = theme.SidebarText,
			TextXAlignment = Enum.TextXAlignment.Left,
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

		-- Bind tooltip to TabButton if provided
		if options.Tooltip and menu then
			menu:BindTooltip(self.TabButton, options.Tooltip)
		end

		table.insert(menu.Tabs, self)
		if #menu.Tabs == 1 then
			menu:SelectTab(self)
		end

		return self
	end

	function Tab:Toggle(options)
		local toggle = Toggle.new(self.Container, options, self.Theme)
		table.insert(self.Components, toggle)
		if toggle.Flag then self.Menu:_trackFlagged(toggle) end
		if options.Tooltip and self.Menu then
			self.Menu:BindTooltip(toggle.Container, options.Tooltip)
		end
		return toggle
	end

	function Tab:Button(options)
		options = options or {}
		local theme = self.Theme
		local hasDesc = options.Description ~= nil and options.Description ~= ""
		local h = hasDesc and theme.DescHeight or theme.ElementHeight
		local btn = {}
		local _btnTextColor = options.Color

		btn.Container = U.Create("ImageButton", {
			Name = "Button",
			Size = UDim2.new(1, -12, 0, h + 8),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0,
			AutoButtonColor = false,
			BorderSizePixel = 0,
			Parent = self.Container,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = btn.Container })
		U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = btn.Container })

		-- Right-side icon (default: mouse-pointer-2, customizable via Icon option)
		local _rightIcon = resolveIcon(options.Icon or "mouse-pointer-2")
		if _rightIcon then
			U.Create("ImageLabel", {
				Name = "Pointer",
				Size = UDim2.fromOffset(42, 42),
				Position = UDim2.new(1, -48, 0.5, -16),
				BackgroundTransparency = 1,
				ImageTransparency = 0.5,
				Image = _rightIcon.Image,
				ImageRectSize = _rightIcon.ImageRectSize,
				ImageRectOffset = _rightIcon.ImageRectOffset,
				Parent = btn.Container,
			})
		end
		local btnIconX = 10
		local btnIconW = -20

		if hasDesc then
			U.Create("TextLabel", {
				Name = "Text",
				Size = UDim2.new(1, btnIconW, 0, 20),
				Position = UDim2.fromOffset(btnIconX, 5),
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
				Size = UDim2.new(1, btnIconW, 0, 16),
				Position = UDim2.fromOffset(btnIconX, 27),
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
				Size = UDim2.new(1, btnIconW, 0, 20),
				Position = UDim2.fromOffset(btnIconX, (h + 8 - 20) / 2),
				BackgroundTransparency = 1,
				Text = options.Text or "Button",
				Font = theme.Font,
				TextSize = theme.FontSize,
				TextColor3 = options.Color or theme.TextPrimary,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = btn.Container,
			})
		end

		btn.Container.MouseEnter:Connect(function()
			btn.Container.BackgroundColor3 = theme.ElementHover
			btn.Container.BackgroundTransparency = 0
		end)
		btn.Container.MouseLeave:Connect(function()
			btn.Container.BackgroundColor3 = theme.Element
			btn.Container.BackgroundTransparency = 0
		end)
		local _scale = U.Create("UIScale", { Parent = btn.Container })
		btn._scaleTween = nil
		btn.Container.MouseButton1Down:Connect(function()
			if btn._scaleTween then btn._scaleTween:Cancel() end
			btn.Container.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
			btn._scaleTween = game:GetService("TweenService"):Create(_scale, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = 0.97 })
			btn._scaleTween:Play()
		end)
		btn.Container.MouseButton1Up:Connect(function()
			if btn._scaleTween then btn._scaleTween:Cancel() end
			btn.Container.BackgroundColor3 = theme.ElementHover
			btn._scaleTween = game:GetService("TweenService"):Create(_scale, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = 1 })
			btn._scaleTween:Play()
		end)
		btn.Container.MouseButton1Click:Connect(function() if options.Callback then options.Callback() end end)
		btn.SetText = function(text)
			local t = btn.Container:FindFirstChild("Text")
			if t then t.Text = text end
		end
		btn.SetCallback = function(cb) options.Callback = cb end
		btn.Destroy = function() if btn.Container then btn.Container:Destroy() end end
		btn.ApplyTheme = function(t)
			if not btn.Container then return end
			btn.Container.BackgroundColor3 = t.Element
			local stroke = btn.Container:FindFirstChildOfClass("UIStroke")
			if stroke then stroke.Color = t.ElementBorder end
			local txt = btn.Container:FindFirstChild("Text")
			if txt then txt.Font = t.Font; txt.TextSize = t.FontSize; txt.TextColor3 = _btnTextColor or t.TextPrimary end
			local desc = btn.Container:FindFirstChild("Description")
			if desc then desc.Font = t.Font; desc.TextSize = t.FontSizeSmall; desc.TextColor3 = t.TextMuted end
		end

		if options.Tooltip and self.Menu then
			self.Menu:BindTooltip(btn.Container, options.Tooltip)
		end
		table.insert(self.Components, btn)
		return btn
	end

	function Tab:Label(options)
		options = options or {}
		local hasDesc = options.Description ~= nil and options.Description ~= ""
		local h = hasDesc and self.Theme.DescHeight or self.Theme.ElementHeight
		local lbl = {}
		local _labelColor = options.Color
		local _labelTextSize = options.TextSize or self.Theme.FontSize

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
			TextSize = _labelTextSize,
			TextColor3 = _labelColor or self.Theme.TextSecondary,
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
		lbl.ApplyTheme = function(t)
			if not lbl.TextLabel then return end
			lbl.TextLabel.Font = t.Font
			lbl.TextLabel.TextSize = _labelTextSize
			lbl.TextLabel.TextColor3 = _labelColor or t.TextSecondary
			local d = lbl.Container:FindFirstChild("Description")
			if d then d.Font = t.Font; d.TextSize = t.FontSizeSmall; d.TextColor3 = t.TextMuted end
		end

		table.insert(self.Components, lbl)
		return lbl
	end

	function Tab:BoldLabel(options)
		options = options or {}
		local hasDesc = options.Description ~= nil and options.Description ~= ""
		local h = hasDesc and self.Theme.DescHeight or self.Theme.ElementHeight
		local lbl = {}
		local _blColor = options.Color
		local _blTextSize = options.TextSize or self.Theme.FontSizeTitle

		lbl.Container = U.Create("Frame", {
			Name = "BoldLabel",
			Size = UDim2.new(1, 0, 0, h),
			BackgroundTransparency = 1,
			Parent = self.Container,
		})

		lbl.TextLabel = U.Create("TextLabel", {
			Name = "Text",
			Size = UDim2.new(1, 0, 0, hasDesc and 22 or h),
			Position = UDim2.fromOffset(0, hasDesc and 2 or (h - 22) / 2 + 1),
			BackgroundTransparency = 1,
			Text = options.Text or "",
			Font = self.Theme.FontBold,
			TextSize = _blTextSize,
			TextColor3 = _blColor or self.Theme.TextPrimary,
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
		lbl.ApplyTheme = function(t)
			if not lbl.TextLabel then return end
			lbl.TextLabel.Font = t.FontBold
			lbl.TextLabel.TextSize = _blTextSize
			lbl.TextLabel.TextColor3 = _blColor or t.TextPrimary
			local d = lbl.Container:FindFirstChild("Description")
			if d then d.Font = t.Font; d.TextSize = t.FontSizeSmall; d.TextColor3 = t.TextMuted end
		end

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
		div.ApplyTheme = function(t)
			local line = div.Container:FindFirstChild("Line")
			if line then line.BackgroundColor3 = t.Border end
		end
		table.insert(self.Components, div)
		return div
	end

	function Tab:Slider(options)
		local slider = Slider.new(self.Container, options, self.Theme)
		table.insert(self.Components, slider)
		if slider.Flag then self.Menu:_trackFlagged(slider) end
		if options.Tooltip and self.Menu then
			self.Menu:BindTooltip(slider.Container, options.Tooltip)
		end
		return slider
	end

	function Tab:Dropdown(options)
		local dd = Dropdown.new(self.Container, options, self.Theme, self.Menu)
		table.insert(self.Components, dd)
		if dd.Flag then self.Menu:_trackFlagged(dd) end
		if options.Tooltip and self.Menu then
			self.Menu:BindTooltip(dd.Container, options.Tooltip)
		end
		return dd
	end

	function Tab:Keybind(options)
		local kb = Keybind.new(self.Container, options, self.Theme, self.Menu)
		table.insert(self.Components, kb)
		if kb.Flag then self.Menu:_trackFlagged(kb) end
		if options.Tooltip and self.Menu then
			self.Menu:BindTooltip(kb.Container, options.Tooltip)
		end
		return kb
	end

	function Tab:Input(options)
		local ti = TextInput.new(self.Container, options, self.Theme)
		table.insert(self.Components, ti)
		if ti.Flag then self.Menu:_trackFlagged(ti) end
		if options.Tooltip and self.Menu then
			self.Menu:BindTooltip(ti.Container, options.Tooltip)
		end
		return ti
	end

	--[[ Checkbox ]]
	local Checkbox = {}
	Checkbox.__index = Checkbox

	function Checkbox.new(parent, options, theme)
		local self = setmetatable({}, Checkbox)
		self.Text = options.Text or "Checkbox"
		self.Value = options.Default or false
		self.Callback = options.Callback or function() end
		self.Flag = options.Flag
		self.Theme = theme
		self.HasDesc = options.Description ~= nil and options.Description ~= ""
		local h = self.HasDesc and theme.DescHeight or theme.ElementHeight

		self.Container = U.Create("Frame", {
			Name = "Checkbox",
			Size = UDim2.new(1, -12, 0, h + 6),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			Parent = parent,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = self.Container })
		U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = self.Container })

		-- Box
		local boxSize = 20
		self.Box = U.Create("ImageButton", {
			Name = "Box",
			Size = UDim2.fromOffset(boxSize, boxSize),
			Position = UDim2.new(1, -(boxSize + 12), 0.5, -boxSize / 2),
			BackgroundColor3 = self.Value and theme.Accent or theme.ElementHover,
			BackgroundTransparency = 0,
			AutoButtonColor = false,
			Parent = self.Container,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = self.Box })
		self.Check = U.Create("TextLabel", {
			Name = "Check",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = self.Value and "✓" or "",
			Font = theme.FontBold,
			TextSize = 16,
			TextColor3 = Color3.fromRGB(255,255,255),
			TextXAlignment = Enum.TextXAlignment.Center,
			Parent = self.Box,
		})

		-- Label
		self.Label = U.Create("TextLabel", {
			Name = "Label",
			Size = UDim2.new(1, -(boxSize + 24), 0, 20),
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
				Size = UDim2.new(1, -(boxSize + 24), 0, 16),
				Position = UDim2.fromOffset(10, 28),
				BackgroundTransparency = 1,
				Text = options.Description,
				Font = theme.Font,
				TextSize = theme.FontSizeSmall,
				TextColor3 = theme.TextMuted,
				TextXAlignment = Enum.TextXAlignment.Left,
				RichText = true,
				Parent = self.Container,
			})
		end

		-- Hover + Click
		self.Box.MouseEnter:Connect(function()
			self.Box.BackgroundColor3 = self.Value and theme.Accent or theme.Element
		end)
		self.Box.MouseLeave:Connect(function()
			self.Box.BackgroundColor3 = self.Value and theme.Accent or theme.ElementHover
		end)
		self.Box.MouseButton1Click:Connect(function()
			self:SetValue(not self.Value)
		end)

		return self
	end

	function Checkbox:SetValue(v, instant)
		if self.Value == v then return end
		self.Value = v
		local ts = game:GetService("TweenService")
		local ti = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		if instant then
			self.Box.BackgroundColor3 = v and self.Theme.Accent or self.Theme.ElementHover
			self.Check.Text = v and "✓" or ""
		else
			ts:Create(self.Box, ti, { BackgroundColor3 = v and self.Theme.Accent or self.Theme.ElementHover }):Play()
			task.spawn(function()
				if v then
					self.Check.Text = ""
					task.wait(0.05)
					self.Check.Text = "✓"
				else
					self.Check.Text = ""
				end
			end)
		end
		task.spawn(function() self.Callback(v) end)
	end
	function Checkbox:GetValue() return self.Value end
	function Checkbox:Destroy() if self.Container then self.Container:Destroy() end end

	function Checkbox:ApplyTheme(theme)
		self.Theme = theme
		if not self.Container then return end
		self.Container.BackgroundColor3 = theme.Element
		local stroke = self.Container:FindFirstChildOfClass("UIStroke")
		if stroke then stroke.Color = theme.ElementBorder end
		self.Label.Font = theme.Font
		self.Label.TextSize = theme.FontSize
		self.Label.TextColor3 = theme.TextPrimary
		local desc = self.Container:FindFirstChild("Description")
		if desc then
			desc.Font = theme.Font
			desc.TextSize = theme.FontSizeSmall
			desc.TextColor3 = theme.TextMuted
		end
		self.Box.BackgroundColor3 = self.Value and theme.Accent or theme.ElementHover
		self.Check.Font = theme.FontBold
	end

	--[[ Collapsible Section ]]
	local Collapsible = {}
	Collapsible.__index = Collapsible

	function Collapsible.new(parent, title, options, theme)
		local self = setmetatable({}, Collapsible)
		self.Theme = theme
		self.Components = {}
		self._isOpen = options and options.DefaultOpen ~= false
		self._tween = nil
		self._closed = false

		-- Container
		self.Container = U.Create("Frame", {
			Name = "Collapsible",
			Size = UDim2.new(1, -12, 0, 34),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			Parent = parent,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = self.Container })
		U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = self.Container })

		-- Header button
		self.Header = U.Create("ImageButton", {
			Name = "Header",
			Size = UDim2.new(1, 0, 0, 34),
			BackgroundColor3 = theme.ElementHover,
			BackgroundTransparency = 0.3,
			AutoButtonColor = false,
			Parent = self.Container,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = self.Header })
		-- Arrow (far right, Active=false so clicks pass through to Header)
		self.Arrow = U.Create("TextLabel", {
			Name = "Arrow",
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.new(1, -24, 0.5, -8),
			BackgroundTransparency = 1,
			Text = self._isOpen and "▼" or "▶",
			Font = theme.FontBold,
			TextSize = 12,
			TextColor3 = theme.TextSecondary,
			Active = false,
			Parent = self.Header,
		})
		-- Title (left, Active=false so clicks pass through to Header)
		self.Title = U.Create("TextLabel", {
			Name = "Title",
			Size = UDim2.new(1, -40, 1, 0),
			Position = UDim2.fromOffset(12, 0),
			BackgroundTransparency = 1,
			Text = title,
			Font = theme.FontBold,
			TextSize = theme.FontSize,
			TextColor3 = theme.TextPrimary,
			TextXAlignment = Enum.TextXAlignment.Left,
			Active = false,
			Parent = self.Header,
		})

		-- Content area (children go here)
		self.Content = U.Create("Frame", {
			Name = "Content",
			Size = UDim2.new(1, 0, 0, 0),
			Position = UDim2.fromOffset(0, 34),
			BackgroundTransparency = 1,
			Parent = self.Container,
		})
		local layout = U.Create("UIListLayout", {
			Padding = UDim.new(0, theme.Spacing),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = self.Content,
		})
		self._layout = layout

		-- Resize when content changes
		self._layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			if not self._closed then self:_updateSize() end
		end)

		-- Click header to toggle
		self.Header.MouseEnter:Connect(function()
			self.Header.BackgroundColor3 = theme.TabHover
			self.Header.BackgroundTransparency = 0
		end)
		self.Header.MouseLeave:Connect(function()
			self.Header.BackgroundColor3 = theme.ElementHover
			self.Header.BackgroundTransparency = 0.3
		end)
		self.Header.MouseButton1Click:Connect(function()
			self:ToggleOpen()
		end)

		-- Initialize height
		task.spawn(function()
			task.wait()
			if not self._closed then self:_updateSize(true) end
		end)

		return self
	end

	function Collapsible:SetOpen(v)
		if self._isOpen == v then return end
		self._isOpen = v
		self.Arrow.Text = v and "▼" or "▶"
		if self._tween then self._tween:Cancel() end
		if not self.Container then return end
		local ts = game:GetService("TweenService")
		local ti = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local contentH = self._layout and self._layout.AbsoluteContentSize.Y or 0
		local targetH = v and (34 + contentH) or 34
		self._tween = ts:Create(self.Container, ti, { Size = UDim2.new(1, -12, 0, targetH) }):Play()
	end

	function Collapsible:ToggleOpen()
		self:SetOpen(not self._isOpen)
	end

	function Collapsible:Open()
		self:SetOpen(true)
	end
	function Collapsible:Close()
		self:SetOpen(false)
	end

	function Collapsible:_updateSize(instant)
		if self._closed or not self._layout or not self.Container or not self.Container.Parent then return end
		if self._tween then self._tween:Cancel() end
		local contentH = self._layout.AbsoluteContentSize.Y
		local targetH = self._isOpen and (34 + contentH) or 34
		if instant then
			self.Container.Size = UDim2.new(1, -12, 0, targetH)
		else
			local ts = game:GetService("TweenService")
			self._tween = ts:Create(self.Container, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.new(1, -12, 0, targetH) }):Play()
		end
	end

	-- Pass-through methods (all default opts to {}; Tooltip auto-bound via self._menu)
	function Collapsible:Toggle(opts) opts = opts or {}; local c = Toggle.new(self.Content, opts, self.Theme); table.insert(self.Components, c); if c.Flag and self._menu then self._menu:_trackFlagged(c) end; if opts.Tooltip and self._menu then self._menu:BindTooltip(c.Container, opts.Tooltip) end; self:_updateSize(); return c end
	function Collapsible:Checkbox(opts) opts = opts or {}; local c = Checkbox.new(self.Content, opts, self.Theme); table.insert(self.Components, c); if c.Flag and self._menu then self._menu:_trackFlagged(c) end; if opts.Tooltip and self._menu then self._menu:BindTooltip(c.Container, opts.Tooltip) end; self:_updateSize(); return c end
	function Collapsible:Slider(opts) opts = opts or {}; local c = Slider.new(self.Content, opts, self.Theme); table.insert(self.Components, c); if c.Flag and self._menu then self._menu:_trackFlagged(c) end; if opts.Tooltip and self._menu then self._menu:BindTooltip(c.Container, opts.Tooltip) end; self:_updateSize(); return c end
	function Collapsible:Dropdown(opts) opts = opts or {}; local c = Dropdown.new(self.Content, opts, self.Theme, self._menu or nil); table.insert(self.Components, c); if c.Flag and self._menu then self._menu:_trackFlagged(c) end; if opts.Tooltip and self._menu then self._menu:BindTooltip(c.Container, opts.Tooltip) end; self:_updateSize(); return c end
	function Collapsible:Keybind(opts) opts = opts or {}; local c = Keybind.new(self.Content, opts, self.Theme, self._menu or nil); table.insert(self.Components, c); if c.Flag and self._menu then self._menu:_trackFlagged(c) end; if opts.Tooltip and self._menu then self._menu:BindTooltip(c.Container, opts.Tooltip) end; self:_updateSize(); return c end
	function Collapsible:Input(opts) opts = opts or {}; local c = TextInput.new(self.Content, opts, self.Theme); table.insert(self.Components, c); if c.Flag and self._menu then self._menu:_trackFlagged(c) end; if opts.Tooltip and self._menu then self._menu:BindTooltip(c.Container, opts.Tooltip) end; self:_updateSize(); return c end
	function Collapsible:Button(opts)
		opts = opts or {}
		local theme = self.Theme
		local hasDesc = opts.Description ~= nil and opts.Description ~= ""
		local h = hasDesc and theme.DescHeight or theme.ElementHeight
		local btn = {}
		btn.Container = U.Create("ImageButton", { Name = "Button", Size = UDim2.new(1, -12, 0, h + 8), Position = UDim2.fromOffset(6, 0), BackgroundColor3 = theme.Element, BackgroundTransparency = 0, AutoButtonColor = false, BorderSizePixel = 0, Parent = self.Content })
		U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = btn.Container })
		U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = btn.Container })
		local _ri = resolveIcon(opts.Icon or "mouse-pointer-2")
		if _ri then U.Create("ImageLabel", { Name = "Pointer", Size = UDim2.fromOffset(42, 42), Position = UDim2.new(1, -48, 0.5, -16), BackgroundTransparency = 1, ImageTransparency = 0.5, Image = _ri.Image, Parent = btn.Container }) end
		local ix = 10
		if hasDesc then
			U.Create("TextLabel", { Name = "Text", Size = UDim2.new(1, -20, 0, 20), Position = UDim2.fromOffset(ix, 5), BackgroundTransparency = 1, Text = opts.Text or "Button", Font = theme.Font, TextSize = theme.FontSize, TextColor3 = opts.Color or theme.TextPrimary, TextXAlignment = Enum.TextXAlignment.Left, Parent = btn.Container })
			U.Create("TextLabel", { Name = "Description", Size = UDim2.new(1, -20, 0, 16), Position = UDim2.fromOffset(ix, 27), BackgroundTransparency = 1, Text = opts.Description, Font = theme.Font, TextSize = theme.FontSizeSmall, TextColor3 = theme.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, RichText = true, Parent = btn.Container })
		else
			U.Create("TextLabel", { Name = "Text", Size = UDim2.new(1, -20, 0, 20), Position = UDim2.fromOffset(ix, (h + 8 - 20) / 2), BackgroundTransparency = 1, Text = opts.Text or "Button", Font = theme.Font, TextSize = theme.FontSize, TextColor3 = opts.Color or theme.TextPrimary, TextXAlignment = Enum.TextXAlignment.Left, Parent = btn.Container })
		end
		local _sc = U.Create("UIScale", { Parent = btn.Container })
		btn.Container.MouseEnter:Connect(function() btn.Container.BackgroundColor3 = theme.ElementHover; btn.Container.BackgroundTransparency = 0 end)
		btn.Container.MouseLeave:Connect(function() btn.Container.BackgroundColor3 = theme.Element; btn.Container.BackgroundTransparency = 0 end)
		btn.Container.MouseButton1Down:Connect(function() game:GetService("TweenService"):Create(_sc, TweenInfo.new(0.05), { Scale = 0.97 }):Play() end)
		btn.Container.MouseButton1Up:Connect(function() game:GetService("TweenService"):Create(_sc, TweenInfo.new(0.08), { Scale = 1 }):Play() end)
		btn.Container.MouseButton1Click:Connect(function() if opts.Callback then opts.Callback() end end)
		btn.Destroy = function() if btn.Container then btn.Container:Destroy() end end
		local _btnColor = opts.Color
		btn.ApplyTheme = function(t)
			if not btn.Container then return end
			btn.Container.BackgroundColor3 = t.Element
			local s = btn.Container:FindFirstChildOfClass("UIStroke")
			if s then s.Color = t.ElementBorder end
			local txt = btn.Container:FindFirstChild("Text")
			if txt then txt.Font = t.Font; txt.TextSize = t.FontSize; txt.TextColor3 = _btnColor or t.TextPrimary end
			local d = btn.Container:FindFirstChild("Description")
			if d then d.Font = t.Font; d.TextSize = t.FontSizeSmall; d.TextColor3 = t.TextMuted end
		end
		if opts.Tooltip and self._menu then self._menu:BindTooltip(btn.Container, opts.Tooltip) end
		table.insert(self.Components, btn); self:_updateSize(); return btn
	end
	function Collapsible:Label(opts)
		opts = opts or {}
		local theme = self.Theme
		local hasDesc = opts.Description ~= nil and opts.Description ~= ""
		local h = hasDesc and theme.DescHeight or theme.ElementHeight
		local lbl = {}
		local _lblColor = opts.Color
		local _lblTextSize = opts.TextSize or theme.FontSize
		lbl.Container = U.Create("Frame", { Name = "Label", Size = UDim2.new(1, 0, 0, h), BackgroundTransparency = 1, Parent = self.Content })
		lbl.TextLabel = U.Create("TextLabel", { Name = "Text", Size = UDim2.new(1, 0, 0, hasDesc and 20 or h), Position = UDim2.fromOffset(0, hasDesc and 2 or (h - 20) / 2 + 1), BackgroundTransparency = 1, Text = opts.Text or "", Font = theme.Font, TextSize = _lblTextSize, TextColor3 = _lblColor or theme.TextSecondary, TextXAlignment = Enum.TextXAlignment.Left, RichText = true, Parent = lbl.Container })
		if hasDesc then U.Create("TextLabel", { Name = "Description", Size = UDim2.new(1, 0, 0, 16), Position = UDim2.fromOffset(0, 24), BackgroundTransparency = 1, Text = opts.Description, Font = theme.Font, TextSize = theme.FontSizeSmall, TextColor3 = theme.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, RichText = true, Parent = lbl.Container }) end
		lbl.Destroy = function() if lbl.Container then lbl.Container:Destroy() end end
		lbl.ApplyTheme = function(t)
			if not lbl.TextLabel then return end
			lbl.TextLabel.Font = t.Font
			lbl.TextLabel.TextSize = _lblTextSize
			lbl.TextLabel.TextColor3 = _lblColor or t.TextSecondary
			local d = lbl.Container:FindFirstChild("Description")
			if d then d.Font = t.Font; d.TextSize = t.FontSizeSmall; d.TextColor3 = t.TextMuted end
		end
		table.insert(self.Components, lbl); self:_updateSize(); return lbl
	end
	function Collapsible:BoldLabel(opts)
		opts = opts or {}
		local theme = self.Theme
		local hasDesc = opts.Description ~= nil and opts.Description ~= ""
		local h = hasDesc and theme.DescHeight or theme.ElementHeight
		local lbl = {}
		local _blblColor = opts.Color
		local _blblTextSize = opts.TextSize or theme.FontSizeTitle
		lbl.Container = U.Create("Frame", { Name = "BoldLabel", Size = UDim2.new(1, 0, 0, h), BackgroundTransparency = 1, Parent = self.Content })
		lbl.TextLabel = U.Create("TextLabel", { Name = "Text", Size = UDim2.new(1, 0, 0, hasDesc and 22 or h), Position = UDim2.fromOffset(0, hasDesc and 2 or (h - 22) / 2 + 1), BackgroundTransparency = 1, Text = opts.Text or "", Font = theme.FontBold, TextSize = _blblTextSize, TextColor3 = _blblColor or theme.TextPrimary, TextXAlignment = Enum.TextXAlignment.Left, RichText = true, Parent = lbl.Container })
		if hasDesc then U.Create("TextLabel", { Name = "Description", Size = UDim2.new(1, 0, 0, 16), Position = UDim2.fromOffset(0, 24), BackgroundTransparency = 1, Text = opts.Description, Font = theme.Font, TextSize = theme.FontSizeSmall, TextColor3 = theme.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, RichText = true, Parent = lbl.Container }) end
		lbl.Destroy = function() if lbl.Container then lbl.Container:Destroy() end end
		lbl.ApplyTheme = function(t)
			if not lbl.TextLabel then return end
			lbl.TextLabel.Font = t.FontBold
			lbl.TextLabel.TextSize = _blblTextSize
			lbl.TextLabel.TextColor3 = _blblColor or t.TextPrimary
			local d = lbl.Container:FindFirstChild("Description")
			if d then d.Font = t.Font; d.TextSize = t.FontSizeSmall; d.TextColor3 = t.TextMuted end
		end
		table.insert(self.Components, lbl); self:_updateSize(); return lbl
	end
	function Collapsible:Divider() local div = {}; div.Container = U.Create("Frame", { Name = "Divider", Size = UDim2.new(1, -20, 0, 1), Position = UDim2.fromOffset(10, 0), BackgroundColor3 = self.Theme.Border, BackgroundTransparency = 0.5, BorderSizePixel = 0, Parent = self.Content }); div.ApplyTheme = function(t) if div.Container then div.Container.BackgroundColor3 = t.Border end end; table.insert(self.Components, div); self:_updateSize(); return div end
	function Collapsible:Destroy()
		self._closed = true
		if self._tween then self._tween:Cancel() end
		for _, c in ipairs(self.Components) do if c.Destroy then c:Destroy() end end
		self.Components = {}
		if self.Container then self.Container:Destroy() end
	end

	function Collapsible:ApplyTheme(theme)
		self.Theme = theme
		if not self.Container then return end
		self.Container.BackgroundColor3 = theme.Element
		local stroke = self.Container:FindFirstChildOfClass("UIStroke")
		if stroke then stroke.Color = theme.ElementBorder end
		self.Header.BackgroundColor3 = theme.ElementHover
		self.Arrow.Font = theme.FontBold
		self.Arrow.TextColor3 = theme.TextSecondary
		self.Title.Font = theme.FontBold
		self.Title.TextSize = theme.FontSize
		self.Title.TextColor3 = theme.TextPrimary
		if self._layout then self._layout.Padding = UDim.new(0, theme.Spacing) end
		for _, c in ipairs(self.Components) do
			if c.ApplyTheme then c:ApplyTheme(theme) end
		end
	end

	--[[ Tab methods ]]
	function Tab:Checkbox(options)
		local c = Checkbox.new(self.Container, options, self.Theme)
		table.insert(self.Components, c)
		if c.Flag then self.Menu:_trackFlagged(c) end
		if options.Tooltip and self.Menu then
			self.Menu:BindTooltip(c.Container, options.Tooltip)
		end
		return c
	end
	function Tab:Collapsible(title, options)
		local c = Collapsible.new(self.Container, title, options, self.Theme)
		c._menu = self.Menu
		table.insert(self.Components, c)
		return c
	end
	function Tab:Destroy()
		for _, c in ipairs(self.Components) do
			if c.Destroy then c:Destroy() end
		end
		self.Components = {}
		if self.Container then self.Container:Destroy() end
		if self.TabButton then self.TabButton:Destroy() end
	end

	function Tab:ApplyTheme(theme)
		self.Theme = theme
		if not self.TabButton then return end
		-- Tab button label
		local lbl = self.TabButton:FindFirstChild("Label")
		if lbl then
			lbl.Font = theme.Font
			lbl.TextSize = theme.FontSize
		end
		-- Container (ScrollingFrame)
		if self.Container then
			self.Container.ScrollBarImageColor3 = theme.ScrollBar
			local layout = self.Container:FindFirstChildOfClass("UIListLayout")
			if layout then layout.Padding = UDim.new(0, theme.Spacing) end
		end
		-- Push to every child component
		for _, c in ipairs(self.Components) do
			if c.ApplyTheme then c:ApplyTheme(theme) end
		end
		-- Re-apply active/inactive styling
		if self.Menu and self.Menu.ActiveTab == self then
			self.TabButton.BackgroundTransparency = 0
			self.TabButton.BackgroundColor3 = theme.TabActive
			if self._glow then self._glow.BackgroundTransparency = 0.85 end
			if lbl then lbl.TextColor3 = theme.SidebarTextActive end
		else
			self.TabButton.BackgroundTransparency = 1
			if lbl then lbl.TextColor3 = theme.SidebarText end
		end
	end

	--[[ Menu ]]
	local Menu = {}
	Menu.__index = Menu

	function Menu.new(options, theme)
		local self = setmetatable({}, Menu)
		self.Options = options
		self.Theme = theme
		self.Tabs = {}
		self._flagRegistry = {}
		self._keybindList = {}
		self._capturingKeybind = nil
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
		self._paletteConns = {}
		self.ActiveTab = nil
		self.Visible = options.Visible ~= false
		self.MinSize = options.MinSize or Vector2.new(320, 300)
		self.MaxSize = options.MaxSize or Vector2.new(850, 560)
		self.Resizable = options.Resizable or false
		self.Scale = options.Scale or 1
		self._reducedMotion = options.ReducedMotion or false

		-- Tooltip state
		self._tooltips = {}
		self._tooltipActive = false
		self._tooltipPending = false
		self._tooltipTarget = nil
		self._tooltipTween = nil
		self._mousePos = Vector2.new(0, 0)

		local size = options.Size and Vector2.new(options.Size.X.Offset, options.Size.Y.Offset) or Vector2.new(592, 340)
		local pos = options.Position or UDim2.new(0.5, -size.X / 2, 0.5, -size.Y / 2)
		self._initialSize = UDim2.fromOffset(size.X, size.Y)
		self._initialPos = pos

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

			local macIcons = {
				Close = resolveIcon("x"),
				Minimize = resolveIcon("minus"),
				Maximize = resolveIcon("scan"),
			}
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
				local icon = macIcons[name]
				if icon then
					U.Create("ImageLabel", {
						Name = "Icon",
						Size = UDim2.fromOffset(8, 8),
						Position = UDim2.fromScale(0.5, 0.5),
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundTransparency = 1,
						Image = icon.Image,
						ImageRectSize = icon.ImageRectSize,
						ImageRectOffset = icon.ImageRectOffset,
						ImageColor3 = Color3.fromRGB(60, 60, 72),
						Parent = b,
					})
				end
				b.MouseButton1Click:Connect(action)
				rightMargin = rightMargin + btnSize + spacing
				return b
			end

			macBtn("Close", btnColors.Close, function() self:_confirmClose() end)
			macBtn("Minimize", btnColors.Minimize, function()
				if self.Minimized then self:_restore() else self:_minimize() end
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
					Size = UDim2.fromOffset(26, 26),
					Position = UDim2.new(1, xOff, 0.5, -13),
					BackgroundTransparency = 1,
					AutoButtonColor = false,
					Parent = self.Topbar,
				})
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
				b.MouseButton1Click:Connect(action)
				return b
			end
			-- Helper: reset window button hover states
			local function resetWinHover()
				for _, child in ipairs(self.Topbar:GetChildren()) do
					if child:IsA("ImageButton") then
						child.BackgroundTransparency = 1
						local ic = child:FindFirstChild("Icon")
						if ic then ic.ImageColor3 = Color3.fromRGB(150, 150, 165) end
					end
				end
			end
			winBtn("Close", function() self:_confirmClose() end, -36, Color3.fromRGB(200, 60, 60))
			winBtn("Maximize", function()
				resetWinHover()
				self:_toggleMaximize()
			end, -66, Color3.fromRGB(45, 45, 55))
			winBtn("Minimize", function()
				if self.Minimized then
					resetWinHover()
					self:_restore()
				else
					self:_minimize()
				end
			end, -96, Color3.fromRGB(45, 45, 55))
		end

		-- Logo image for floating minimize icon (true=default, string=custom, nil=false)
		local _logoImage = options.Logo == true and "rbxassetid://106899268176689" or type(options.Logo) == "string" and options.Logo or nil

		-- Title vertical separator | — aligns with SidebarLine (sbw + 4)
		local sepX = theme.SidebarWidth + 4
		self.TitleSep = U.Create("Frame", {
			Name = "TitleSep",
			Size = UDim2.fromOffset(2, theme.TopbarHeight),
			Position = UDim2.fromOffset(sepX, 0),
			BackgroundColor3 = Color3.fromRGB(140, 80, 255),
			BorderSizePixel = 0,
			ZIndex = 1,
			Parent = self.Topbar,
		})

		-- Title
		self.Title = U.Create("TextLabel", {
			Name = "Title",
			Size = UDim2.new(1, -(leftMargin + 50), 1, 0),
			Position = UDim2.fromOffset(leftMargin + 18, 0),
			BackgroundTransparency = 1,
			Text = "<i>" .. (options.Title or "FyyUI") .. "</i>",
			Font = theme.FontBold,
			TextSize = theme.FontSizeTitle,
			TextColor3 = theme.TextPrimary,
			TextXAlignment = titleAlign == "Right" and Enum.TextXAlignment.Right or Enum.TextXAlignment.Left,
			RichText = true,
			Parent = self.Topbar,
		})

		-- MS / FPS display (right after TitleSep) — enabled via options.Stats = true
		if options.Stats then
			local statsX = sepX + 18
			self.StatusLabel = U.Create("TextLabel", {
				Name = "Status",
				Size = UDim2.new(1, -(statsX + 50), 1, 0),
				Position = UDim2.fromOffset(statsX, 0),
				BackgroundTransparency = 1,
				Text = "---",
				Font = theme.FontBold,
				TextSize = theme.FontSizeSmall,
				TextColor3 = theme.TextPrimary,
				TextXAlignment = Enum.TextXAlignment.Left,
				RichText = true,
				Parent = self.Topbar,
			})
			local _frameCount = 0
			local _lastTime = tick()
			local _currentFps = 0
			local _currentPing = 0
			local _pingTime = tick()
			local _green = Color3.fromRGB(0, 200, 80)
			local _yellow = Color3.fromRGB(230, 200, 0)
			local _red = Color3.fromRGB(230, 50, 50)
			local function _hex(c)
				local ok, h = pcall(c.ToHex, c)
				if ok and h then return h end
				return ("%02x%02x%02x"):format(c.R * 255, c.G * 255, c.B * 255)
			end
			self._heartbeatCon = game:GetService("RunService").Heartbeat:Connect(function()
				if not self.StatusLabel then return end
				-- FPS counter
				_frameCount = _frameCount + 1
				local now = tick()
				if now - _lastTime >= 1 then
					_currentFps = _frameCount
					_frameCount = 0
					_lastTime = now
				end
				-- Ping every 2s
				if now - _pingTime >= 2 then
					_pingTime = now
					local ok, v = pcall(function()
						local s = game:GetService("Stats")
						return s.Network.ServerStatsItem["Data Ping"]:GetValue()
					end)
					if ok then _currentPing = math.floor(v) end
				end
				-- Build text
				local fpsColor = _currentFps >= 50 and _green or _currentFps >= 40 and _yellow or _red
				local pingColor = _currentPing > 0 and (_currentPing < 80 and _green or _currentPing < 120 and _yellow or _red)
				self.StatusLabel.Text = ("<font color='#%s'>%s FPS</font>"):format(_hex(fpsColor), _currentFps)
				if _currentPing > 0 then
					self.StatusLabel.Text = self.StatusLabel.Text .. (" • <font color='#%s'>%s MS</font>"):format(_hex(pingColor), _currentPing)
				end
			end)
		end

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
				self.AccentLine.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
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
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
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

		-- Floating minimize icon (only if Logo is set)
		if _logoImage then
			self._minGui = U.Create("ScreenGui", {
				Name = "FyyUI_Min",
				DisplayOrder = 999,
				ResetOnSpawn = false,
				Enabled = false,
			})
			local iconSize = 50
			self._minFrame = U.Create("ImageButton", {
				Name = "MinIcon",
				Size = UDim2.fromOffset(iconSize, iconSize),
				Position = UDim2.new(0.5, -iconSize / 2, 0.5, -iconSize / 2),
				BackgroundColor3 = Color3.fromRGB(20, 20, 20),
				BackgroundTransparency = 0,
				BorderSizePixel = 0,
				AutoButtonColor = false,
				Parent = self._minGui,
			})
			U.Create("UICorner", { CornerRadius = UDim.new(0, 12), Parent = self._minFrame })
			U.Create("UIStroke", { Color = Color3.fromRGB(138, 43, 226), Thickness = 2, Parent = self._minFrame })
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
				if i.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
					didDrag = false
					dragStart = i.Position
					startPos = self._minFrame.Position
				end
			end)
			self._minFrame.InputEnded:Connect(function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
					if not didDrag then
						self:_restore()
					end
				end
			end)
			self._minDragInputCon = game:GetService("UserInputService").InputChanged:Connect(function(i)
				if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
					local delta = i.Position - dragStart
					if delta.Magnitude > 5 then didDrag = true end
					self._minFrame.Position = UDim2.new(
						startPos.X.Scale, startPos.X.Offset + delta.X,
						startPos.Y.Scale, startPos.Y.Offset + delta.Y
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
				BackgroundColor3 = Color3.fromRGB(20, 20, 20),
				BackgroundTransparency = 0,
				Text = "☰",
				Font = Enum.Font.GothamBold,
				TextSize = 24,
				TextColor3 = Color3.fromRGB(200, 200, 200),
				AutoButtonColor = false,
				Parent = self._noLogoRestoreGui,
			})
			U.Create("UICorner", { CornerRadius = UDim.new(0, 12), Parent = self._noLogoRestoreBtn })
			U.Create("UIStroke", { Color = Color3.fromRGB(138, 43, 226), Thickness = 2, Parent = self._noLogoRestoreBtn })
			self._noLogoRestoreBtn.MouseButton1Click:Connect(function()
				self:_restore()
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

		self.Gui.Parent = options.Parent or game:GetService("CoreGui")

		if self.Resizable then
			self:_resizable()
		end

		-- Keybind service router (single UIS connection for all keybinds)
		do
			local uis = game:GetService("UserInputService")
			self._keybindInputCon = uis.InputBegan:Connect(function(input, gpe)
				-- Ctrl+K: toggle command palette (before capture/gpe checks)
				if not self._capturingKeybind
					and input.UserInputType == Enum.UserInputType.Keyboard
					and input.KeyCode == Enum.KeyCode.K
					and (uis:IsKeyDown(Enum.KeyCode.LeftControl) or uis:IsKeyDown(Enum.KeyCode.RightControl)) then
					local focusedBox = uis:GetFocusedTextBox()
					if focusedBox and focusedBox ~= self._paletteSearchBox then return end
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
					if input.UserInputType == Enum.UserInputType.Keyboard
						or input.UserInputType == Enum.UserInputType.MouseButton1
						or input.UserInputType == Enum.UserInputType.MouseButton2
						or input.UserInputType == Enum.UserInputType.MouseButton3 then
						kb:_setFromInput(input)
						kb:_exitCapture()
					end
					return
				end

				-- When palette is open, let it handle navigation keys
				if self._paletteOpen and input.UserInputType == Enum.UserInputType.Keyboard then
					local k = input.KeyCode
					if k == Enum.KeyCode.Up or k == Enum.KeyCode.Down or k == Enum.KeyCode.Return or k == Enum.KeyCode.Escape then
						return
					end
				end

				-- Normal routing: skip if GUI processed the event (TextBox focused etc)
				if gpe then return end

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
				if gpe then return end
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

		return self
	end

	function Menu:SelectTab(tab)
		if self.ActiveTab == tab then return end
		self:HideDropdownPopup()
		local ts = game:GetService("TweenService")
		local ti = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local offsetY = 36

		-- Hide old tab content immediately (no glitchy slide-out)
		local hadPrevTab = self.ActiveTab ~= nil
		if self.ActiveTab then
			local old = self.ActiveTab
			old.Container.Visible = false
			old.Container.Position = UDim2.fromOffset(6, 3) -- reset
			old.TabButton.BackgroundTransparency = 1
			if old._glow then old._glow.BackgroundTransparency = 1 end
			local lbl = old.TabButton:FindFirstChild("Label")
			if lbl then lbl.TextColor3 = self.Theme.SidebarText end
		end

		self.ActiveTab = tab
		if tab then
			-- New tab slides in from below
			tab.Container.Position = UDim2.fromOffset(6, offsetY)
			tab.Container.Visible = true
			ts:Create(tab.Container, ti, { Position = UDim2.fromOffset(6, 3) }):Play()

			-- Shared ActiveBar slides to this tab's position (calculated from index, not layout)
			if self.ActiveBar then
				local tabIdx = 0
				for i, t in ipairs(self.Tabs) do
					if t == tab then tabIdx = i; break end
				end
				local targetY = (tabIdx - 1) * 40 + 9 -- (38 height + 2 padding) + bar center offset (38-20)/2
				self.ActiveBar.BackgroundTransparency = 0
				if hadPrevTab then
					ts:Create(self.ActiveBar, ti, { Position = UDim2.fromOffset(5, targetY) }):Play()
				else
					self.ActiveBar.Position = UDim2.fromOffset(5, targetY)
				end
			end

			-- Tab button visual
			tab.TabButton.BackgroundTransparency = 0
			tab.TabButton.BackgroundColor3 = self.Theme.TabActive
			if tab._glow then tab._glow.BackgroundTransparency = 0.85 end
			local lbl = tab.TabButton:FindFirstChild("Label")
			if lbl then lbl.TextColor3 = self.Theme.SidebarTextActive end
		end
	end

	function Menu:ShowDropdownPopup(atPos, atSize, opts, selectedIdx, onClick, isMulti, dd)
		self:HideDropdownPopup()
		self._popupGen = (self._popupGen or 0) + 1  -- bump generation so stale close handlers bail out

		local uis = game:GetService("UserInputService")
		local ts = game:GetService("TweenService")
		local w = 150
		local theme = self.Theme
		local frameAbs = self.Frame.AbsolutePosition
		local frameSiz = self.Frame.AbsoluteSize
		local px = frameSiz.X
		local py = 0
		local panelH = math.max(frameSiz.Y, 60)  -- guard against zero/invalid height while resizing
		isMulti = isMulti or false
		dd = dd or self._activeDropdown  -- fallback to _activeDropdown if not passed

		-- Create popup with 0 width → tween to slide in from right
		local popup = U.Create("Frame", {
			Name = "DropdownPopup",
			Size = UDim2.fromOffset(0, panelH),
			Position = UDim2.fromOffset(px, py),
			BackgroundColor3 = theme.Sidebar,
			BorderSizePixel = 0,
			ZIndex = 10000,
			Parent = self.Frame,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = popup })
		U.Create("UIStroke", {
			Color = theme.Border,
			Thickness = 1,
			Transparency = 0.25,
			Parent = popup,
		})
		-- Content wrapper (avoids UIListLayout affecting SideLine)
		local content = U.Create("Frame", {
			Name = "Content",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 10001,
			Parent = popup,
		})
		U.Create("UIPadding", {
			PaddingTop = UDim.new(0, 4),
			PaddingLeft = UDim.new(0, 4),
			PaddingRight = UDim.new(0, 4),
			Parent = content,
		})
		local listLayout = U.Create("UIListLayout", {
			Padding = UDim.new(0, 2),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = content,
		})

		-- Separator line on the left, full height
		U.Create("Frame", {
			Name = "SideLine",
			Size = UDim2.new(0, 1, 1, 0),
			Position = UDim2.fromOffset(0, 0),
			BackgroundColor3 = theme.Border,
			BorderSizePixel = 0,
			BackgroundTransparency = 0.3,
			ZIndex = 10001,
			Parent = popup,
		})

		-- Create option buttons with direct dropdown reference
		local options = {}
		for i, opt in ipairs(opts) do
			local sel = false
			if isMulti then
				sel = dd and dd._selected[opt] or false
			else
				sel = dd and tostring(opt) == tostring(dd.Value) or false
			end
			local btn = U.Create("TextButton", {
				Name = "Option",
				Size = UDim2.new(1, -8, 0, 32),
				Text = "",
				BackgroundColor3 = sel and theme.Accent or theme.Element,
				BackgroundTransparency = sel and 0.25 or 0.6,
				AutoButtonColor = false,
				ZIndex = 10001,
				Parent = content,
			})
			U.Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = btn })
			U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.5, Thickness = 1, Parent = btn })
			local textOffset = isMulti and 28 or 10
			U.Create("TextLabel", {
				Name = "Label",
				Size = UDim2.new(1, -(textOffset + 4), 1, 0),
				Position = UDim2.fromOffset(textOffset, 0),
				BackgroundTransparency = 1,
				Text = tostring(opt),
				Font = theme.Font,
				TextSize = theme.FontSize,
				TextColor3 = theme.SidebarTextActive,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 10002,
				Parent = btn,
			})
			btn.MouseButton1Click:Connect(function()
				if isMulti then
					if dd then
						dd:SetValue(opt)
						local isSel = dd._selected[opt]
						btn.BackgroundColor3 = isSel and theme.Accent or theme.Element
						btn.BackgroundTransparency = isSel and 0.25 or 0.6
					end
				else
					onClick(i, opt)
					self:HideDropdownPopup()
				end
			end)
			btn.MouseEnter:Connect(function()
				btn.BackgroundColor3 = theme.Accent
				btn.BackgroundTransparency = 0.55
			end)
			btn.MouseLeave:Connect(function()
				local curSel = isMulti and (dd and dd._selected[opt]) or (not isMulti and dd and tostring(opt) == tostring(dd.Value))
				if curSel then
					btn.BackgroundTransparency = 0.3  -- back to normal selected
				else
					btn.BackgroundColor3 = theme.Element
					btn.BackgroundTransparency = 0.6
				end
			end)
			options[#options + 1] = btn
		end

		-- Empty-state label when no options
		if #opts == 0 then
			U.Create("TextLabel", {
				Name = "EmptyState",
				Size = UDim2.new(1, -8, 0, 28),
				Text = "No options",
				Font = theme.Font,
				TextSize = theme.FontSize,
				TextColor3 = theme.TextMuted,
				TextTransparency = 0.4,
				BackgroundTransparency = 1,
				ZIndex = 10001,
				Parent = content,
			})
		end

		self._activePopupFrame = popup
		-- Tween: slide in from right
		local ti = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		ts:Create(popup, ti, { Size = UDim2.fromOffset(w, panelH) }):Play()

		-- Close on click outside (generation-guarded: stale invocations after a new popup are no-ops)
		local closeGen = self._popupGen
		self._popupUISCon = uis.InputBegan:Connect(function(input, gpe)
			if gpe then return end
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				task.wait()
				if closeGen ~= self._popupGen then return end  -- popup was replaced while yielding
				self:HideDropdownPopup()
			end
		end)
	end

	function Menu:HideDropdownPopup()
		if self._popupUISCon then
			self._popupUISCon:Disconnect()
			self._popupUISCon = nil
		end
		if self._activePopupFrame then
			local popup = self._activePopupFrame
			self._activePopupFrame = nil
			local ts = game:GetService("TweenService")
			local ti = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			local curSize = popup.Size
			local tw = ts:Create(popup, ti, { Size = UDim2.fromOffset(0, curSize.Y.Offset) })
			tw.Completed:Connect(function()
				pcall(function() popup:Destroy() end)
			end)
			tw:Play()
		end
		if self._activeDropdown then
			self._activeDropdown.Open = false
			if self._activeDropdown._arrow and self._activeDropdown._arrowDown then
				self._activeDropdown._arrow.Image = self._activeDropdown._arrowDown
			end
			self._activeDropdown = nil
		end
	end

	function Menu:Tab(options)
		return Tab.new(self, options)
	end

	function Menu:_trackFlagged(ctrl)
		if ctrl.Flag then
			if self._flagRegistry[ctrl.Flag] ~= nil then
				warn(("[FyyUI] Duplicate Flag '%s' — overwriting previous controller"):format(ctrl.Flag))
			end
			self._flagRegistry[ctrl.Flag] = ctrl
		end
	end

	function Menu:_registerKeybind(kb)
		table.insert(self._keybindList, kb)
	end

	function Menu:_unregisterKeybind(kb)
		for i, v in ipairs(self._keybindList) do
			if v == kb then table.remove(self._keybindList, i); break end
		end
	end

	function Menu:ExportConfig()
		local snapshot = {
			Schema = "FyyUI.Config.v1",
			Version = "0.10.5",
			Values = {},
		}
		for flag, ctrl in pairs(self._flagRegistry) do
			snapshot.Values[flag] = ctrl:GetValue()
		end
		return snapshot
	end

	function Menu:ImportConfig(snapshot, options)
		if type(snapshot) ~= "table" then
			return false, "Invalid config: expected a table"
		end
		if type(snapshot.Values) ~= "table" then
			return false, "Invalid config: missing Values table"
		end
		local noCallbacks = options and options.NoCallbacks == true
		for flag, value in pairs(snapshot.Values) do
			local ctrl = self._flagRegistry[flag]
			if ctrl then
				local ok, err = pcall(function()
					if ctrl.Multi then
						-- Multi-select dropdown: toggle via public SetValue API
						local targetSet = {}
						if type(value) == "table" then
							for _, opt in ipairs(value) do
								targetSet[opt] = true
							end
						end
						for _, opt in ipairs(ctrl.Options) do
							local isSelected = ctrl._selected[opt] == true
							local shouldSelect = targetSet[opt] == true
							if isSelected ~= shouldSelect then
								ctrl:SetValue(opt)
							end
						end
					else
						ctrl:SetValue(value, noCallbacks)
					end
				end)
			end
		end
		return true
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
			if self._destroyed or not frame.Parent then return end
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
		local uis = game:GetService("UserInputService")

		topbar.InputBegan:Connect(function(input)
			local t = input.UserInputType
			if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
				dragging = true
				ds = input.Position
				sp = frame.Position
			end
		end)
		self._dragInputCon = uis.InputChanged:Connect(function(input, gpe)
			if gpe then return end
			if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
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

	function Menu:_minimize()
		if self._destroyed then return end
		self.Minimized = true
		self._minPrevSize = self.Frame.Size
		self._minPrevPos = self.Frame.Position

		local ts = game:GetService("TweenService")
		local ti = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
		local iconPos = self._minFrame and (self._minSavedPos or self._minFrame.Position) or UDim2.new(0,12,0.5,-25)

		ts:Create(self.Frame, ti, {
			Size = UDim2.fromOffset(60, 60),
			Position = iconPos,
		}):Play()

		task.delay(0.25, function()
			if self._destroyed or not self.Minimized or not self.Visible then return end
			if self._minGui then
				self._minGui.Enabled = true
				self._minGui.Parent = game:GetService("CoreGui")
				self.Gui.Enabled = false
			elseif self._noLogoRestoreGui then
				self._noLogoRestoreGui.Enabled = true
				self._noLogoRestoreGui.Parent = game:GetService("CoreGui")
				self.Gui.Enabled = false
			end
		end)
	end

	function Menu:_restore()
		if self._destroyed then return end
		self.Minimized = false

		local ts = game:GetService("TweenService")
		local ti = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
		local iconPos = self._minFrame and (self._minSavedPos or self._minFrame.Position) or UDim2.new(0,12,0.5,-25)

		self.Frame.Size = UDim2.fromOffset(60, 60)
		self.Frame.Position = iconPos
		self.Gui.Enabled = true

		ts:Create(self.Frame, ti, {
			Size = self._minPrevSize or self._initialSize,
			Position = self._minPrevPos or self._initialPos,
		}):Play()

		if self._minGui then self._minGui.Enabled = false end
		if self._noLogoRestoreGui then self._noLogoRestoreGui.Enabled = false end
	end

	function Menu:_toggleMaximize()
		if self._destroyed or self._maximizing then return end
		self._maximizing = true
		self.Maximized = not self.Maximized
		self.Gui.Enabled = true
		if self.Minimized then
			self.Minimized = false
			if self._minGui then self._minGui.Enabled = false end
			if self._noLogoRestoreGui then self._noLogoRestoreGui.Enabled = false end
		end

		if self._maximizeTween then self._maximizeTween:Cancel() end
		local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
		local targetSize, targetPosition
		if self.Maximized then
			self._maxPrevPos = self.Frame.Position
			self._maxPrevSize = self.Frame.Size
			targetSize = UDim2.fromOffset(viewport.X - 40, viewport.Y - 40)
			targetPosition = UDim2.fromOffset(20, 20)
		else
			targetSize = self._maxPrevSize or self._initialSize
			targetPosition = self._maxPrevPos or self._initialPos
		end

		self._maximizeTween = game:GetService("TweenService"):Create(
			self.Frame,
			TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
			{ Size = targetSize, Position = targetPosition }
		)
		self._maximizeTween.Completed:Connect(function()
			if self._destroyed then return end
			self._maximizing = false
			self._maximizeTween = nil
			if self._updateShadow then self._updateShadow() end
		end)
		self._maximizeTween:Play()
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
		local uis = game:GetService("UserInputService")
		local resizing, rs, rp, rsiz

		grip.InputBegan:Connect(function(input)
			local t = input.UserInputType
			if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
				resizing = true
				rs = input.Position
				rp = frame.Position
				rsiz = frame.Size
			end
		end)
		self._resizeInputCon = uis.InputChanged:Connect(function(input, gpe)
			if gpe then return end
			local t = input.UserInputType
			if (t == Enum.UserInputType.MouseMovement or t == Enum.UserInputType.Touch) and resizing then
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
		self._resizeEndCon = uis.InputEnded:Connect(function(input, gpe)
			if gpe then return end
			local t = input.UserInputType
			if (t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch) and resizing then
				resizing = false
			end
		end)
	end

	function Menu:SetVisible(v)
		self.Visible = v
		if not self.Gui then return end
		if v then
			-- Restore visibility without accidentally unminimizing
			if self.Minimized then
				self.Gui.Enabled = false
				if self._minGui then
					self._minGui.Enabled = true
					self._minGui.Parent = game:GetService("CoreGui")
				elseif self._noLogoRestoreGui then
					self._noLogoRestoreGui.Enabled = true
					self._noLogoRestoreGui.Parent = game:GetService("CoreGui")
				end
			else
				self.Gui.Enabled = true
			end
			if self._notifGui then
				self._notifGui.Enabled = true
			end
		else
			-- Deliberately hidden: close dropdown, suppress restore/notif GUIs
			self:HideDropdownPopup()
			if self._minGui then self._minGui.Enabled = false end
			if self._noLogoRestoreGui then self._noLogoRestoreGui.Enabled = false end
			if self._notifGui then self._notifGui.Enabled = false end
			self.Gui.Enabled = false
		end
	end

	function Menu:ToggleVisibility() self:SetVisible(not self.Visible) end
	function Menu:GetVisible() return self.Visible end
	function Menu:SetTitle(t) self.Title.Text = t end

	function Menu:_confirmClose()
		if self._confirmPopup then return end
		-- Close any active dropdown first so it cannot overlay the confirmation UI
		self:HideDropdownPopup()
		local theme = self.Theme
		local ts = game:GetService("TweenService")
		local frame = self.Frame

		-- Overlay (below popup, blocks background)
		local overlay = U.Create("ImageButton", {
			Name = "ConfirmOverlay",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 10,
			AutoButtonColor = false,
			Parent = frame,
		})

		-- Shadow behind popup
		local shadow = U.Create("Frame", {
			Size = UDim2.fromOffset(268, 138),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(0,0,0),
			BackgroundTransparency = 0.65,
			BorderSizePixel = 0,
			ZIndex = 11,
			Parent = frame,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 14), Parent = shadow })

		-- Popup (always fully visible, ZIndex above everything)
		local popup = U.Create("Frame", {
			Name = "ConfirmPop",
			Size = UDim2.fromOffset(260, 130),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = theme.Sidebar,
			BackgroundTransparency = 0.1,
			BorderSizePixel = 0,
			ZIndex = 12,
			Parent = frame,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 12), Parent = popup })
		U.Create("UIStroke", { Color = Color3.fromRGB(255,255,255), Transparency = 0.88, Thickness = 1, Parent = popup })

		-- Title
		U.Create("TextLabel", {
			Size = UDim2.new(1, -20, 0, 40),
			Position = UDim2.fromOffset(10, 18),
			BackgroundTransparency = 1,
			Text = "Close Menu?",
			Font = theme.FontBold,
			TextSize = 20,
			TextColor3 = theme.TextPrimary,
			TextXAlignment = Enum.TextXAlignment.Center,
			ZIndex = 13,
			Parent = popup,
		})
		U.Create("TextLabel", {
			Size = UDim2.new(1, -20, 0, 20),
			Position = UDim2.fromOffset(10, 54),
			BackgroundTransparency = 1,
			Text = "Are you sure you want to exit?",
			Font = theme.Font,
			TextSize = 14,
			TextColor3 = theme.TextMuted,
			TextXAlignment = Enum.TextXAlignment.Center,
			ZIndex = 13,
			Parent = popup,
		})

		-- Buttons (inside popup, always clickable)
		local function makeBtn(text, xOff, defColor, hovColor, cb)
			local b = U.Create("ImageButton", {
				Size = UDim2.fromOffset(100, 30),
				Position = UDim2.fromOffset(xOff, 85),
				BackgroundColor3 = defColor,
				BackgroundTransparency = 0.25,
				AutoButtonColor = false,
				ZIndex = 14,
				Parent = popup,
			})
			U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = b })
			local bs = U.Create("UIScale", { Parent = b, Scale = 1 })
			U.Create("TextLabel", {
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Text = text,
				Font = theme.FontBold,
				TextSize = 15,
				TextColor3 = Color3.fromRGB(255,255,255),
				ZIndex = 15,
				Parent = b,
			})
			b.MouseEnter:Connect(function() ts:Create(b, TweenInfo.new(0.12), { BackgroundColor3 = hovColor, BackgroundTransparency = 0.05 }):Play() end)
			b.MouseLeave:Connect(function() ts:Create(b, TweenInfo.new(0.12), { BackgroundColor3 = defColor, BackgroundTransparency = 0.25 }):Play() end)
			b.MouseButton1Down:Connect(function() ts:Create(bs, TweenInfo.new(0.05), { Scale = 0.95 }):Play() end)
			b.MouseButton1Up:Connect(function() ts:Create(bs, TweenInfo.new(0.08), { Scale = 1 }):Play() end)
			b.MouseButton1Click:Connect(cb)
			return b
		end

		self._confirmPopup = { popup = popup, overlay = overlay, shadow = shadow }

		-- Fade IN: only overlay dims (popup already fully visible & clickable)
		ts:Create(overlay, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 0.5 }):Play()

		-- Close
		local closing = false
		local function closePopup(cb)
			if closing then return end
			closing = true
			ts:Create(overlay, TweenInfo.new(0.2), { BackgroundTransparency = 1 }):Play()
			task.delay(0.25, function()
				if self._destroyed then return end
				if overlay then overlay:Destroy() end
				if popup then popup:Destroy() end
				if shadow then shadow:Destroy() end
				self._confirmPopup = nil
				if cb then cb() end
			end)
		end

		makeBtn("No", 20, Color3.fromRGB(55, 55, 68), Color3.fromRGB(75, 75, 90), function() closePopup(nil) end)
		makeBtn("Yes", 140, Color3.fromRGB(170, 45, 45), Color3.fromRGB(210, 60, 60), function() closePopup(function() self:SetVisible(false) end) end)
	end

	function Menu:Destroy()
		if self._destroyed then return end
		self._destroyed = true
		self:CloseCommandPalette()

		-- Disconnect all service-level connections
		if self._heartbeatCon then self._heartbeatCon:Disconnect(); self._heartbeatCon = nil end
		if self._popupUISCon then self._popupUISCon:Disconnect(); self._popupUISCon = nil end
		if self._dragInputCon then self._dragInputCon:Disconnect(); self._dragInputCon = nil end
		if self._minDragInputCon then self._minDragInputCon:Disconnect(); self._minDragInputCon = nil end
		if self._resizeInputCon then self._resizeInputCon:Disconnect(); self._resizeInputCon = nil end
		if self._resizeEndCon then self._resizeEndCon:Disconnect(); self._resizeEndCon = nil end
		if self._keybindInputCon then self._keybindInputCon:Disconnect(); self._keybindInputCon = nil end
		if self._keybindEndCon then self._keybindEndCon:Disconnect(); self._keybindEndCon = nil end
		if self._scaleTween then self._scaleTween:Cancel(); self._scaleTween = nil end

		-- Destroy external ScreenGuis owned by this menu
		if self._notifGui then self._notifGui:Destroy(); self._notifGui = nil end
		if self._minGui then self._minGui:Destroy(); self._minGui = nil end
		if self._noLogoRestoreGui then self._noLogoRestoreGui:Destroy(); self._noLogoRestoreGui = nil end

		-- Destroy any active confirm-close popup
		if self._confirmPopup then
			if self._confirmPopup.overlay then self._confirmPopup.overlay:Destroy() end
			if self._confirmPopup.popup then self._confirmPopup.popup:Destroy() end
			if self._confirmPopup.shadow then self._confirmPopup.shadow:Destroy() end
			self._confirmPopup = nil
		end

		-- Close any active dropdown popup
		if self._activePopupFrame then
			self._activePopupFrame:Destroy()
			self._activePopupFrame = nil
		end
		if self._activeDropdown then self._activeDropdown = nil end

		-- Tooltip cleanup
		self._tooltipPending = false
		self._tooltipTarget = nil
		self._tooltipActive = false
		if self._tooltipTween then self._tooltipTween:Cancel(); self._tooltipTween = nil end
		if self._mouseCon then self._mouseCon:Disconnect(); self._mouseCon = nil end
		for _, data in pairs(self._tooltips) do
			if data.unbind then data.unbind() end
		end
		self._tooltips = {}
		if self._tooltipLabel then self._tooltipLabel:Destroy(); self._tooltipLabel = nil end

		-- Destroy tabs
		for _, tab in ipairs(self.Tabs) do
			tab:Destroy()
		end
		self.Tabs = {}

		-- Destroy main GUI last
		if self.Gui then self.Gui:Destroy(); self.Gui = nil end
	end

	function Menu:_ApplyTheme(theme)
		if not self.Frame then return end

		-- Main frame
		self.Frame.BackgroundColor3 = theme.Background
		local corner = self.Frame:FindFirstChildOfClass("UICorner")
		if corner then corner.CornerRadius = UDim.new(0, theme.CornerRadius) end
		local frameStroke = self.Frame:FindFirstChildOfClass("UIStroke")
		if frameStroke then frameStroke.Color = theme.Outline end

		-- Shadow
		if self._shadow then
			self._shadow.BackgroundColor3 = theme.Shadow
			local shadowCorner = self._shadow:FindFirstChildOfClass("UICorner")
			if shadowCorner then shadowCorner.CornerRadius = UDim.new(0, theme.CornerRadius + 2) end
		end

		-- Topbar
		self.Topbar.BackgroundColor3 = theme.Topbar
		local topCorner = self.Topbar:FindFirstChildOfClass("UICorner")
		if topCorner then topCorner.CornerRadius = UDim.new(0, theme.CornerRadius) end
		local topFill = self.Topbar:FindFirstChild("Fill")
		if topFill then topFill.BackgroundColor3 = theme.Topbar end

		-- Title
		self.Title.TextColor3 = theme.TextPrimary
		self.Title.Font = theme.FontBold
		self.Title.TextSize = theme.FontSizeTitle

		-- Status label (Stats)
		if self.StatusLabel then
			self.StatusLabel.TextColor3 = theme.TextPrimary
			self.StatusLabel.Font = theme.FontBold
			self.StatusLabel.TextSize = theme.FontSizeSmall
		end

		-- Accent line under topbar
		if self.AccentLine then
			self.AccentLine.BackgroundColor3 = theme.AccentLine
		end

		-- Sidebar
		self.Sidebar.BackgroundColor3 = theme.Sidebar

		-- ActiveBar
		if self.ActiveBar then
			self.ActiveBar.BackgroundColor3 = theme.Accent
		end

		-- Resize grip
		local grip = self.Frame:FindFirstChild("ResizeGrip")
		if grip then grip.BackgroundColor3 = theme.TextMuted end

		-- No-logo restore button (minimize affordance)
		if self._noLogoRestoreBtn then
			self._noLogoRestoreBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- keep dark
		end

		-- Confirm-close popup (if open)
		if self._confirmPopup then
			local pop = self._confirmPopup.popup
			if pop then
				pop.BackgroundColor3 = theme.Sidebar
				local labels = pop:FindFirstChildOfClass("TextLabel")
				-- iterate all text labels
				for _, lbl in ipairs(pop:GetChildren()) do
					if lbl:IsA("TextLabel") then
						lbl.Font = theme.Font
					end
				end
			end
		end

		-- Active notification styling
		if self.NotifBox then
			for _, notif in ipairs(self.NotifBox:GetChildren()) do
				if notif:IsA("Frame") then
					notif.BackgroundColor3 = theme.Element
					local txt = notif:FindFirstChild("Text")
					if txt and txt:IsA("TextLabel") then
						txt.Font = theme.Font
						txt.TextSize = theme.FontSize
						txt.TextColor3 = theme.TextPrimary
					end
				end
			end
		end

		-- Apply theme to all tabs (which cascade to their components)
		for _, tab in ipairs(self.Tabs) do
			tab:ApplyTheme(theme)
		end

		-- Tooltip
		if self._tooltipLabel then
			self._tooltipLabel.BackgroundColor3 = theme.Element
			self._tooltipLabel.Font = theme.Font
			self._tooltipLabel.TextSize = theme.FontSize
			self._tooltipLabel.TextColor3 = theme.TextPrimary
			local stroke = self._tooltipLabel:FindFirstChildOfClass("UIStroke")
			if stroke then stroke.Color = theme.Outline end
		end

		-- Command Palette (if currently open)
		if self._paletteFrame then
			self._paletteFrame.BackgroundColor3 = theme.Background
			local stroke = self._paletteFrame:FindFirstChildOfClass("UIStroke")
			if stroke then stroke.Color = theme.Outline end
			if self._paletteSearchBox then
				self._paletteSearchBox.BackgroundColor3 = theme.Element
				self._paletteSearchBox.Font = theme.Font
				self._paletteSearchBox.TextSize = theme.FontSize
				self._paletteSearchBox.TextColor3 = theme.TextPrimary
				self._paletteSearchBox.PlaceholderColor3 = theme.TextMuted
			end
			if self._paletteResults then
				self._paletteResults.ScrollBarImageColor3 = theme.ScrollBar
			end
			if self._paletteEmpty then
				self._paletteEmpty.Font = theme.Font
				self._paletteEmpty.TextSize = theme.FontSizeSmall
				self._paletteEmpty.TextColor3 = theme.TextMuted
			end
			if self._paletteSearchBox then
				self:_filterPaletteResults(self._paletteSearchBox.Text)
			end
		end
	end

	function Menu:SetTheme(themeOrName)
		if type(themeOrName) == "string" then
			local builtin = Theme[themeOrName]
			if not builtin then
				return false, "Unknown built-in theme: " .. tostring(themeOrName)
			end
			self.Theme = builtin
		elseif type(themeOrName) == "table" then
			if not themeOrName.Background or not themeOrName.TextPrimary then
				return false, "Theme table must have at least Background and TextPrimary colors"
			end
			self.Theme = themeOrName
		else
			return false, "Expected a theme name (string) or theme table"
		end
		self:_ApplyTheme(self.Theme)
		return true
	end

	function Menu:SetScale(value)
		value = math.clamp(value, 0.75, 1.35)
		self.Scale = value
		if not self._uiScale then return end
		if self._reducedMotion then
			self._uiScale.Scale = value
		else
			if self._scaleTween then self._scaleTween:Cancel() end
			self._scaleTween = game:GetService("TweenService"):Create(
				self._uiScale,
				TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ Scale = value }
			)
			self._scaleTween:Play()
		end
	end

	function Menu:GetScale()
		return self.Scale
	end

	--[[ Tooltip System ]]

	--- Bind a tooltip to any Instance.
	--- @param instance Instance — the GUI element that triggers the tooltip
	--- @param text string — tooltip text (supports RichText)
	--- @return function unbind — call to remove this tooltip binding
	function Menu:BindTooltip(instance, text)
		if self._destroyed or not instance then return function() end end

		-- If already bound to this instance, unbind first
		if self._tooltips[instance] then
			self._tooltips[instance].unbind()
		end

		local conns = {}
		local boundInstance = instance

		local function disconnectAll()
			for _, c in ipairs(conns) do
				c:Disconnect()
			end
			conns = {}
			if self._tooltips then self._tooltips[boundInstance] = nil end
			if self._tooltipTarget == boundInstance then
				self._tooltipPending = false
				self._tooltipTarget = nil
				self:_hideTooltip()
			end
		end

		-- MouseEnter: start delay timer
		table.insert(conns, instance.MouseEnter:Connect(function()
			if self._destroyed then return end
			self._tooltipPending = true
			self._tooltipTarget = instance
			task.delay(0.4, function()
				if not self._tooltipPending or self._tooltipTarget ~= instance or self._destroyed then return end
				if not instance or not instance.Parent then
					self._tooltipPending = false
					self._tooltipTarget = nil
					return
				end
				self:_showTooltip(text)
			end)
		end))

		-- MouseLeave: hide immediately
		table.insert(conns, instance.MouseLeave:Connect(function()
			self._tooltipPending = false
			self._tooltipTarget = nil
			self:_hideTooltip()
		end))

		-- Click (any mouse button on the instance): hide
		table.insert(conns, instance.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.MouseButton2
				or input.UserInputType == Enum.UserInputType.MouseButton3 then
				self._tooltipPending = false
				self._tooltipTarget = nil
				self:_hideTooltip()
			end
		end))

		self._tooltips[instance] = { unbind = disconnectAll, text = text }
		return disconnectAll
	end

	function Menu:_showTooltip(text)
		if self._destroyed or not self._tooltipLabel then return end
		local label = self._tooltipLabel

		-- Set text and compute size
		label.Text = text
		label.Size = UDim2.fromOffset(2000, 26)
		local tb = label.TextBounds
		local tw = math.min(math.max(tb.X + 16, 24), 300)
		local th = math.max(tb.Y + 8, 26)
		label.Size = UDim2.fromOffset(tw, th)

		-- Position near cursor, clamped to frame
		local frameAbsPos = self.Frame.AbsolutePosition
		local frameSize = self.Frame.AbsoluteSize
		local relX = math.clamp(self._mousePos.X - frameAbsPos.X + 12, 0, math.max(0, frameSize.X - tw))
		local relY = math.clamp(self._mousePos.Y - frameAbsPos.Y + 20, 0, math.max(0, frameSize.Y - th))
		label.Position = UDim2.fromOffset(relX, relY)

		-- Fade in
		label.Visible = true
		label.BackgroundTransparency = 1
		label.TextTransparency = 1
		local ts = game:GetService("TweenService")
		if self._tooltipTween then self._tooltipTween:Cancel() end
		self._tooltipTween = ts:Create(label, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			BackgroundTransparency = 0.08,
			TextTransparency = 0,
		})
		self._tooltipTween:Play()
		self._tooltipActive = true
	end

	function Menu:_hideTooltip()
		if not self._tooltipLabel or not self._tooltipActive then return end
		self._tooltipActive = false
		if self._tooltipTween then self._tooltipTween:Cancel(); self._tooltipTween = nil end

		local label = self._tooltipLabel
		local ts = game:GetService("TweenService")
		local tw = ts:Create(label, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			BackgroundTransparency = 1,
			TextTransparency = 1,
		})
		tw.Completed:Connect(function()
			label.Visible = false
		end)
		tw:Play()
	end

	function Menu:_updateTooltipPosition()
		if not self._tooltipLabel or not self._tooltipLabel.Visible then return end
		local label = self._tooltipLabel
		local size = label.Size
		local tw = size.X.Offset
		local th = size.Y.Offset
		local frameAbsPos = self.Frame.AbsolutePosition
		local frameSize = self.Frame.AbsoluteSize
		local relX = math.clamp(self._mousePos.X - frameAbsPos.X + 12, 0, math.max(0, frameSize.X - tw))
		local relY = math.clamp(self._mousePos.Y - frameAbsPos.Y + 20, 0, math.max(0, frameSize.Y - th))
		label.Position = UDim2.fromOffset(relX, relY)
	end

	--[[ Command Palette ]]

	-- Build a flat search index from all tabs and their components (including collapsible children)
	function Menu:_buildPaletteIndex()
		self._paletteIndex = {}
		for _, tab in ipairs(self.Tabs) do
			table.insert(self._paletteIndex, {
				type = "tab",
				text = tab.Text,
				tab = tab,
				collapsible = nil,
				ref = nil,
			})
			self:_indexTabComponents(tab.Components, tab, nil)
		end
	end

	function Menu:_indexTabComponents(components, tab, collapsible)
		for _, comp in ipairs(components) do
			-- Collapsible detection (has _closed field)
			if type(comp) == "table" and comp._closed ~= nil then
				if comp.Title then
					table.insert(self._paletteIndex, {
						type = "section",
						text = comp.Title.Text,
						tab = tab,
						collapsible = comp,
						ref = comp,
					})
				end
				if comp.Components then
					self:_indexTabComponents(comp.Components, tab, comp)
				end
			else
				local text = nil
				if type(comp) == "table" then
					if comp.Text then
						text = tostring(comp.Text)
					end
					if not text and comp.Container and not comp.Container:IsA("ScrollingFrame") then
						local txtChild = comp.Container:FindFirstChild("Text")
						if txtChild and txtChild:IsA("TextLabel") then
							text = txtChild.Text
						end
					end
				end
				if text and text ~= "" then
					table.insert(self._paletteIndex, {
						type = "component",
						text = text,
						tab = tab,
						collapsible = collapsible,
						ref = comp,
					})
				end
			end
		end
	end

	-- Filter search index against query and rebuild result buttons
	function Menu:_filterPaletteResults(query)
		for _, btn in ipairs(self._paletteResultButtons) do
			pcall(function() btn:Destroy() end)
		end
		self._paletteResultButtons = {}

		local q = query:lower()
		local filtered = {}
		for _, item in ipairs(self._paletteIndex) do
			if #q == 0 or item.text:lower():find(q, 1, true) then
				table.insert(filtered, item)
			end
		end
		self._paletteFilteredResults = filtered

		if self._paletteEmpty then
			self._paletteEmpty.Visible = #filtered == 0
		end
		if not self._paletteFrame then return end
		local theme = self.Theme

		for i, result in ipairs(filtered) do
			local btn = U.Create("TextButton", {
				Name = "Result",
				Size = UDim2.new(1, 0, 0, 30),
				BackgroundTransparency = 0.6,
				AutoButtonColor = false,
				Text = "",
				ZIndex = 100002,
				Parent = self._paletteResults,
			})
			-- Row highlight
			local selection = U.Create("Frame", {
				Name = "Selection",
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ZIndex = 100002,
				Parent = btn,
			})
			U.Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = selection })
			-- Label
			U.Create("TextLabel", {
				Name = "Label",
				Size = UDim2.new(1, -70, 1, 0),
				Position = UDim2.fromOffset(10, 0),
				BackgroundTransparency = 1,
				Text = result.text,
				Font = theme.Font,
				TextSize = theme.FontSize,
				TextColor3 = theme.TextPrimary,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 100003,
				Parent = btn,
			})
			-- Source tag
			local src = result.type == "tab" and "Tab"
				or (result.type == "section" and "Section")
				or (result.collapsible and result.collapsible.Title.Text or result.tab.Text)
			U.Create("TextLabel", {
				Name = "Source",
				Size = UDim2.new(0, 60, 1, 0),
				Position = UDim2.new(1, -64, 0, 0),
				BackgroundTransparency = 1,
				Text = src,
				Font = theme.Font,
				TextSize = theme.FontSizeSmall,
				TextColor3 = theme.TextMuted,
				TextXAlignment = Enum.TextXAlignment.Right,
				TextTruncate = Enum.TextTruncate.AtEnd,
				ZIndex = 100003,
				Parent = btn,
			})
			-- Click
			btn.MouseButton1Click:Connect(function()
				self:_paletteActivateResult(result)
			end)
			table.insert(self._paletteResultButtons, btn)
		end

		if #filtered == 0 then
			self._paletteSelectedIndex = 0
		else
			self._paletteSelectedIndex = math.clamp(self._paletteSelectedIndex, 1, #filtered)
		end
		self:_updatePaletteSelection()
	end

	function Menu:_updatePaletteSelection()
		for i, btn in ipairs(self._paletteResultButtons) do
			local sel = btn:FindFirstChild("Selection")
			if sel then
				if i == self._paletteSelectedIndex then
					sel.BackgroundColor3 = self.Theme.Accent
					sel.BackgroundTransparency = 0.55
				else
					sel.BackgroundTransparency = 1
				end
			end
		end
	end

	function Menu:_paletteSelectNext()
		local n = #self._paletteFilteredResults
		if n == 0 then return end
		self._paletteSelectedIndex = self._paletteSelectedIndex + 1
		if self._paletteSelectedIndex > n then self._paletteSelectedIndex = 1 end
		self:_updatePaletteSelection()
	end

	function Menu:_paletteSelectPrev()
		local n = #self._paletteFilteredResults
		if n == 0 then return end
		self._paletteSelectedIndex = self._paletteSelectedIndex - 1
		if self._paletteSelectedIndex < 1 then self._paletteSelectedIndex = n end
		self:_updatePaletteSelection()
	end

	function Menu:_paletteActivateSelected()
		local results = self._paletteFilteredResults or {}
		local idx = self._paletteSelectedIndex
		if idx > 0 and idx <= #results then
			self:_paletteActivateResult(results[idx])
		end
	end

	function Menu:_paletteActivateResult(result)
		if not result then return end
		if result.type == "tab" then
			self:SelectTab(result.tab)
			self:CloseCommandPalette()
			return
		end
		-- Component / section
		self:SelectTab(result.tab)
		local needsOpen = result.collapsible and not result.collapsible._isOpen
		if needsOpen then
			result.collapsible:Open()
		end
		self:CloseCommandPalette()
		local target = result.ref
		local container = target and (target.Container or (target.Title and target.Container))
		if container then
			if needsOpen then
				task.wait(0.26)
			end
			self:_emphasizeComponent(result.tab, container)
		end
	end

	function Menu:_emphasizeComponent(tab, container)
		if not tab.Container or not container or not container:IsDescendantOf(tab.Container) then return end
		local scroll = tab.Container
		-- Scroll the container into view
		task.spawn(function()
			task.wait(0.05)
			if not scroll or not container or not container:IsDescendantOf(scroll) then return end
			local absC = container.AbsolutePosition
			local absS = scroll.AbsolutePosition
			local relY = absC.Y - absS.Y + scroll.CanvasPosition.Y - 16
			local ts = game:GetService("TweenService")
			ts:Create(scroll, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				CanvasPosition = Vector2.new(0, math.max(0, relY)),
			}):Play()
		end)
		-- Brief emphasize flash
		local origColor = container.BackgroundColor3
		local origTrans = container.BackgroundTransparency
		container.BackgroundColor3 = self.Theme.Accent
		container.BackgroundTransparency = 0.65
		task.delay(0.5, function()
			if not container or container.Parent == nil then return end
			local ts = game:GetService("TweenService")
			ts:Create(container, TweenInfo.new(0.4), { BackgroundTransparency = origTrans }):Play()
			task.delay(0.1, function()
				if container then container.BackgroundColor3 = origColor end
			end)
		end)
	end

	function Menu:OpenCommandPalette()
		if self._paletteOpen then self:CloseCommandPalette() end
		if self._destroyed then return end
		self:HideDropdownPopup()
		self:_buildPaletteIndex()
		self._paletteOpen = true
		self._paletteSelectedIndex = 0

		local gui = self.Gui
		local theme = self.Theme
		local ts = game:GetService("TweenService")
		local uis = game:GetService("UserInputService")

		-- Full-frame dim overlay (ImageButton to catch clicks, parented to Gui for max layering)
		self._paletteOverlay = U.Create("ImageButton", {
			Name = "PaletteOverlay",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 100000,
			AutoButtonColor = false,
			Parent = gui,
			Visible = false,
		})
		self._paletteOverlay.MouseButton1Click:Connect(function()
			self:CloseCommandPalette()
		end)

		-- Palette frame (centered on screen relative to gui)
		local palW, palH = 380, 310
		self._paletteFrame = U.Create("Frame", {
			Name = "CommandPalette",
			Size = UDim2.fromOffset(palW, palH),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = theme.Background,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			ZIndex = 100001,
			Parent = gui,
			Visible = false,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = self._paletteFrame })
		U.Create("UIStroke", { Color = theme.Outline, Thickness = 1, Transparency = 0.15, Parent = self._paletteFrame })

		-- Search box
		self._paletteSearchBox = U.Create("TextBox", {
			Name = "SearchBox",
			Size = UDim2.new(1, -16, 0, 34),
			Position = UDim2.fromOffset(8, 8),
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0,
			Text = "",
			PlaceholderText = "Search tabs and components...",
			Font = theme.Font,
			TextSize = theme.FontSize,
			TextColor3 = theme.TextPrimary,
			PlaceholderColor3 = theme.TextMuted,
			ClearTextOnFocus = false,
			ZIndex = 100002,
			Parent = self._paletteFrame,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = self._paletteSearchBox })

		-- Results list
		self._paletteResults = U.Create("ScrollingFrame", {
			Name = "Results",
			Size = UDim2.new(1, -16, 1, -(34 + 12)),
			Position = UDim2.fromOffset(8, 34 + 8 + 4),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 3,
			ScrollBarImageColor3 = theme.ScrollBar,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			ZIndex = 100002,
			Parent = self._paletteFrame,
		})
		local resLayout = U.Create("UIListLayout", {
			Padding = UDim.new(0, 2),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = self._paletteResults,
		})
		resLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			if self._paletteResults then
				self._paletteResults.CanvasSize = UDim2.new(0, 0, 0, resLayout.AbsoluteContentSize.Y)
			end
		end)

		-- Empty state
		self._paletteEmpty = U.Create("TextLabel", {
			Name = "EmptyState",
			Size = UDim2.new(1, -16, 0, 60),
			Position = UDim2.fromOffset(8, 34 + 8 + 4),
			BackgroundTransparency = 1,
			Text = "No results found",
			Font = theme.Font,
			TextSize = theme.FontSizeSmall,
			TextColor3 = theme.TextMuted,
			TextXAlignment = Enum.TextXAlignment.Center,
			ZIndex = 100002,
			Visible = false,
			Parent = self._paletteFrame,
		})

		-- Show all results initially
		self:_filterPaletteResults("")

		-- Connections
		local conns = {}
		table.insert(conns, self._paletteSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
			self:_filterPaletteResults(self._paletteSearchBox.Text)
		end))
		table.insert(conns, uis.InputBegan:Connect(function(pi, pgpe)
			if not self._paletteOpen then return end
			if pi.UserInputType ~= Enum.UserInputType.Keyboard then return end
			local pk = pi.KeyCode
			if pk == Enum.KeyCode.Escape then
				self:CloseCommandPalette()
			elseif pk == Enum.KeyCode.Up then
				self:_paletteSelectPrev()
			elseif pk == Enum.KeyCode.Down then
				self:_paletteSelectNext()
			elseif pk == Enum.KeyCode.Return then
				self:_paletteActivateSelected()
			end
		end))
		self._paletteConns = conns

		-- Show frames
		self._paletteOverlay.Visible = true
		self._paletteFrame.Visible = true

		-- Animate in
		ts:Create(self._paletteOverlay, TweenInfo.new(0.15), { BackgroundTransparency = 0.45 }):Play()
		self._paletteFrame.Size = UDim2.fromOffset(0, 0)
		ts:Create(self._paletteFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.fromOffset(palW, palH),
		}):Play()

		-- Focus search box after a tick
		task.spawn(function()
			task.wait(0.1)
			if self._paletteSearchBox then
				self._paletteSearchBox:CaptureFocus()
			end
		end)
	end

	function Menu:CloseCommandPalette()
		if not self._paletteOpen then return end
		self._paletteOpen = false

		if self._paletteConns then
			for _, c in ipairs(self._paletteConns) do
				pcall(function() c:Disconnect() end)
			end
			self._paletteConns = {}
		end
		self._paletteResultButtons = {}
		self._paletteFilteredResults = {}
		self._paletteSelectedIndex = 0

		if self._paletteOverlay then
			self._paletteOverlay:Destroy()
			self._paletteOverlay = nil
		end
		if self._paletteFrame then
			self._paletteFrame:Destroy()
			self._paletteFrame = nil
		end
		self._paletteSearchBox = nil
		self._paletteResults = nil
		self._paletteEmpty = nil
	end

	function Menu:ToggleCommandPalette()
		if self._paletteOpen then
			self:CloseCommandPalette()
		else
			self:OpenCommandPalette()
		end
	end

	--[[ Export ]]
	local FyyUI = { Version = "0.10.5", Theme = Theme }

	function FyyUI.SetIconModule(mod)
		IconModule = mod
	end
	function FyyUI.GetIconModule()
		return IconModule
	end

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
