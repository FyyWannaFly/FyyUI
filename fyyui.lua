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
		self.Value = ""  -- start empty; use Default to pre-select
		if options.Default ~= nil then
			self.Value = options.Default
		elseif self.Options[1] and not options.Placeholder then
			self.Value = self.Options[1]  -- backward compat: auto-select first
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
		self.Theme = theme
		self.Open = false
		self.HasDesc = self.Description ~= nil and self.Description ~= ""
		local h = self.HasDesc and theme.DescHeight or theme.ElementHeight
		local selectY = self.HasDesc and 32 or 28

		self.Container = U.Create("Frame", {
			Name = "Dropdown",
			Size = UDim2.new(1, -12, 0, h + 8),
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

		return self
	end

	function Dropdown:SetValue(v)
		if self.Multi then
			-- Multi-select: toggle the value
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
			if self._menu._activeDropdown == self then
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
		if self._menu._activeDropdown == self then
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

	function Tab:BoldLabel(options)
		options = options or {}
		local hasDesc = options.Description ~= nil and options.Description ~= ""
		local h = hasDesc and self.Theme.DescHeight or self.Theme.ElementHeight
		local lbl = {}

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
			TextSize = options.TextSize or self.Theme.FontSizeTitle,
			TextColor3 = options.Color or self.Theme.TextPrimary,
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

			macBtn("Close", btnColors.Close, function() self:SetVisible(false) end)
			macBtn("Minimize", btnColors.Minimize, function()
				self.Minimized = not self.Minimized
				local ts = game:GetService("TweenService")
				local ti = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
				if self.Minimized then
					self._minPrevSize = self.Frame.Size
					self._minPrevPos = self.Frame.Position
					local iconPos = self._minFrame and (self._minSavedPos or self._minFrame.Position) or UDim2.new(0,12,0.5,-25)
					ts:Create(self.Frame, ti, {
						Size = UDim2.fromOffset(60, 60),
						Position = iconPos,
					}):Play()
					task.delay(0.2, function()
						if not self.Minimized then return end
						if self._minGui then
							self._minGui.Enabled = true
							self._minGui.Parent = game:GetService("CoreGui")
						end
						self.Gui.Enabled = false
					end)
				else
					local iconPos = self._minFrame and (self._minSavedPos or self._minFrame.Position) or UDim2.new(0,12,0.5,-25)
					self.Frame.Size = UDim2.fromOffset(60, 60)
					self.Frame.Position = iconPos
					self.Gui.Enabled = true
					ts:Create(self.Frame, ti, {
						Size = self._minPrevSize or UDim2.fromOffset(size.X, size.Y),
						Position = self._minPrevPos or pos,
					}):Play()
					if self._minGui then self._minGui.Enabled = false end
				end
			end)
			macBtn("Maximize", btnColors.Maximize, function()
				self.Maximized = not self.Maximized
				self.Gui.Enabled = true
				if self.Minimized then
					self.Minimized = false
					if self._minGui then self._minGui.Enabled = false end
				end
				local ts = game:GetService("TweenService")
				local ti = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
				if self.Maximized then
					self._maxPrevPos = self.Frame.Position
					self._maxPrevSize = self.Frame.Size
		local vs = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
					ts:Create(self.Frame, ti, {
						Size = UDim2.fromOffset(vs.X - 40, vs.Y - 40),
						Position = UDim2.fromOffset(20, 20),
					}):Play()
				else
					ts:Create(self.Frame, ti, {
						Size = self._maxPrevSize or UDim2.fromOffset(size.X, size.Y),
						Position = self._maxPrevPos or pos,
					}):Play()
				end
				if self._updateShadow then self._updateShadow() end
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
			winBtn("Close", function() self:SetVisible(false) end, -36, Color3.fromRGB(200, 60, 60))
			winBtn("Maximize", function()
				self.Maximized = not self.Maximized
				self.Gui.Enabled = true
				resetWinHover()
				if self.Minimized then
					self.Minimized = false
					if self._minGui then self._minGui.Enabled = false end
				end
				local ts = game:GetService("TweenService")
				local ti = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
				if self.Maximized then
					self._maxPrevPos = self.Frame.Position
					self._maxPrevSize = self.Frame.Size
					local vs = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
					ts:Create(self.Frame, ti, {
						Size = UDim2.fromOffset(vs.X - 40, vs.Y - 40),
						Position = UDim2.fromOffset(20, 20),
					}):Play()
				else
					ts:Create(self.Frame, ti, {
						Size = self._maxPrevSize or UDim2.fromOffset(size.X, size.Y),
						Position = self._maxPrevPos or pos,
					}):Play()
				end
				if self._updateShadow then self._updateShadow() end
			end, -66, Color3.fromRGB(45, 45, 55))
			winBtn("Minimize", function()
				self.Minimized = not self.Minimized
				local ts = game:GetService("TweenService")
				local ti = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
				if self.Minimized then
					self._minPrevSize = self.Frame.Size
					self._minPrevPos = self.Frame.Position
					local iconPos = self._minFrame and (self._minSavedPos or self._minFrame.Position) or UDim2.new(0,12,0.5,-25)
					ts:Create(self.Frame, ti, {
						Size = UDim2.fromOffset(60, 60),
						Position = iconPos,
					}):Play()
					task.delay(0.2, function()
						if not self.Minimized then return end
						if self._minGui then
							self._minGui.Enabled = true
							self._minGui.Parent = game:GetService("CoreGui")
						end
						self.Gui.Enabled = false
					end)
				else
					resetWinHover()
					local iconPos = self._minFrame and (self._minSavedPos or self._minFrame.Position) or UDim2.new(0,12,0.5,-25)
					self.Frame.Size = UDim2.fromOffset(60, 60)
					self.Frame.Position = iconPos
					self.Gui.Enabled = true
					ts:Create(self.Frame, ti, {
						Size = self._minPrevSize or UDim2.fromOffset(size.X, size.Y),
						Position = self._minPrevPos or pos,
					}):Play()
					if self._minGui then self._minGui.Enabled = false end
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
			local dragging, dragStart, startPos, didDrag, _inputChangedCon
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
					-- If didn't drag (click), restore menu
					if not didDrag then
						self.Minimized = false
						local ts = game:GetService("TweenService")
						local ti = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
						local iconPos = self._minFrame and (self._minSavedPos or self._minFrame.Position) or UDim2.new(0,12,0.5,-25)
						self.Frame.Size = UDim2.fromOffset(60, 60)
						self.Frame.Position = iconPos
						self.Gui.Enabled = true
						ts:Create(self.Frame, ti, {
							Size = self._minPrevSize or UDim2.fromOffset(size.X, size.Y),
							Position = self._minPrevPos or pos,
						}):Play()
						if self._minGui then self._minGui.Enabled = false end
					end
				end
			end)
			_inputChangedCon = game:GetService("UserInputService").InputChanged:Connect(function(i)
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
		end

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

		local uis = game:GetService("UserInputService")
		local ts = game:GetService("TweenService")
		local w = 150
		local theme = self.Theme
		local frameAbs = self.Frame.AbsolutePosition
		local frameSiz = self.Frame.AbsoluteSize
		local px = frameSiz.X
		local py = 0
		local panelH = frameSiz.Y
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
				BackgroundTransparency = sel and 0.15 or 0.8,
				AutoButtonColor = false,
				ZIndex = 10001,
				Parent = content,
			})
			U.Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = btn })
			U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.7, Thickness = 1, Parent = btn })
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
						btn.BackgroundColor3 = isSel and theme.Accent or Color3.new(0,0,0)
						btn.BackgroundTransparency = isSel and 0.15 or 1
					end
				else
					onClick(i, opt)
					self:HideDropdownPopup()
				end
			end)
			btn.MouseEnter:Connect(function()
				local curSel = isMulti and (dd and dd._selected[opt]) or (dd and tostring(opt) == tostring(dd.Value))
				if curSel then
					btn.BackgroundTransparency = 0.05  -- brighter when hovered over selected
				else
					btn.BackgroundColor3 = theme.Accent
					btn.BackgroundTransparency = 0.45
				end
			end)
			btn.MouseLeave:Connect(function()
				local curSel = isMulti and (dd and dd._selected[opt]) or (dd and tostring(opt) == tostring(dd.Value))
				if curSel then
					btn.BackgroundTransparency = 0.15  -- back to normal selected
				else
					btn.BackgroundColor3 = theme.Element
					btn.BackgroundTransparency = 0.8
				end
			end)
			options[#options + 1] = btn
		end

		self._activePopupFrame = popup
		-- Tween: slide in from right
		local ti = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		ts:Create(popup, ti, { Size = UDim2.fromOffset(w, panelH) }):Play()

		-- Close on click outside
		self._popupUISCon = uis.InputBegan:Connect(function(input, gpe)
			if gpe then return end
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				task.wait()
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
		local uis = game:GetService("UserInputService")

		topbar.InputBegan:Connect(function(input)
			local t = input.UserInputType
			if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
				dragging = true
				ds = input.Position
				sp = frame.Position
			end
		end)
		uis.InputChanged:Connect(function(input, gpe)
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
		if self._heartbeatCon then self._heartbeatCon:Disconnect() end
		for _, tab in ipairs(self.Tabs) do
			tab:Destroy()
		end
		self.Tabs = {}
		if self.Gui then self.Gui:Destroy() end
	end

	--[[ Export ]]
	local FyyUI = { Version = "0.9.33", Theme = Theme }

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
