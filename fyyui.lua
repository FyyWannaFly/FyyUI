--[[
FyyUI v0.17.0
	Roblox UI Library
	@github FyyWannaFly/FyyUI

	GENERATED FILE — DO NOT EDIT DIRECTLY.
	Edit src/ and run: node scripts/build.js

	-- Load this trusted local copy using your project's normal module loader.
	local FyyUI = require(script.Parent.FyyUI)
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
			TextMuted = Color3.fromRGB(140, 140, 155),
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
			SidebarText = Color3.fromRGB(135, 135, 150),
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
			-- Card layout formula (unified across all controls):
			--   No description: height = ElementHeight + 6 = 42px
			--   With description: height = DescHeight + 6 = 58px
			--   Outer inset: 6px left/right (children use width 1,-12 + position 6)
			--   Inner text padding (left): 10px
			--   Corner radius: 8px, Stroke: 1px, Inter-child spacing: 6px
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
			TextMuted = Color3.fromRGB(85, 85, 98),
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
			SidebarText = Color3.fromRGB(105, 105, 120),
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
			TextMuted = Color3.fromRGB(125, 125, 142),
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
			SidebarText = Color3.fromRGB(135, 135, 152),
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
		if not base then
			base = self.Dark
		end
		local m = {}
		for k, v in pairs(base) do
			m[k] = v
		end
		for k, v in pairs(overrides or {}) do
			m[k] = v
		end
		return m
	end

	local U = {}

	function U.Create(c, props, children)
		local inst = Instance.new(c)
		if props then
			for k, v in pairs(props) do
				inst[k] = v
			end
		end
		if children then
			for _, ch in ipairs(children) do
				ch.Parent = inst
			end
		end
		return inst
	end

	local LIBRARY_VERSION = "0.17.0"
	local CONFIG_V2_SCHEMA = "FyyUI.Config.v2"
	local MAX_CONFIG_JSON_BYTES = 64 * 1024
	local MAX_CONFIG_VALUES = 512
	local MAX_CONFIG_ARRAY_ITEMS = 256
	local MAX_CONFIG_STRING_BYTES = 16 * 1024
	local MAX_CONFIG_NODES = 8192

	--[[ Icon Module (Lucide/Solar/etc.) — auto-load from GitHub ]]
	local IconModule = nil
	local DEFAULT_ICON_URL = "https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/lucide/dist/Icons.lua"

	local function loadRemoteIconModule(url)
		url = url or DEFAULT_ICON_URL
		local raw
		local httpMethods = {
			function()
				return game:HttpGet(url)
			end,
			function()
				return game:GetService("HttpService"):GetAsync(url)
			end,
		}
		for _, method in ipairs(httpMethods) do
			local ok, result = pcall(method)
			if ok and type(result) == "string" and result ~= "" then
				raw = result
				break
			end
		end
		if not raw then
			return false, "Failed to download icon module"
		end

		local compiler = loadstring
		if type(compiler) ~= "function" then
			return false, "loadstring is unavailable"
		end
		local compiled, compileError = compiler(raw)
		if not compiled then
			return false, compileError or "Failed to compile icon module"
		end
		local ok, module = pcall(compiled)
		if not ok then
			return false, module
		end
		if type(module) ~= "table" then
			return false, "Icon module must return a table"
		end
		IconModule = module
		return true, module
	end

	loadRemoteIconModule(DEFAULT_ICON_URL)

	local function isFiniteNumber(value)
		return type(value) == "number" and value == value and value ~= math.huge and value ~= -math.huge
	end

	local function consumeConfigBudget(budget, bytes)
		budget.Nodes = budget.Nodes + 1
		if budget.Nodes > MAX_CONFIG_NODES then
			return false, "config has too many values"
		end
		budget.Bytes = budget.Bytes + bytes
		if budget.Bytes > MAX_CONFIG_JSON_BYTES then
			return false, "config is too large"
		end
		return true
	end

	local function copyJSONSafeValue(value, budget, seen, depth)
		local valueType = type(value)
		if valueType == "string" then
			if #value > MAX_CONFIG_STRING_BYTES then
				return nil, "string value is too large"
			end
			local withinBudget, budgetError = consumeConfigBudget(budget, #value + 2)
			if not withinBudget then
				return nil, budgetError
			end
			return value
		end
		if valueType == "boolean" then
			local withinBudget, budgetError = consumeConfigBudget(budget, 5)
			if not withinBudget then
				return nil, budgetError
			end
			return value
		end
		if valueType == "number" then
			if not isFiniteNumber(value) then
				return nil, "expected finite number"
			end
			local withinBudget, budgetError = consumeConfigBudget(budget, 32)
			if not withinBudget then
				return nil, budgetError
			end
			return value
		end
		if valueType ~= "table" then
			return nil, "expected JSON-safe value"
		end
		if depth >= 8 then
			return nil, "config value is nested too deeply"
		end
		if seen[value] then
			return nil, "config value contains a cycle"
		end
		local withinBudget, budgetError = consumeConfigBudget(budget, 2)
		if not withinBudget then
			return nil, budgetError
		end

		seen[value] = true
		local count, maxIndex = 0, 0
		for index in pairs(value) do
			if type(index) ~= "number" or index < 1 or index % 1 ~= 0 then
				seen[value] = nil
				return nil, "expected dense array"
			end
			count = count + 1
			if count > MAX_CONFIG_ARRAY_ITEMS then
				seen[value] = nil
				return nil, "config array is too large"
			end
			if index > maxIndex then
				maxIndex = index
			end
		end
		if count ~= maxIndex then
			seen[value] = nil
			return nil, "expected dense array"
		end
		local copied = {}
		for index = 1, count do
			local item, err = copyJSONSafeValue(value[index], budget, seen, depth + 1)
			if err then
				seen[value] = nil
				return nil, err
			end
			copied[index] = item
		end
		seen[value] = nil
		return copied
	end

	local function estimateJSONSafeValueBytes(value)
		local valueType = type(value)
		if valueType == "string" then
			return (#value * 6) + 2
		end -- conservative escaping bound
		if valueType == "boolean" then
			return 5
		end
		if valueType == "number" then
			return 32
		end
		local total = 2
		for index = 1, #value do
			total = total + estimateJSONSafeValueBytes(value[index]) + 1
		end
		return total
	end

	local function validateConfigV2Envelope(snapshot)
		if type(snapshot) ~= "table" then
			return false, "Invalid config v2: expected a table"
		end
		local allowed = { Schema = true, SchemaVersion = true, Version = true, Values = true }
		for key in pairs(snapshot) do
			if not allowed[key] then
				return false, "Invalid config v2: unexpected envelope field"
			end
		end
		if snapshot.Schema ~= CONFIG_V2_SCHEMA or snapshot.SchemaVersion ~= 2 then
			return false, "Invalid config v2: unsupported schema"
		end
		if type(snapshot.Version) ~= "string" or snapshot.Version == "" or #snapshot.Version > 64 then
			return false, "Invalid config v2: invalid Version"
		end
		if type(snapshot.Values) ~= "table" then
			return false, "Invalid config v2: missing Values table"
		end

		local count = 0
		local budget = { Nodes = 4, Bytes = 64 }
		local normalized = {
			Schema = CONFIG_V2_SCHEMA,
			SchemaVersion = 2,
			Version = snapshot.Version,
			Values = {},
		}
		for flag, value in pairs(snapshot.Values) do
			count = count + 1
			if count > MAX_CONFIG_VALUES then
				return false, "Invalid config v2: too many values"
			end
			if type(flag) ~= "string" or flag == "" or #flag > 128 then
				return false, "Invalid config v2: invalid flag"
			end
			local withinBudget, budgetError = consumeConfigBudget(budget, #flag + 4)
			if not withinBudget then
				return false, "Invalid config v2: " .. budgetError
			end
			local copied, err = copyJSONSafeValue(value, budget, {}, 0)
			if err then
				return false, "Invalid config v2: " .. err
			end
			normalized.Values[flag] = copied
		end
		return true, normalized
	end

	local function destroyedResult(controller)
		if controller._destroyed then
			return true, false, "destroyed"
		end
		return false
	end

	local function destroyedFactoryResult(owner)
		if owner._destroyed or (owner.Menu and owner.Menu._destroyed) or (owner._menu and owner._menu._destroyed) then
			return true, nil, "destroyed"
		end
		return false
	end

	local function resolveIcon(icon)
		if not icon or type(icon) ~= "string" then
			return nil
		end
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
				if colon then
					name = icon:sub(colon + 1)
				end
				local assetId = IconModule[name]
				if assetId then
					return { Image = assetId }
				end
			end
		end
		return nil
	end

	-- Helper: renders an icon as either an ImageLabel or TextLabel depending on
	-- what the configured icon provider returns. Callers pass
	-- the same extra table for Size/Position/etc.; Image-only props are mapped
	-- to text-equivalent properties when creating a TextLabel.
	local function renderIcon(parent, icon, extra)
		if not parent or not icon then
			return nil
		end
		local resolved = resolveIcon(icon)
		if not resolved then
			return nil
		end
		if resolved.Text then
			local props = {
				Name = "Icon",
				Size = UDim2.fromOffset(18, 18),
				BackgroundTransparency = 1,
				Text = resolved.Text,
				Font = Enum.Font.SourceSans,
				TextSize = 16,
				TextColor3 = Color3.fromRGB(200, 200, 210),
				TextXAlignment = Enum.TextXAlignment.Center,
				Parent = parent,
			}
			if extra then
				for k, v in pairs(extra) do
					if k == "ImageColor3" then
						props.TextColor3 = v
					elseif k == "ImageTransparency" then
						props.TextTransparency = v
					elseif k ~= "Image" and k ~= "ImageRectSize" and k ~= "ImageRectOffset" then
						props[k] = v
					end
				end
			end
			return U.Create("TextLabel", props)
		else
			local props = {
				Name = "Icon",
				Size = UDim2.fromOffset(18, 18),
				BackgroundTransparency = 1,
				Image = resolved.Image,
				Parent = parent,
			}
			if resolved.ImageRectSize then
				props.ImageRectSize = resolved.ImageRectSize
			end
			if resolved.ImageRectOffset then
				props.ImageRectOffset = resolved.ImageRectOffset
			end
			if extra then
				for k, v in pairs(extra) do
					if k == "TextColor3" then
						if extra.ImageColor3 == nil then
							props.ImageColor3 = v
						end
					elseif k == "TextTransparency" then
						if extra.ImageTransparency == nil then
							props.ImageTransparency = v
						end
					elseif
						k ~= "Text"
						and k ~= "Font"
						and k ~= "TextSize"
						and k ~= "TextXAlignment"
						and k ~= "TextYAlignment"
					then
						props[k] = v
					end
				end
			end
			return U.Create("ImageLabel", props)
		end
	end

	-- Apply a resolved icon (from resolveIcon) to an existing ImageLabel or TextLabel.
	-- Sets Image+ImageRect on ImageLabel, or Text on TextLabel.
	local function applyIconToLabel(label, resolved)
		if not label or not resolved then
			return
		end
		if resolved.Image then
			label.Image = resolved.Image
			if resolved.ImageRectSize then
				label.ImageRectSize = resolved.ImageRectSize
			end
			if resolved.ImageRectOffset then
				label.ImageRectOffset = resolved.ImageRectOffset
			end
		elseif resolved.Text then
			label.Text = resolved.Text
		end
	end

	local function updateRenderedIcon(label, icon, parent, extra)
		local resolved = resolveIcon(icon)
		if not resolved then
			return label
		end
		local sameType = label
			and ((resolved.Text and label:IsA("TextLabel")) or (resolved.Image and label:IsA("ImageLabel")))
		if sameType then
			applyIconToLabel(label, resolved)
			return label
		end
		if label then
			label:Destroy()
		end
		return renderIcon(parent, icon, extra)
	end

	local function cleanupController(controller)
		if controller._destroyed then
			return
		end
		controller._destroyed = true
		local menu = controller._menu
		if not menu then
			return
		end
		menu:_untrackFlagged(controller)
		if menu._activeDropdown == controller then
			menu:HideDropdownPopup()
		end
	end

	-- Shared forward declarations for the mutually-recursive layout controllers.
	local Collapsible, Columns
	--[[ Toggle ]]
	local Toggle = {}
	Toggle.__index = Toggle

	function Toggle.new(parent, options, theme)
		local self = setmetatable({}, Toggle)
		self._setValueNoCallbackPosition = 3
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
		U.Create(
			"UIStroke",
			{ Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = self.Container }
		)

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
		U.Create("UIStroke", { Color = Color3.fromRGB(0, 0, 0), Transparency = 0.8, Thickness = 1, Parent = self.Knob })

		self.Track.MouseEnter:Connect(function()
			if not self.Enabled then
				return
			end
			self.Track.BackgroundColor3 = self.Value and theme.ToggleOn or theme.ElementHover
		end)
		self.Track.MouseLeave:Connect(function()
			if not self.Enabled then
				return
			end
			self.Track.BackgroundColor3 = self.Value and theme.ToggleOn or theme.ToggleOff
		end)
		self.Track.Activated:Connect(function()
			if not self.Enabled then
				return
			end
			self:SetValue(not self.Value)
		end)

		return self
	end

	function Toggle:_animate(value, instant)
		if self._tweenTrack then
			self._tweenTrack:Cancel()
		end
		if self._tweenKnob then
			self._tweenKnob:Cancel()
		end
		local ts = game:GetService("TweenService")
		if instant then
			self.Track.BackgroundColor3 = value and self.Theme.ToggleOn or self.Theme.ToggleOff
			self.Knob.Position = UDim2.fromOffset(value and 26 or 2, 3)
		else
			local ti = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			self._tweenTrack =
				ts:Create(self.Track, ti, { BackgroundColor3 = value and self.Theme.ToggleOn or self.Theme.ToggleOff })
			self._tweenTrack:Play()
			self._tweenKnob = ts:Create(self.Knob, ti, { Position = UDim2.fromOffset(value and 26 or 2, 3) })
			self._tweenKnob:Play()
		end
	end

	function Toggle:SetValue(value, instant, noCallback)
		local isDestroyed, result, err = destroyedResult(self)
		if isDestroyed then
			return result, err
		end
		if type(value) ~= "boolean" then
			return false, "expected boolean"
		end
		if self.Value == value then
			return true
		end
		self.Value = value
		self:_animate(value, instant)
		if not noCallback then
			task.spawn(function()
				self.Callback(value)
			end)
		end
		return true
	end

	function Toggle:GetValue()
		return self.Value
	end
	function Toggle:SetEnabled(enabled)
		self.Enabled = enabled
		local t = enabled and 0 or 0.5
		self.Track.BackgroundTransparency = t
		self.Knob.BackgroundTransparency = t
	end
	function Toggle:SetText(text)
		self.Text = text
		self.Label.Text = text
	end
	function Toggle:SetDescription(desc)
		self.Description = desc
		local d = self.Container:FindFirstChild("Description")
		if d then
			d.Text = desc or ""
		end
	end
	function Toggle:Destroy()
		if self._destroyed then
			return
		end
		cleanupController(self)
		if self.Container then
			self.Container:Destroy()
		end
	end

	function Toggle:ApplyTheme(theme)
		self.Theme = theme
		if not self.Container then
			return
		end
		self.Container.BackgroundColor3 = theme.Element
		local stroke = self.Container:FindFirstChildOfClass("UIStroke")
		if stroke then
			stroke.Color = theme.ElementBorder
		end
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
		self.Min = options.Min == nil and 0 or options.Min
		self.Max = options.Max == nil and 100 or options.Max
		self.Step = options.Step == nil and 1 or options.Step
		assert(
			isFiniteNumber(self.Min) and isFiniteNumber(self.Max) and self.Min <= self.Max,
			"FyyUI Slider: Min and Max must be finite numbers with Min <= Max"
		)
		assert(
			isFiniteNumber(self.Step) and self.Step > 0,
			"FyyUI Slider: Step must be a finite number greater than zero"
		)
		local default = options.Default == nil and self.Min or options.Default
		assert(isFiniteNumber(default), "FyyUI Slider: Default must be a finite number")
		self.Value = math.clamp(default, self.Min, self.Max)
		self.Suffix = options.Suffix or ""
		self.Callback = options.Callback or function() end
		self.Flag = options.Flag
		self.Theme = theme
		self.HasDesc = self.Description ~= nil and self.Description ~= ""
		self._inOneToOneColumn = options._inOneToOneColumn == true
		local baseH = self.HasDesc and theme.DescHeight or theme.ElementHeight
		local h = self._inOneToOneColumn and (baseH + 20) or baseH
		local trackW = 110
		local trackX = -(trackW + 74)
		local textWidth = self._inOneToOneColumn and -88 or -(trackW + 100)
		local textY = self.HasDesc and 6 or (self._inOneToOneColumn and 7 or (h + 6 - 20) / 2 + 1)

		self.Container = U.Create("Frame", {
			Name = "Slider",
			Size = UDim2.new(1, -12, 0, h + 6),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			Parent = parent,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = self.Container })
		U.Create(
			"UIStroke",
			{ Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = self.Container }
		)

		self.Label = U.Create("TextLabel", {
			Name = "Label",
			Size = UDim2.new(1, textWidth, 0, 20),
			Position = UDim2.fromOffset(10, textY),
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
			Size = UDim2.fromOffset(54, 20),
			Position = UDim2.new(1, -68, 0, textY),
			BackgroundTransparency = 1,
			Text = tostring(self.Value) .. self.Suffix,
			Font = theme.FontBold,
			TextSize = theme.FontSize,
			TextColor3 = theme.Accent,
			TextXAlignment = Enum.TextXAlignment.Right,
			RichText = true,
			Parent = self.Container,
		})

		local trackH = 8
		local fillPct = (self.Max ~= self.Min) and (self.Value - self.Min) / (self.Max - self.Min) or 0

		self.Track = U.Create("Frame", {
			Name = "Track",
			Size = self._inOneToOneColumn and UDim2.new(1, -24, 0, trackH) or UDim2.fromOffset(trackW, trackH),
			Position = self._inOneToOneColumn and UDim2.new(0, 12, 1, -18) or UDim2.new(1, trackX, 0.5, -(trackH / 2)),
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
		U.Create(
			"UIStroke",
			{ Color = Color3.fromRGB(255, 255, 255), Transparency = 0.5, Thickness = 1.5, Parent = self.Knob }
		)
		self:_updateKnobPos()

		local uis = game:GetService("UserInputService")

		local function roundToStep(v)
			return math.round(v / self.Step) * self.Step
		end

		local dragging = false
		self.Knob.InputBegan:Connect(function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch
			then
				dragging = true
			end
		end)
		local dragCon
		dragCon = uis.InputChanged:Connect(function(input, processed)
			if processed then
				return
			end
			if
				(
					input.UserInputType == Enum.UserInputType.MouseMovement
					or input.UserInputType == Enum.UserInputType.Touch
				) and dragging
			then
				local absPos = self.Track.AbsolutePosition.X
				local size = self.Track.AbsoluteSize.X
				if size <= 0 then
					return
				end
				local pct = math.clamp((input.Position.X - absPos) / size, 0, 1)
				local val = self.Min + (self.Max - self.Min) * pct
				val = math.clamp(roundToStep(val), self.Min, self.Max)
				self:SetValue(val)
			end
		end)
		self.Knob.InputEnded:Connect(function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch
			then
				dragging = false
			end
		end)
		-- Service-level InputEnded: catches mouse-up even when pointer is no longer over the knob
		self._sliderEndCon = uis.InputEnded:Connect(function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch
			then
				dragging = false
			end
		end)
		self._dragCon = dragCon

		-- Click on track to jump
		self.Track.InputBegan:Connect(function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch
			then
				local absPos = self.Track.AbsolutePosition.X
				local size = self.Track.AbsoluteSize.X
				if size <= 0 then
					return
				end
				local pct = math.clamp((input.Position.X - absPos) / size, 0, 1)
				local val = self.Min + (self.Max - self.Min) * pct
				val = math.clamp(roundToStep(val), self.Min, self.Max)
				self:SetValue(val)
			end
		end)

		if self.HasDesc then
			U.Create("TextLabel", {
				Name = "Description",
				Size = UDim2.new(1, self._inOneToOneColumn and -24 or -(trackW + 100), 0, 16),
				Position = UDim2.fromOffset(12, 34),
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
		local isDestroyed, result, err = destroyedResult(self)
		if isDestroyed then
			return result, err
		end
		if not isFiniteNumber(v) then
			return false, "expected finite number"
		end
		v = math.clamp(v, self.Min, self.Max)
		if self.Value == v then
			return true
		end
		self.Value = v
		local pct = (self.Max ~= self.Min) and (v - self.Min) / (self.Max - self.Min) or 0
		pct = math.clamp(pct, 0, 1)
		self.Fill.Size = UDim2.new(pct, 0, 1, 0)
		self.Knob.Position = UDim2.new(pct, -7, 0.5, -7)
		self.ValueLabel.Text = tostring(v) .. self.Suffix
		if not noCallback then
			task.spawn(function()
				self.Callback(v)
			end)
		end
		return true
	end

	function Slider:GetValue()
		return self.Value
	end
	function Slider:Destroy()
		if self._destroyed then
			return
		end
		cleanupController(self)
		if self._dragCon then
			self._dragCon:Disconnect()
		end
		if self._sliderEndCon then
			self._sliderEndCon:Disconnect()
		end
		if self.Container then
			self.Container:Destroy()
		end
	end

	function Slider:ApplyTheme(theme)
		self.Theme = theme
		if not self.Container then
			return
		end
		self.Container.BackgroundColor3 = theme.Element
		local stroke = self.Container:FindFirstChildOfClass("UIStroke")
		if stroke then
			stroke.Color = theme.ElementBorder
		end
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
		assert(options.Options == nil or type(options.Options) == "table", "FyyUI Dropdown: Options must be a table")
		self.Options = options.Options or {}
		local function hasOption(value)
			for _, option in ipairs(self.Options) do
				if option == value then
					return true
				end
			end
			return false
		end
		self.Multi = options.Multi or false -- Multi-Select mode
		-- AllowNone: if false, single-select always retains a valid option when options exist
		self.AllowNone = options.AllowNone
		if self.AllowNone == nil then
			self.AllowNone = true
		end
		self.Value = "" -- start empty; use Default to pre-select
		if options.Default ~= nil then
			self.Value = options.Default
		elseif self.Options[1] and not options.Placeholder then
			self.Value = self.Options[1] -- backward compat: auto-select first
		end
		-- AllowNone=false: ensure a valid selection when options exist
		if not self.Multi and not self.AllowNone and #self.Options > 0 and (self.Value == nil or self.Value == "") then
			self.Value = self.Options[1]
		end
		if not self.Multi and self.Value ~= nil and self.Value ~= "" and not hasOption(self.Value) then
			self.Value = self.AllowNone and "" or self.Options[1] or ""
		end
		self.Placeholder = options.Placeholder or "Not selected"
		self._selected = {} -- set of selected values (multi mode)
		self._selectedCount = 0
		if self.Multi then
			local defaults = {}
			if type(options.Default) == "table" then
				defaults = options.Default
			elseif options.Default ~= nil then
				defaults = { options.Default }
			end
			for _, v in ipairs(defaults) do
				if hasOption(v) and not self._selected[v] then
					self._selected[v] = true
					self._selectedCount = self._selectedCount + 1
				end
			end
		end
		self.Callback = options.Callback or function() end
		self.Flag = options.Flag
		self.Theme = theme
		self.Open = false
		self.HasDesc = self.Description ~= nil and self.Description ~= ""
		local h = self.HasDesc and theme.DescHeight or theme.ElementHeight
		local btnW = options._compactControl and 88 or 100

		self.Container = U.Create("Frame", {
			Name = "Dropdown",
			Size = UDim2.new(1, -12, 0, h + 6),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			Parent = parent,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = self.Container })
		U.Create(
			"UIStroke",
			{ Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = self.Container }
		)

		U.Create("TextLabel", {
			Name = "Label",
			Size = UDim2.new(1, -(btnW + 28), 0, 20),
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

		self.SelectBtn = U.Create("ImageButton", {
			Name = "Select",
			Size = UDim2.fromOffset(btnW, 26),
			Position = UDim2.new(1, -(btnW + 12), 0.5, -13),
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
			return self:_displayText()
		end
		local function initSelectColor()
			if self.Multi then
				return self._selectedCount > 0 and theme.TextPrimary or theme.TextMuted
			end
			return (self.Value and self.Value ~= "") and theme.TextPrimary or theme.TextMuted
		end
		self.SelectText = U.Create("TextLabel", {
			Name = "Text",
			Size = UDim2.new(1, -24, 1, 0),
			Position = UDim2.fromOffset(6, 0),
			BackgroundTransparency = 1,
			Text = initSelectText(),
			TextColor3 = initSelectColor(),
			Font = theme.Font,
			TextSize = theme.FontSize,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Parent = self.SelectBtn,
		})

		self._arrowDown = resolveIcon("chevron-down") or { Image = "rbxassetid://134243273101015" }
		self._arrowRight = resolveIcon("chevron-right") or { Image = "rbxassetid://92473583511724" }
		self._arrow = renderIcon(self.SelectBtn, "chevron-down", {
			Name = "Arrow",
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.new(1, -20, 0.5, -8),
		})

		-- Find selected index
		local selectedIdx = 0
		for i, opt in ipairs(self.Options) do
			if opt == self.Value then
				selectedIdx = i
				break
			end
		end

		-- Dropdown toggle
		self.SelectBtn.Activated:Connect(function()
			if not self._menu then
				return
			end
			if self._menu._activePopupFrame then
				self.Open = false
				if self._arrow then
					applyIconToLabel(self._arrow, self._arrowDown)
				end
				if self._menu._activeDropdown == self then
					self._menu._activeDropdown = nil
				end
				self._menu:HideDropdownPopup()
			else
				if self._menu._activeDropdown and self._menu._activeDropdown ~= self then
					self._menu._activeDropdown.Open = false
					if self._menu._activeDropdown._arrow and self._menu._activeDropdown._arrowDown then
						applyIconToLabel(self._menu._activeDropdown._arrow, self._menu._activeDropdown._arrowDown)
					end
					self._menu:HideDropdownPopup()
				end
				local pos = self.SelectBtn.AbsolutePosition
				local siz = self.SelectBtn.AbsoluteSize
				self._selIdx = 0
				for i, opt in ipairs(self.Options) do
					if opt == self.Value then
						self._selIdx = i
						break
					end
				end
				local shown = self._menu:ShowDropdownPopup(pos, siz, self.Options, self._selIdx, function(idx, val)
					self:SetValue(val)
				end, self.Multi, self)
				if shown then
					self.Open = true
					if self._arrow then
						applyIconToLabel(self._arrow, self._arrowRight)
					end
					self._menu._activeDropdown = self
				else
					self.Open = false
					if self._arrow then
						applyIconToLabel(self._arrow, self._arrowDown)
					end
				end
			end
		end)

		if self.HasDesc then
			U.Create("TextLabel", {
				Name = "Description",
				Size = UDim2.new(1, -(btnW + 28), 0, 16),
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

		-- Tooltip from options
		if options.Tooltip and menuRef then
			menuRef:BindTooltip(self.Container, options.Tooltip)
		end

		return self
	end

	function Dropdown:_updateDisplay()
		-- Update display text from current state (used by SetOptions/Refresh)
		self.SelectText.Text = self:_displayText()
		if self.Multi then
			self.SelectText.TextColor3 = (self._selectedCount > 0) and self.Theme.TextPrimary or self.Theme.TextMuted
		else
			self.SelectText.TextColor3 = (self.Value ~= "") and self.Theme.TextPrimary or self.Theme.TextMuted
		end
	end

	function Dropdown:SetValue(v, noCallback)
		local isDestroyed, result, err = destroyedResult(self)
		if isDestroyed then
			return result, err
		end
		if self.Multi then
			-- Multi-select: toggle the value
			if not self:_optIndex(self.Options, v) then
				return false, "unknown option"
			end
			if self._selected[v] then
				self._selected[v] = nil
				self._selectedCount = math.max(0, self._selectedCount - 1)
			else
				self._selected[v] = true
				self._selectedCount = self._selectedCount + 1
			end
			-- Update display text
			self.SelectText.Text = self:_displayText()
			self.SelectText.TextColor3 = (self._selectedCount > 0) and self.Theme.TextPrimary or self.Theme.TextMuted
			if not noCallback then
				local snapshot = self:GetValue()
				task.spawn(function()
					self.Callback(snapshot)
				end)
			end
			return true
		end

		-- Single-select
		if v == self.Value then
			if self.AllowNone then
				-- Unselect when AllowNone=true and re-clicking the active option
				self.Value = ""
				self.SelectText.Text = self.Placeholder
				self.SelectText.TextColor3 = self.Theme.TextMuted
				if self._selectStroke then
					self._selectStroke.Transparency = 0.8
				end
				self._selIdx = 0
				self.Open = false
				if self._arrow then
					applyIconToLabel(self._arrow, self._arrowDown)
				end
				if self._menu and self._menu._activeDropdown == self then
					self._menu._activeDropdown = nil
					self._menu:HideDropdownPopup()
				end
				if not noCallback then
					task.spawn(function()
						self.Callback("")
					end)
				end
				return true
			end
			if self._arrow then
				applyIconToLabel(self._arrow, self._arrowDown)
			end
			if self._menu and self._menu._activeDropdown == self then
				self._menu._activeDropdown = nil
				self._menu:HideDropdownPopup()
			end
			return true
		end
		-- AllowNone guard: prevent clearing selection when AllowNone=false and options exist
		if not self.AllowNone and #self.Options > 0 and v == "" then
			if self._arrow then
				applyIconToLabel(self._arrow, self._arrowDown)
			end
			if self._menu and self._menu._activeDropdown == self then
				self._menu._activeDropdown = nil
				self._menu:HideDropdownPopup()
			end
			return true
		end
		if v ~= "" and not self:_optIndex(self.Options, v) then
			return false, "unknown option"
		end
		self.Value = v
		self.SelectText.Text = self:_displayText()
		self.SelectText.TextColor3 = (self.Value ~= "") and self.Theme.TextPrimary or self.Theme.TextMuted
		if self._selectStroke then
			self._selectStroke.Transparency = (self.Value ~= "") and 0.5 or 0.8
		end
		self._selIdx = 0
		for i, opt in ipairs(self.Options) do
			if opt == v then
				self._selIdx = i
				break
			end
		end
		self.Open = false
		if self._arrow then
			applyIconToLabel(self._arrow, self._arrowDown)
		end
		if self._menu and self._menu._activeDropdown == self then
			self._menu._activeDropdown = nil
			self._menu:HideDropdownPopup()
		end
		if not noCallback then
			task.spawn(function()
				self.Callback(v)
			end)
		end
		return true
	end

	function Dropdown:GetValue()
		if self.Multi then
			local result = {}
			for _, opt in ipairs(self.Options) do
				if self._selected[opt] then
					table.insert(result, opt)
				end
			end
			return result
		end
		return self.Value
	end

	function Dropdown:SetOptions(options, preferredValue, noCallback)
		local isDestroyed, result, err = destroyedResult(self)
		if isDestroyed then
			return result, err
		end
		if options == nil then
			options = {}
		end
		if type(options) ~= "table" then
			return false, "expected options table"
		end
		local oldValue = self:GetValue()
		local function sameSelection(a, b)
			if type(a) ~= "table" or type(b) ~= "table" then
				return a == b
			end
			if #a ~= #b then
				return false
			end
			for i, value in ipairs(a) do
				if b[i] ~= value then
					return false
				end
			end
			return true
		end

		-- Replace options list
		self.Options = {}
		for i, option in ipairs(options) do
			self.Options[i] = option
		end
		options = self.Options

		if self.Multi then
			-- Multi: remove selections that no longer exist in new options
			local optSet = {}
			for _, opt in ipairs(options) do
				optSet[opt] = true
			end
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
				if opt == self.Value then
					self._selIdx = i
					break
				end
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
					if opt == self.Value then
						selIdx = i
						break
					end
				end
				local shown = self._menu:ShowDropdownPopup(pos, siz, options, selIdx, function(idx, val)
					self:SetValue(val)
				end, self.Multi, self)
				if shown then
					self.Open = true
					self._menu._activeDropdown = self
				else
					self.Open = false
					if self._arrow then
						applyIconToLabel(self._arrow, self._arrowDown)
					end
				end
			end
		end

		-- Fire callback if selection changed (and noCallback is not set)
		if not noCallback then
			if self.Multi then
				local newValue = self:GetValue()
				if not sameSelection(oldValue, newValue) then
					task.spawn(function()
						self.Callback(newValue)
					end)
				end
			else
				local newValue = self.Value
				if newValue ~= oldValue then
					task.spawn(function()
						self.Callback(newValue)
					end)
				end
			end
		end
		return true
	end

	-- Canonical display-summary helper used by constructor, _updateDisplay, SetValue, SetOptions/Refresh.
	-- Single: shows value or Placeholder when empty.
	-- Multi: shows Placeholder when empty; first option text when one selected;
	--        "First +N-1" when multiple selected (N = total selected count).
	function Dropdown:_displayText()
		if self.Multi then
			if self._selectedCount == 0 then
				return self.Placeholder
			end
			local first
			local extras = 0
			for _, opt in ipairs(self.Options) do
				if self._selected[opt] then
					if first == nil then
						first = opt
					else
						extras = extras + 1
					end
				end
			end
			if extras == 0 then
				return tostring(first)
			end
			return tostring(first) .. " +" .. extras
		end
		return (self.Value ~= "") and tostring(self.Value) or self.Placeholder
	end

	function Dropdown:_optIndex(list, value)
		for i, v in ipairs(list) do
			if v == value then
				return i
			end
		end
		return nil
	end

	function Dropdown:Refresh(options, preferredValue, noCallback)
		if options ~= nil then
			return self:SetOptions(options, preferredValue, noCallback)
		else
			-- Refresh from current options, preserve current selection
			return self:SetOptions(self.Options, self.Value, noCallback)
		end
	end

	function Dropdown:Destroy()
		if self._destroyed then
			return
		end
		cleanupController(self)
		if self.Container then
			self.Container:Destroy()
		end
	end

	function Dropdown:ApplyTheme(theme)
		self.Theme = theme
		if not self.Container then
			return
		end
		self.Container.BackgroundColor3 = theme.Element
		local stroke = self.Container:FindFirstChildOfClass("UIStroke")
		if stroke then
			stroke.Color = theme.ElementBorder
		end
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
		if self._selectStroke then
			self._selectStroke.Color = theme.Accent
		end
	end
	--[[ Keybind ]]
	local Keybind = {}
	Keybind.__index = Keybind

	function Keybind.new(parent, options, theme, menuRef)
		local self = setmetatable({}, Keybind)
		self.Text = options.Text or "Keybind"
		self.Description = options.Description
		self.Mode = options.Mode or "Toggle"
		assert(self.Mode == "Toggle" or self.Mode == "Hold", "FyyUI Keybind: Mode must be Toggle or Hold")
		self.Callback = options.Callback or function() end
		self.Flag = options.Flag
		self.Theme = theme
		self._menu = menuRef
		self._inputType = nil -- "Keyboard" or "MouseButton"
		self._keyCode = nil
		self._capturing = false
		self._active = false

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
		U.Create(
			"UIStroke",
			{ Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = self.Container }
		)

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

		-- Parse Default after KeyLabel exists so SetValue can update the UI safely.
		if options.Default ~= nil then
			self:SetValue(options.Default)
		end

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
			if self._capturing then
				return
			end
			self.CaptureBtn.BackgroundColor3 = theme.Element
		end)
		self.CaptureBtn.MouseLeave:Connect(function()
			if self._capturing then
				return
			end
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
		if not self._keyCode then
			return "None"
		end
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
		if self._capturing then
			self:_exitCapture()
			return
		end
		self._capturing = true
		self.KeyLabel.Text = "..."
		self.KeyLabel.TextColor3 = self.Theme.Accent
		self.CaptureBtn.BackgroundColor3 = self.Theme.Accent
		if self._menu then
			self._menu._capturingKeybind = self
		end
	end

	function Keybind:_exitCapture()
		self._capturing = false
		if self._menu then
			self._menu._capturingKeybind = nil
		end
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
		elseif
			input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.MouseButton2
			or input.UserInputType == Enum.UserInputType.MouseButton3
		then
			self._inputType = "MouseButton"
			self._keyCode = input.UserInputType
		end
		self:_updateDisplay()
	end

	function Keybind:SetValue(v)
		local isDestroyed, result, err = destroyedResult(self)
		if isDestroyed then
			return result, err
		end
		if v == nil then
			self._inputType = nil
			self._keyCode = nil
			self:_updateDisplay()
			return true
		end
		if typeof(v) == "EnumItem" then
			if v.EnumType == Enum.KeyCode then
				self._inputType = "Keyboard"
				self._keyCode = v
				self:_updateDisplay()
				return true
			elseif
				v.EnumType == Enum.UserInputType
				and (
					v == Enum.UserInputType.MouseButton1
					or v == Enum.UserInputType.MouseButton2
					or v == Enum.UserInputType.MouseButton3
				)
			then
				self._inputType = "MouseButton"
				self._keyCode = v
				self:_updateDisplay()
				return true
			end
		end
		if type(v) == "string" then
			-- Try KeyCode first, then UserInputType
			for _, item in ipairs(Enum.KeyCode:GetEnumItems()) do
				if item.Name == v then
					self._inputType = "Keyboard"
					self._keyCode = item
					self:_updateDisplay()
					return true
				end
			end
			for _, item in ipairs(Enum.UserInputType:GetEnumItems()) do
				if
					item.Name == v
					and (
						item == Enum.UserInputType.MouseButton1
						or item == Enum.UserInputType.MouseButton2
						or item == Enum.UserInputType.MouseButton3
					)
				then
					self._inputType = "MouseButton"
					self._keyCode = item
					self:_updateDisplay()
					return true
				end
			end
		end
		return false, "expected a KeyCode, MouseButton input, key name, or nil"
	end

	function Keybind:GetValue()
		if not self._keyCode then
			return nil
		end
		local s = tostring(self._keyCode)
		if self._inputType == "Keyboard" then
			return (s:match("Enum%.KeyCode%.(.+)"))
		else
			return (s:match("Enum%.UserInputType%.(.+)"))
		end
	end

	function Keybind:SetMode(mode)
		local isDestroyed, result, err = destroyedResult(self)
		if isDestroyed then
			return result, err
		end
		if mode ~= "Toggle" and mode ~= "Hold" then
			return false, "expected Toggle or Hold"
		end
		self.Mode = mode
		return true
	end

	function Keybind:Destroy()
		if self._destroyed then
			return
		end
		cleanupController(self)
		if self._menu then
			self._menu:_unregisterKeybind(self)
			if self._menu._capturingKeybind == self then
				self._menu._capturingKeybind = nil
			end
		end
		if self.Container then
			self.Container:Destroy()
		end
	end

	function Keybind:ApplyTheme(theme)
		self.Theme = theme
		if not self.Container then
			return
		end
		self.Container.BackgroundColor3 = theme.Element
		local stroke = self.Container:FindFirstChildOfClass("UIStroke")
		if stroke then
			stroke.Color = theme.ElementBorder
		end
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
		U.Create(
			"UIStroke",
			{ Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = self.Container }
		)

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
			task.spawn(function()
				self.Callback(self._value, enterPressed)
			end)
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
		local isDestroyed, result, err = destroyedResult(self)
		if isDestroyed then
			return result, err
		end
		if self.Numeric then
			if value == nil or value == "" then
				self._lastValidValue = nil
				self._value = ""
				if self.TextBox then
					self.TextBox.Text = self._value
				end
			else
				local num = tonumber(value)
				if num == nil or not isFiniteNumber(num) then
					return false, "expected finite number"
				end
				self._lastValidValue = num
				self._value = tostring(num)
				if self.TextBox then
					self.TextBox.Text = self._value
				end
			end
		else
			self._value = tostring(value)
			if self.TextBox then
				self.TextBox.Text = self._value
			end
		end
		if not noCallback then
			task.spawn(function()
				self.Callback(self._value, false)
			end)
		end
		return true
	end

	function TextInput:GetValue()
		if self.Numeric then
			return tonumber(self._value) or 0
		end
		return self._value
	end

	function TextInput:IsEmpty()
		return self._value == ""
	end

	function TextInput:Focus()
		if not self._destroyed and self.TextBox then
			self.TextBox:CaptureFocus()
		end
	end

	function TextInput:Destroy()
		if self._destroyed then
			return
		end
		cleanupController(self)
		if self.Container then
			self.Container:Destroy()
		end
	end

	function TextInput:ApplyTheme(theme)
		self.Theme = theme
		if not self.Container then
			return
		end
		self.Container.BackgroundColor3 = theme.Element
		local stroke = self.Container:FindFirstChildOfClass("UIStroke")
		if stroke then
			stroke.Color = theme.ElementBorder
		end
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
	--[[ Checkbox ]]
	local Checkbox = {}
	Checkbox.__index = Checkbox

	function Checkbox.new(parent, options, theme)
		local self = setmetatable({}, Checkbox)
		self._setValueNoCallbackPosition = 3
		self.Text = options.Text or "Checkbox"
		self.Value = options.Default or false
		self.Callback = options.Callback or function() end
		self.Flag = options.Flag
		self.Theme = theme
		self.HasDesc = options.Description ~= nil and options.Description ~= ""
		local h = self.HasDesc and theme.DescHeight or theme.ElementHeight

		self.Container = U.Create("ImageButton", {
			Name = "Checkbox",
			Size = UDim2.new(1, -12, 0, h + 6),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Selectable = true,
			Active = true,
			Parent = parent,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = self.Container })
		U.Create(
			"UIStroke",
			{ Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = self.Container }
		)

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
		self.Box.Activated:Connect(function()
			self:SetValue(not self.Value)
		end)
		self.Container.Activated:Connect(function()
			self:SetValue(not self.Value)
		end)

		return self
	end

	function Checkbox:SetValue(v, instant, noCallback)
		local isDestroyed, result, err = destroyedResult(self)
		if isDestroyed then
			return result, err
		end
		if type(v) ~= "boolean" then
			return false, "expected boolean"
		end
		if self.Value == v then
			return true
		end
		self.Value = v
		local ts = game:GetService("TweenService")
		local ti = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		if instant then
			self.Box.BackgroundColor3 = v and self.Theme.Accent or self.Theme.ElementHover
		else
			ts:Create(self.Box, ti, { BackgroundColor3 = v and self.Theme.Accent or self.Theme.ElementHover }):Play()
		end
		if not noCallback then
			task.spawn(function()
				self.Callback(v)
			end)
		end
		return true
	end
	function Checkbox:GetValue()
		return self.Value
	end
	function Checkbox:Destroy()
		if self._destroyed then
			return
		end
		cleanupController(self)
		if self.Container then
			self.Container:Destroy()
		end
	end

	function Checkbox:ApplyTheme(theme)
		self.Theme = theme
		if not self.Container then
			return
		end
		self.Container.BackgroundColor3 = theme.Element
		local stroke = self.Container:FindFirstChildOfClass("UIStroke")
		if stroke then
			stroke.Color = theme.ElementBorder
		end
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
	end
	--[[ Columns Layout ]]
	local Column = {}
	Column.__index = Column

	-- Column helper: register a newly constructed child component
	function Column:_mount(c, opts)
		if not c then
			return nil
		end
		table.insert(self.Components, c)
		if c.Flag and self._menu then
			self._menu:_trackFlagged(c)
		end
		if opts.Tooltip and self._menu and c.Container then
			self._menu:BindTooltip(c.Container, opts.Tooltip)
		end
		self._columns:_updateHeight()
		return c
	end

	function Column.new(columns, index, theme, menuRef)
		local self = setmetatable({}, Column)
		self._columns = columns
		self._menu = menuRef
		self.Theme = theme
		self.Components = {}
		self.Content = U.Create("Frame", {
			Name = "Column" .. index,
			Size = UDim2.fromOffset(0, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Parent = columns.Container,
		})
		self._layout = U.Create("UIListLayout", {
			Padding = UDim.new(0, theme.Spacing),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = self.Content,
		})
		-- Recalculate Columns height whenever this column's content layout changes
		self._layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			if not columns._destroyed and not self._destroyed then
				columns:_updateHeight()
			end
		end)
		return self
	end

	function Column:_contentHeight()
		return self._layout and self._layout.AbsoluteContentSize.Y or 0
	end

	-- Pass-through factories (delegate via _mount to reuse registration logic)
	function Column:Toggle(opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		return self:_mount(Toggle.new(self.Content, opts, self.Theme), opts)
	end

	function Column:Checkbox(opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		return self:_mount(Checkbox.new(self.Content, opts, self.Theme), opts)
	end

	function Column:Slider(opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		if self._columns._isOneToOne then
			local clo = {}
			for k, v in pairs(opts) do
				clo[k] = v
			end
			clo._inOneToOneColumn = true
			opts = clo
		end
		return self:_mount(Slider.new(self.Content, opts, self.Theme), opts)
	end

	function Column:Dropdown(opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		local dropdownOpts = {}
		for k, v in pairs(opts) do
			dropdownOpts[k] = v
		end
		dropdownOpts._compactControl = true
		return self:_mount(Dropdown.new(self.Content, dropdownOpts, self.Theme, self._menu), opts)
	end

	function Column:Keybind(opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		return self:_mount(Keybind.new(self.Content, opts, self.Theme, self._menu), opts)
	end

	function Column:Input(opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		return self:_mount(TextInput.new(self.Content, opts, self.Theme), opts)
	end

	function Column:Collapsible(title, opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		local c = Collapsible.new(self.Content, title, opts, self.Theme)
		c._menu = self._menu
		if self._columns._isOneToOne then
			c._inOneToOne = true
		end
		table.insert(self.Components, c)
		self._columns:_updateHeight()
		return c
	end

	function Column:Columns(opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		local columns = Columns.new(self.Content, opts, self.Theme, self._menu, function()
			self._columns:_updateHeight()
		end)
		table.insert(self.Components, columns)
		self._columns:_updateHeight()
		return columns
	end

	-- Inline factories (Button, Label, BoldLabel, Divider) — same pattern as Collapsible
	function Column:Button(opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		local theme = self.Theme
		local hasDesc = opts.Description ~= nil and opts.Description ~= ""
		local h = hasDesc and theme.DescHeight or theme.ElementHeight
		local btn = {}
		btn.Container = U.Create("ImageButton", {
			Name = "Button",
			Size = UDim2.new(1, -12, 0, h + 6),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0,
			AutoButtonColor = false,
			BorderSizePixel = 0,
			Parent = self.Content,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = btn.Container })
		U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = btn.Container })
		renderIcon(btn.Container, opts.Icon or "rocket", {
			Name = "Pointer",
			Size = UDim2.fromOffset(26, 26),
			Position = UDim2.new(1, -38, 0.5, -13),
			ImageTransparency = 0.5,
		})
		local ix = 10
		if hasDesc then
			U.Create("TextLabel", {
				Name = "Text",
				Size = UDim2.new(1, -20, 0, 20),
				Position = UDim2.fromOffset(ix, 5),
				BackgroundTransparency = 1,
				Text = opts.Text or "Button",
				Font = theme.Font,
				TextSize = theme.FontSize,
				TextColor3 = opts.Color or theme.TextPrimary,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = btn.Container,
			})
			U.Create("TextLabel", {
				Name = "Description",
				Size = UDim2.new(1, -20, 0, 16),
				Position = UDim2.fromOffset(ix, 27),
				BackgroundTransparency = 1,
				Text = opts.Description,
				Font = theme.Font,
				TextSize = theme.FontSizeSmall,
				TextColor3 = theme.TextMuted,
				TextXAlignment = Enum.TextXAlignment.Left,
				RichText = true,
				Parent = btn.Container,
			})
		else
			U.Create("TextLabel", {
				Name = "Text",
				Size = UDim2.new(1, -20, 0, 20),
				Position = UDim2.fromOffset(ix, (h + 6 - 20) / 2 + 1),
				BackgroundTransparency = 1,
				Text = opts.Text or "Button",
				Font = theme.Font,
				TextSize = theme.FontSize,
				TextColor3 = opts.Color or theme.TextPrimary,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = btn.Container,
			})
		end
		local _sc = U.Create("UIScale", { Parent = btn.Container })
		btn.Container.MouseEnter:Connect(function()
			btn.Container.BackgroundColor3 = theme.ElementHover
			btn.Container.BackgroundTransparency = 0
		end)
		btn.Container.MouseLeave:Connect(function()
			btn.Container.BackgroundColor3 = theme.Element
			btn.Container.BackgroundTransparency = 0
		end)
		btn.Container.MouseButton1Down:Connect(function()
			game:GetService("TweenService"):Create(_sc, TweenInfo.new(0.05), { Scale = 0.97 }):Play()
		end)
		btn.Container.MouseButton1Up:Connect(function()
			game:GetService("TweenService"):Create(_sc, TweenInfo.new(0.08), { Scale = 1 }):Play()
		end)
		btn.Container.MouseButton1Click:Connect(function()
			if opts.Callback then
				opts.Callback()
			end
		end)
		btn.Destroy = function()
			if btn.Container then
				btn.Container:Destroy()
			end
		end
		local _btnColor = opts.Color
		btn.ApplyTheme = function(_, t)
			t = t or _
			if not btn.Container then
				return
			end
			btn.Container.BackgroundColor3 = t.Element
			local stroke = btn.Container:FindFirstChildOfClass("UIStroke")
			if stroke then
				stroke.Color = t.ElementBorder
			end
			local text = btn.Container:FindFirstChild("Text")
			if text then
				text.Font = t.Font
				text.TextSize = t.FontSize
				text.TextColor3 = _btnColor or t.TextPrimary
			end
			local desc = btn.Container:FindFirstChild("Description")
			if desc then
				desc.Font = t.Font
				desc.TextSize = t.FontSizeSmall
				desc.TextColor3 = t.TextMuted
			end
		end
		table.insert(self.Components, btn)
		self._columns:_updateHeight()
		return btn
	end

	function Column:Label(opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		local theme = self.Theme
		local hasDesc = opts.Description ~= nil and opts.Description ~= ""
		local h = hasDesc and theme.DescHeight or theme.ElementHeight
		local lbl = {}
		local _lblColor = opts.Color
		local _lblTextSize = opts.TextSize or theme.FontSize
		lbl.Container = U.Create(
			"Frame",
			{ Name = "Label", Size = UDim2.new(1, 0, 0, h), BackgroundTransparency = 1, Parent = self.Content }
		)
		lbl.TextLabel = U.Create("TextLabel", {
			Name = "Text",
			Size = UDim2.new(1, 0, 0, hasDesc and 20 or h),
			Position = UDim2.fromOffset(0, hasDesc and 2 or (h - 20) / 2 + 1),
			BackgroundTransparency = 1,
			Text = opts.Text or "",
			Font = theme.Font,
			TextSize = _lblTextSize,
			TextColor3 = _lblColor or theme.TextSecondary,
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
				Text = opts.Description,
				Font = theme.Font,
				TextSize = theme.FontSizeSmall,
				TextColor3 = theme.TextMuted,
				TextXAlignment = Enum.TextXAlignment.Left,
				RichText = true,
				Parent = lbl.Container,
			})
		end
		lbl.SetText = function(text)
			lbl.TextLabel.Text = text
		end
		lbl.SetColor = function(c)
			lbl.TextLabel.TextColor3 = c
		end
		lbl.Destroy = function()
			if lbl.Container then
				lbl.Container:Destroy()
			end
		end
		lbl.ApplyTheme = function(_, t)
			t = t or _
			if not lbl.TextLabel then
				return
			end
			lbl.TextLabel.Font = t.Font
			lbl.TextLabel.TextSize = _lblTextSize
			lbl.TextLabel.TextColor3 = _lblColor or t.TextSecondary
			local d = lbl.Container:FindFirstChild("Description")
			if d then
				d.Font = t.Font
				d.TextSize = t.FontSizeSmall
				d.TextColor3 = t.TextMuted
			end
		end
		table.insert(self.Components, lbl)
		self._columns:_updateHeight()
		return lbl
	end

	function Column:BoldLabel(opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		local theme = self.Theme
		local hasDesc = opts.Description ~= nil and opts.Description ~= ""
		local h = hasDesc and theme.DescHeight or theme.ElementHeight
		local lbl = {}
		local _blblColor = opts.Color
		local _blblTextSize = opts.TextSize or theme.FontSizeTitle
		lbl.Container = U.Create(
			"Frame",
			{ Name = "BoldLabel", Size = UDim2.new(1, 0, 0, h), BackgroundTransparency = 1, Parent = self.Content }
		)
		lbl.TextLabel = U.Create("TextLabel", {
			Name = "Text",
			Size = UDim2.new(1, 0, 0, hasDesc and 22 or h),
			Position = UDim2.fromOffset(0, hasDesc and 2 or (h - 22) / 2 + 1),
			BackgroundTransparency = 1,
			Text = opts.Text or "",
			Font = theme.FontBold,
			TextSize = _blblTextSize,
			TextColor3 = _blblColor or theme.TextPrimary,
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
				Text = opts.Description,
				Font = theme.Font,
				TextSize = theme.FontSizeSmall,
				TextColor3 = theme.TextMuted,
				TextXAlignment = Enum.TextXAlignment.Left,
				RichText = true,
				Parent = lbl.Container,
			})
		end
		lbl.SetText = function(text)
			lbl.TextLabel.Text = text
		end
		lbl.SetColor = function(c)
			lbl.TextLabel.TextColor3 = c
		end
		lbl.Destroy = function()
			if lbl.Container then
				lbl.Container:Destroy()
			end
		end
		lbl.ApplyTheme = function(_, t)
			t = t or _
			if not lbl.TextLabel then
				return
			end
			lbl.TextLabel.Font = t.FontBold
			lbl.TextLabel.TextSize = _blblTextSize
			lbl.TextLabel.TextColor3 = _blblColor or t.TextPrimary
			local d = lbl.Container:FindFirstChild("Description")
			if d then
				d.Font = t.Font
				d.TextSize = t.FontSizeSmall
				d.TextColor3 = t.TextMuted
			end
		end
		table.insert(self.Components, lbl)
		self._columns:_updateHeight()
		return lbl
	end

	function Column:Divider()
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		local div = {}
		div.Container = U.Create("Frame", {
			Name = "Divider",
			Size = UDim2.new(1, -20, 0, 1),
			Position = UDim2.fromOffset(10, 0),
			BackgroundColor3 = self.Theme.Border,
			BackgroundTransparency = 0.5,
			BorderSizePixel = 0,
			Parent = self.Content,
		})
		div.ApplyTheme = function(_, t)
			t = t or _
			if div.Container then
				div.Container.BackgroundColor3 = t.Border
			end
		end
		table.insert(self.Components, div)
		self._columns:_updateHeight()
		return div
	end

	function Column:Destroy()
		if self._destroyed then
			return
		end
		self._destroyed = true
		for _, c in ipairs(self.Components) do
			if c.Destroy then
				c:Destroy()
			end
		end
		self.Components = {}
		if self.Content then
			self.Content:Destroy()
		end
	end

	function Column:ApplyTheme(theme)
		self.Theme = theme
		if not self.Content then
			return
		end
		if self._layout then
			self._layout.Padding = UDim.new(0, theme.Spacing)
		end
		for _, c in ipairs(self.Components) do
			if c.ApplyTheme then
				c:ApplyTheme(theme)
			end
		end
	end

	--[[ Columns controller ]]
	Columns = {}
	Columns.__index = Columns

	function Columns.new(parent, options, theme, menuRef, parentUpdateCallback)
		local self = setmetatable({}, Columns)
		self._destroyed = false
		self._menu = menuRef
		self.Theme = theme
		self.Components = {}
		self._parentUpdate = parentUpdateCallback

		-- Parse & validate options
		self._ratio = options.Ratio or { 1, 1 }
		self._gap = options.Gap or 8
		self._stackCompact = options.StackOnCompact ~= false
		assert(
			type(self._ratio) == "table" and #self._ratio >= 2,
			"Columns: Ratio must be a table with at least 2 positive finite numbers"
		)
		for _, v in ipairs(self._ratio) do
			assert(isFiniteNumber(v) and v > 0, "Columns: each Ratio value must be a positive finite number")
		end
		assert(isFiniteNumber(self._gap) and self._gap >= 0, "Columns: Gap must be a non-negative finite number")

		self._isOneToOne = #self._ratio == 2 and self._ratio[1] == self._ratio[2]

		-- Container frame — children are positioned manually by _updateHeight
		self.Container = U.Create("Frame", {
			Name = "Columns",
			Size = UDim2.new(1, 0, 0, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Parent = parent,
		})

		-- Re-layout when container width changes (responsive, resize, minimize restore)
		self._containerSizing = self.Container:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			if not self._destroyed then
				self:_updateHeight()
			end
		end)

		-- Create column children
		self._columns = {}
		self._nextColumn = 1
		for i = 1, #self._ratio do
			local col = Column.new(self, i, theme, menuRef)
			table.insert(self._columns, col)
			table.insert(self.Components, col)
		end

		-- Initial layout
		task.spawn(function()
			if not self._destroyed then
				self:_updateHeight()
			end
		end)

		return self
	end

	function Columns:_isCompact()
		if not self._stackCompact then
			return false
		end
		if self._menu and self._menu._compact ~= nil then
			return self._menu._compact
		end
		-- Derive from menu compact breakpoint if available
		if self._menu and self._menu.CompactBreakpoint then
			local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
			if viewport.X <= self._menu.CompactBreakpoint then
				return true
			end
		end
		-- Fallback: check parent container absolute width
		if self.Container then
			local w = self.Container.AbsoluteSize.X
			if w > 0 and w < 400 then
				return true
			end
		end
		return false
	end

	function Columns:_updateHeight()
		if self._destroyed or self._updating then
			return
		end
		self._updating = true

		local compact = self:_isCompact()
		local numCols = #self._columns
		local containerW = self.Container.AbsoluteSize.X

		-- Collect column content heights
		local colHeights = {}
		local maxH = 0
		local sumH = 0
		for i, col in ipairs(self._columns) do
			local h = col:_contentHeight()
			colHeights[i] = h
			if h > maxH then
				maxH = h
			end
			sumH = sumH + h
		end

		if compact and numCols > 0 then
			-- Compact: stack vertically in creation order, full width
			local y = 0
			for i = 1, numCols do
				local h = colHeights[i]
				local col = self._columns[i]
				col.Content.Size = UDim2.new(1, 0, 0, h)
				col.Content.Position = UDim2.fromOffset(0, y)
				if i < numCols then
					y = y + h + self._gap
				end
			end
			self.Container.Size = UDim2.new(1, 0, 0, sumH + math.max(0, numCols - 1) * self._gap)
		elseif numCols > 0 then
			-- Desktop: side by side, each column height = max content height
			local totalRatio = 0
			for _, r in ipairs(self._ratio) do
				totalRatio = totalRatio + r
			end
			local availableW = math.max(0, containerW - self._gap * (numCols - 1))
			local x = 0
			for i = 1, numCols do
				local w = math.floor(availableW * self._ratio[i] / totalRatio)
				local col = self._columns[i]
				col.Content.Size = UDim2.fromOffset(w, maxH)
				col.Content.Position = UDim2.fromOffset(math.floor(x), 0)
				if i < numCols then
					x = x + w + self._gap
				end
			end
			self.Container.Size = UDim2.new(1, 0, 0, maxH)
		end

		self._updating = false

		-- Notify parent Collapsible to recalculate its own size
		if self._parentUpdate then
			self._parentUpdate()
		end
	end

	-- Sequential column accessor: first call returns column 1, then 2, etc.
	function Columns:Column(idx)
		if self._destroyed then
			return nil, "destroyed"
		end
		if idx ~= nil then
			return self._columns[idx]
		end
		local col = self._columns[self._nextColumn]
		if col then
			self._nextColumn = self._nextColumn + 1
		end
		return col
	end

	function Columns:Destroy()
		if self._destroyed then
			return
		end
		self._destroyed = true
		if self._containerSizing then
			self._containerSizing:Disconnect()
			self._containerSizing = nil
		end
		for _, col in ipairs(self._columns) do
			col:Destroy()
		end
		self._columns = {}
		self.Components = {}
		if self.Container then
			self.Container:Destroy()
		end
	end

	function Columns:ApplyTheme(theme)
		self.Theme = theme
		if not self.Container then
			return
		end
		for _, col in ipairs(self._columns) do
			col:ApplyTheme(theme)
		end
	end
	--[[ Collapsible Section ]]
	Collapsible = {}
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
		U.Create(
			"UIStroke",
			{ Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = self.Container }
		)

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
		-- Lucide chevron (far right, Active=false so clicks pass through Header)
		self.Arrow = renderIcon(self.Header, self._isOpen and "chevron-down" or "chevron-right", {
			Name = "Arrow",
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.new(1, -24, 0.5, -8),
			BackgroundTransparency = 1,
			ImageColor3 = theme.TextSecondary,
			TextColor3 = theme.TextSecondary,
			Active = false,
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
		-- NOTE: Children already have their own 6px outer inset (width 1,-12 + position 6).
		-- Content only provides deliberate top/bottom gaps; no left/right UIPadding.
		self.Content = U.Create("Frame", {
			Name = "Content",
			Size = UDim2.new(1, 0, 0, 0),
			Position = UDim2.fromOffset(0, 34),
			BackgroundTransparency = 1,
			Visible = self._isOpen,
			Parent = self.Container,
		})
		local layout = U.Create("UIListLayout", {
			Padding = UDim.new(0, theme.Spacing),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = self.Content,
		})
		local contentPadding = U.Create("UIPadding", {
			PaddingTop = UDim.new(0, 6),
			PaddingBottom = UDim.new(0, 6),
			Parent = self.Content,
		})
		self._layout = layout
		self._contentPadding = contentPadding

		-- Resize when content changes
		self._layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			if not self._closed then
				self:_updateSize()
			end
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
			if not self._closed then
				self:_updateSize(true)
			end
		end)

		return self
	end

	function Collapsible:_contentHeight()
		local layoutHeight = self._layout and self._layout.AbsoluteContentSize.Y or 0
		local paddingTop = self._contentPadding and self._contentPadding.PaddingTop.Offset or 0
		local paddingBottom = self._contentPadding and self._contentPadding.PaddingBottom.Offset or 0
		return layoutHeight + paddingTop + paddingBottom
	end

	function Collapsible:SetOpen(v)
		if self._destroyed then
			return false, "destroyed"
		end
		if type(v) ~= "boolean" then
			return false, "expected boolean"
		end
		if self._isOpen == v then
			return true
		end
		self._isOpen = v
		local transitionId = (self._transitionId or 0) + 1
		self._transitionId = transitionId
		if self.Arrow then
			self.Arrow = updateRenderedIcon(self.Arrow, v and "chevron-down" or "chevron-right", self.Header, {
				Name = "Arrow",
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.new(1, -24, 0.5, -8),
				BackgroundTransparency = 1,
				ImageColor3 = self.Theme.TextSecondary,
				TextColor3 = self.Theme.TextSecondary,
				Active = false,
			})
		end
		if self._tween then
			self._tween:Cancel()
		end
		if not self.Container then
			return false, "missing container"
		end
		if v and self.Content then
			self.Content.Visible = true
		end
		local contentHeight = self:_contentHeight()
		if self.Content then
			self.Content.Size = UDim2.new(1, 0, 0, contentHeight)
		end
		local targetH = v and (34 + contentHeight) or 34
		local function finishTransition()
			if self._transitionId == transitionId and not self._isOpen and self.Content then
				self.Content.Visible = false
			end
		end
		if self._menu then
			self._tween = self._menu:_transition(
				self.Container,
				0.25,
				{ Size = UDim2.new(1, -12, 0, targetH) },
				nil,
				nil,
				finishTransition
			)
		else
			self._tween = game:GetService("TweenService"):Create(
				self.Container,
				TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ Size = UDim2.new(1, -12, 0, targetH) }
			)
			self._tween.Completed:Connect(finishTransition)
			self._tween:Play()
		end
		return true
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
		if self._closed or not self._layout or not self.Container or not self.Container.Parent then
			return
		end
		if self._tween then
			self._tween:Cancel()
		end
		local contentHeight = self:_contentHeight()
		if self.Content then
			self.Content.Size = UDim2.new(1, 0, 0, contentHeight)
		end
		local targetH = self._isOpen and (34 + contentHeight) or 34
		if instant then
			self.Container.Size = UDim2.new(1, -12, 0, targetH)
		else
			if self._menu then
				self._tween = self._menu:_transition(self.Container, 0.15, { Size = UDim2.new(1, -12, 0, targetH) })
			else
				self._tween = game:GetService("TweenService"):Create(
					self.Container,
					TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{ Size = UDim2.new(1, -12, 0, targetH) }
				)
				self._tween:Play()
			end
		end
	end

	-- Pass-through methods (all default opts to {}; Tooltip auto-bound via self._menu)
	function Collapsible:Toggle(opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		local c = Toggle.new(self.Content, opts, self.Theme)
		table.insert(self.Components, c)
		if c.Flag and self._menu then
			self._menu:_trackFlagged(c)
		end
		if opts.Tooltip and self._menu then
			self._menu:BindTooltip(c.Container, opts.Tooltip)
		end
		self:_updateSize()
		return c
	end
	function Collapsible:Checkbox(opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		local c = Checkbox.new(self.Content, opts, self.Theme)
		table.insert(self.Components, c)
		if c.Flag and self._menu then
			self._menu:_trackFlagged(c)
		end
		if opts.Tooltip and self._menu then
			self._menu:BindTooltip(c.Container, opts.Tooltip)
		end
		self:_updateSize()
		return c
	end
	function Collapsible:Slider(opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		if self._inOneToOne then
			local clo = {}
			for k, v in pairs(opts) do
				clo[k] = v
			end
			clo._inOneToOneColumn = true
			opts = clo
		end
		local c = Slider.new(self.Content, opts, self.Theme)
		table.insert(self.Components, c)
		if c.Flag and self._menu then
			self._menu:_trackFlagged(c)
		end
		if opts.Tooltip and self._menu then
			self._menu:BindTooltip(c.Container, opts.Tooltip)
		end
		self:_updateSize()
		return c
	end
	function Collapsible:Dropdown(opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		local dropdownOpts = {}
		for k, v in pairs(opts) do
			dropdownOpts[k] = v
		end
		dropdownOpts._compactControl = true
		local c = Dropdown.new(self.Content, dropdownOpts, self.Theme, self._menu or nil)
		table.insert(self.Components, c)
		if c.Flag and self._menu then
			self._menu:_trackFlagged(c)
		end
		if opts.Tooltip and self._menu then
			self._menu:BindTooltip(c.Container, opts.Tooltip)
		end
		self:_updateSize()
		return c
	end
	function Collapsible:Keybind(opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		local c = Keybind.new(self.Content, opts, self.Theme, self._menu or nil)
		table.insert(self.Components, c)
		if c.Flag and self._menu then
			self._menu:_trackFlagged(c)
		end
		if opts.Tooltip and self._menu then
			self._menu:BindTooltip(c.Container, opts.Tooltip)
		end
		self:_updateSize()
		return c
	end
	function Collapsible:Input(opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		local c = TextInput.new(self.Content, opts, self.Theme)
		table.insert(self.Components, c)
		if c.Flag and self._menu then
			self._menu:_trackFlagged(c)
		end
		if opts.Tooltip and self._menu then
			self._menu:BindTooltip(c.Container, opts.Tooltip)
		end
		self:_updateSize()
		return c
	end
	function Collapsible:Button(opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		local theme = self.Theme
		local hasDesc = opts.Description ~= nil and opts.Description ~= ""
		local h = hasDesc and theme.DescHeight or theme.ElementHeight
		local btn = {}
		btn.Container = U.Create("ImageButton", {
			Name = "Button",
			Size = UDim2.new(1, -12, 0, h + 6),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0,
			AutoButtonColor = false,
			BorderSizePixel = 0,
			Parent = self.Content,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = btn.Container })
		U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = btn.Container })
		renderIcon(btn.Container, opts.Icon or "rocket", {
			Name = "Pointer",
			Size = UDim2.fromOffset(26, 26),
			Position = UDim2.new(1, -38, 0.5, -13),
			ImageTransparency = 0.5,
		})
		local ix = 10
		if hasDesc then
			U.Create("TextLabel", {
				Name = "Text",
				Size = UDim2.new(1, -20, 0, 20),
				Position = UDim2.fromOffset(ix, 5),
				BackgroundTransparency = 1,
				Text = opts.Text or "Button",
				Font = theme.Font,
				TextSize = theme.FontSize,
				TextColor3 = opts.Color or theme.TextPrimary,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = btn.Container,
			})
			U.Create("TextLabel", {
				Name = "Description",
				Size = UDim2.new(1, -20, 0, 16),
				Position = UDim2.fromOffset(ix, 27),
				BackgroundTransparency = 1,
				Text = opts.Description,
				Font = theme.Font,
				TextSize = theme.FontSizeSmall,
				TextColor3 = theme.TextMuted,
				TextXAlignment = Enum.TextXAlignment.Left,
				RichText = true,
				Parent = btn.Container,
			})
		else
			U.Create("TextLabel", {
				Name = "Text",
				Size = UDim2.new(1, -20, 0, 20),
				Position = UDim2.fromOffset(ix, (h + 6 - 20) / 2 + 1),
				BackgroundTransparency = 1,
				Text = opts.Text or "Button",
				Font = theme.Font,
				TextSize = theme.FontSize,
				TextColor3 = opts.Color or theme.TextPrimary,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = btn.Container,
			})
		end
		local _sc = U.Create("UIScale", { Parent = btn.Container })
		btn.Container.MouseEnter:Connect(function()
			btn.Container.BackgroundColor3 = theme.ElementHover
			btn.Container.BackgroundTransparency = 0
		end)
		btn.Container.MouseLeave:Connect(function()
			btn.Container.BackgroundColor3 = theme.Element
			btn.Container.BackgroundTransparency = 0
		end)
		btn.Container.MouseButton1Down:Connect(function()
			game:GetService("TweenService"):Create(_sc, TweenInfo.new(0.05), { Scale = 0.97 }):Play()
		end)
		btn.Container.MouseButton1Up:Connect(function()
			game:GetService("TweenService"):Create(_sc, TweenInfo.new(0.08), { Scale = 1 }):Play()
		end)
		btn.Container.MouseButton1Click:Connect(function()
			if opts.Callback then
				opts.Callback()
			end
		end)
		btn.Destroy = function()
			if btn.Container then
				btn.Container:Destroy()
			end
		end
		local _btnColor = opts.Color
		btn.ApplyTheme = function(_, t)
			t = t or _
			if not btn.Container then
				return
			end
			btn.Container.BackgroundColor3 = t.Element
			local s = btn.Container:FindFirstChildOfClass("UIStroke")
			if s then
				s.Color = t.ElementBorder
			end
			local txt = btn.Container:FindFirstChild("Text")
			if txt then
				txt.Font = t.Font
				txt.TextSize = t.FontSize
				txt.TextColor3 = _btnColor or t.TextPrimary
			end
			local d = btn.Container:FindFirstChild("Description")
			if d then
				d.Font = t.Font
				d.TextSize = t.FontSizeSmall
				d.TextColor3 = t.TextMuted
			end
		end
		if opts.Tooltip and self._menu then
			self._menu:BindTooltip(btn.Container, opts.Tooltip)
		end
		table.insert(self.Components, btn)
		self:_updateSize()
		return btn
	end
	function Collapsible:Label(opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		local theme = self.Theme
		local hasDesc = opts.Description ~= nil and opts.Description ~= ""
		local h = hasDesc and theme.DescHeight or theme.ElementHeight
		local lbl = {}
		local _lblColor = opts.Color
		local _lblTextSize = opts.TextSize or theme.FontSize
		lbl.Container = U.Create(
			"Frame",
			{ Name = "Label", Size = UDim2.new(1, 0, 0, h), BackgroundTransparency = 1, Parent = self.Content }
		)
		lbl.TextLabel = U.Create("TextLabel", {
			Name = "Text",
			Size = UDim2.new(1, 0, 0, hasDesc and 20 or h),
			Position = UDim2.fromOffset(0, hasDesc and 2 or (h - 20) / 2 + 1),
			BackgroundTransparency = 1,
			Text = opts.Text or "",
			Font = theme.Font,
			TextSize = _lblTextSize,
			TextColor3 = _lblColor or theme.TextSecondary,
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
				Text = opts.Description,
				Font = theme.Font,
				TextSize = theme.FontSizeSmall,
				TextColor3 = theme.TextMuted,
				TextXAlignment = Enum.TextXAlignment.Left,
				RichText = true,
				Parent = lbl.Container,
			})
		end
		lbl.Destroy = function()
			if lbl.Container then
				lbl.Container:Destroy()
			end
		end
		lbl.ApplyTheme = function(_, t)
			t = t or _
			if not lbl.TextLabel then
				return
			end
			lbl.TextLabel.Font = t.Font
			lbl.TextLabel.TextSize = _lblTextSize
			lbl.TextLabel.TextColor3 = _lblColor or t.TextSecondary
			local d = lbl.Container:FindFirstChild("Description")
			if d then
				d.Font = t.Font
				d.TextSize = t.FontSizeSmall
				d.TextColor3 = t.TextMuted
			end
		end
		table.insert(self.Components, lbl)
		self:_updateSize()
		return lbl
	end
	function Collapsible:BoldLabel(opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		local theme = self.Theme
		local hasDesc = opts.Description ~= nil and opts.Description ~= ""
		local h = hasDesc and theme.DescHeight or theme.ElementHeight
		local lbl = {}
		local _blblColor = opts.Color
		local _blblTextSize = opts.TextSize or theme.FontSizeTitle
		lbl.Container = U.Create(
			"Frame",
			{ Name = "BoldLabel", Size = UDim2.new(1, 0, 0, h), BackgroundTransparency = 1, Parent = self.Content }
		)
		lbl.TextLabel = U.Create("TextLabel", {
			Name = "Text",
			Size = UDim2.new(1, 0, 0, hasDesc and 22 or h),
			Position = UDim2.fromOffset(0, hasDesc and 2 or (h - 22) / 2 + 1),
			BackgroundTransparency = 1,
			Text = opts.Text or "",
			Font = theme.FontBold,
			TextSize = _blblTextSize,
			TextColor3 = _blblColor or theme.TextPrimary,
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
				Text = opts.Description,
				Font = theme.Font,
				TextSize = theme.FontSizeSmall,
				TextColor3 = theme.TextMuted,
				TextXAlignment = Enum.TextXAlignment.Left,
				RichText = true,
				Parent = lbl.Container,
			})
		end
		lbl.Destroy = function()
			if lbl.Container then
				lbl.Container:Destroy()
			end
		end
		lbl.ApplyTheme = function(_, t)
			t = t or _
			if not lbl.TextLabel then
				return
			end
			lbl.TextLabel.Font = t.FontBold
			lbl.TextLabel.TextSize = _blblTextSize
			lbl.TextLabel.TextColor3 = _blblColor or t.TextPrimary
			local d = lbl.Container:FindFirstChild("Description")
			if d then
				d.Font = t.Font
				d.TextSize = t.FontSizeSmall
				d.TextColor3 = t.TextMuted
			end
		end
		table.insert(self.Components, lbl)
		self:_updateSize()
		return lbl
	end
	function Collapsible:Divider()
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		local div = {}
		div.Container = U.Create("Frame", {
			Name = "Divider",
			Size = UDim2.new(1, -20, 0, 1),
			Position = UDim2.fromOffset(10, 0),
			BackgroundColor3 = self.Theme.Border,
			BackgroundTransparency = 0.5,
			BorderSizePixel = 0,
			Parent = self.Content,
		})
		div.ApplyTheme = function(_, t)
			t = t or _
			if div.Container then
				div.Container.BackgroundColor3 = t.Border
			end
		end
		table.insert(self.Components, div)
		self:_updateSize()
		return div
	end
	function Collapsible:Columns(opts)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		opts = opts or {}
		local c = Columns.new(self.Content, opts, self.Theme, self._menu, function()
			self:_updateSize()
		end)
		table.insert(self.Components, c)
		return c
	end
	function Collapsible:Destroy()
		if self._destroyed then
			return
		end
		self._destroyed = true
		self._closed = true
		if self._tween then
			self._tween:Cancel()
		end
		for _, c in ipairs(self.Components) do
			if c.Destroy then
				c:Destroy()
			end
		end
		self.Components = {}
		if self.Container then
			self.Container:Destroy()
		end
	end

	function Collapsible:ApplyTheme(theme)
		self.Theme = theme
		if not self.Container then
			return
		end
		self.Container.BackgroundColor3 = theme.Element
		local stroke = self.Container:FindFirstChildOfClass("UIStroke")
		if stroke then
			stroke.Color = theme.ElementBorder
		end
		self.Header.BackgroundColor3 = theme.ElementHover
		if self.Arrow then
			if self.Arrow:IsA("ImageLabel") then
				self.Arrow.ImageColor3 = theme.TextSecondary
			end
			if self.Arrow:IsA("TextLabel") then
				self.Arrow.TextColor3 = theme.TextSecondary
			end
		end
		self.Title.Font = theme.FontBold
		self.Title.TextSize = theme.FontSize
		self.Title.TextColor3 = theme.TextPrimary
		if self._layout then
			self._layout.Padding = UDim.new(0, theme.Spacing)
		end
		for _, c in ipairs(self.Components) do
			if c.ApplyTheme then
				c:ApplyTheme(theme)
			end
		end
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
		menu:_makeSelectable(self.TabButton)
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
		-- Icon (optional, uses renderIcon for image or emoji/text fallback)
		local _tabIcon = renderIcon(self.TabButton, options.Icon, {
			Size = UDim2.fromOffset(18, 18),
			Position = UDim2.fromOffset(14, 10),
		})
		local textX = _tabIcon and 40 or 18
		local textW = _tabIcon and -44 or -22
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
			Size = UDim2.new(1, -12, 1, -12),
			Position = UDim2.fromOffset(6, 6),
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
		local contentPadding = U.Create("UIPadding", {
			PaddingTop = UDim.new(0, 6),
			PaddingBottom = UDim.new(0, 12),
			Parent = self.Container,
		})
		local listLayout = U.Create("UIListLayout", {
			Padding = UDim.new(0, theme.Spacing),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = self.Container,
		})
		listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			if self.Container then
				self.Container.CanvasSize = UDim2.new(
					0,
					0,
					0,
					listLayout.AbsoluteContentSize.Y
						+ contentPadding.PaddingTop.Offset
						+ contentPadding.PaddingBottom.Offset
				)
			end
		end)

		self.TabButton.Activated:Connect(function()
			menu:SelectTab(self)
		end)
		self.TabButton.SelectionGained:Connect(function()
			if menu:_selectionIsAvailable() then
				menu:SelectTab(self)
			end
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
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		options = options or {}
		local toggle = Toggle.new(self.Container, options, self.Theme)
		table.insert(self.Components, toggle)
		self.Menu:_makeSelectable(toggle.Track)
		if toggle.Flag then
			self.Menu:_trackFlagged(toggle)
		end
		if options.Tooltip and self.Menu then
			self.Menu:BindTooltip(toggle.Container, options.Tooltip)
		end
		return toggle
	end

	function Tab:Button(options)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		options = options or {}
		local theme = self.Theme
		local hasDesc = options.Description ~= nil and options.Description ~= ""
		local h = hasDesc and theme.DescHeight or theme.ElementHeight
		local btn = {}
		local _btnTextColor = options.Color

		btn.Container = U.Create("ImageButton", {
			Name = "Button",
			Size = UDim2.new(1, -12, 0, h + 6),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = theme.Element,
			BackgroundTransparency = 0,
			AutoButtonColor = false,
			BorderSizePixel = 0,
			Parent = self.Container,
		})
		self.Menu:_makeSelectable(btn.Container)
		U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = btn.Container })
		U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = btn.Container })

		-- Right-side icon (default: rocket, customizable via Icon option)
		renderIcon(btn.Container, options.Icon or "rocket", {
			Name = "Pointer",
			Size = UDim2.fromOffset(26, 26),
			Position = UDim2.new(1, -38, 0.5, -13),
			ImageTransparency = 0.5,
		})
		local btnIconX = 10
		local btnIconW = -54

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
				Position = UDim2.fromOffset(btnIconX, (h + 6 - 20) / 2 + 1),
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
			if btn._scaleTween then
				btn._scaleTween:Cancel()
			end
			btn.Container.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
			btn._scaleTween = game:GetService("TweenService"):Create(
				_scale,
				TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ Scale = 0.97 }
			)
			btn._scaleTween:Play()
		end)
		btn.Container.MouseButton1Up:Connect(function()
			if btn._scaleTween then
				btn._scaleTween:Cancel()
			end
			btn.Container.BackgroundColor3 = theme.ElementHover
			btn._scaleTween =
				game:GetService("TweenService")
					:Create(_scale, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = 1 })
			btn._scaleTween:Play()
		end)
		btn.Container.MouseButton1Click:Connect(function()
			if options.Callback then
				options.Callback()
			end
		end)
		btn.SetText = function(text)
			local t = btn.Container:FindFirstChild("Text")
			if t then
				t.Text = text
			end
		end
		btn.SetCallback = function(cb)
			options.Callback = cb
		end
		btn.Destroy = function()
			if btn.Container then
				btn.Container:Destroy()
			end
		end
		btn.ApplyTheme = function(_, t)
			t = t or _
			if not btn.Container then
				return
			end
			btn.Container.BackgroundColor3 = t.Element
			local stroke = btn.Container:FindFirstChildOfClass("UIStroke")
			if stroke then
				stroke.Color = t.ElementBorder
			end
			local txt = btn.Container:FindFirstChild("Text")
			if txt then
				txt.Font = t.Font
				txt.TextSize = t.FontSize
				txt.TextColor3 = _btnTextColor or t.TextPrimary
			end
			local desc = btn.Container:FindFirstChild("Description")
			if desc then
				desc.Font = t.Font
				desc.TextSize = t.FontSizeSmall
				desc.TextColor3 = t.TextMuted
			end
		end

		if options.Tooltip and self.Menu then
			self.Menu:BindTooltip(btn.Container, options.Tooltip)
		end
		table.insert(self.Components, btn)
		return btn
	end

	function Tab:Label(options)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
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

		lbl.SetText = function(text)
			lbl.TextLabel.Text = text
		end
		lbl.SetColor = function(c)
			lbl.TextLabel.TextColor3 = c
		end
		lbl.Destroy = function()
			if lbl.Container then
				lbl.Container:Destroy()
			end
		end
		lbl.ApplyTheme = function(_, t)
			t = t or _
			if not lbl.TextLabel then
				return
			end
			lbl.TextLabel.Font = t.Font
			lbl.TextLabel.TextSize = _labelTextSize
			lbl.TextLabel.TextColor3 = _labelColor or t.TextSecondary
			local d = lbl.Container:FindFirstChild("Description")
			if d then
				d.Font = t.Font
				d.TextSize = t.FontSizeSmall
				d.TextColor3 = t.TextMuted
			end
		end

		table.insert(self.Components, lbl)
		return lbl
	end

	function Tab:BoldLabel(options)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
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

		lbl.SetText = function(text)
			lbl.TextLabel.Text = text
		end
		lbl.SetColor = function(c)
			lbl.TextLabel.TextColor3 = c
		end
		lbl.Destroy = function()
			if lbl.Container then
				lbl.Container:Destroy()
			end
		end
		lbl.ApplyTheme = function(_, t)
			t = t or _
			if not lbl.TextLabel then
				return
			end
			lbl.TextLabel.Font = t.FontBold
			lbl.TextLabel.TextSize = _blTextSize
			lbl.TextLabel.TextColor3 = _blColor or t.TextPrimary
			local d = lbl.Container:FindFirstChild("Description")
			if d then
				d.Font = t.Font
				d.TextSize = t.FontSizeSmall
				d.TextColor3 = t.TextMuted
			end
		end

		table.insert(self.Components, lbl)
		return lbl
	end

	function Tab:Divider()
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
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
		div.Destroy = function()
			if div.Container then
				div.Container:Destroy()
			end
		end
		div.ApplyTheme = function(_, t)
			t = t or _
			local line = div.Container:FindFirstChild("Line")
			if line then
				line.BackgroundColor3 = t.Border
			end
		end
		table.insert(self.Components, div)
		return div
	end

	function Tab:Slider(options)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		options = options or {}
		local slider = Slider.new(self.Container, options, self.Theme)
		table.insert(self.Components, slider)
		if slider.Flag then
			self.Menu:_trackFlagged(slider)
		end
		if options.Tooltip and self.Menu then
			self.Menu:BindTooltip(slider.Container, options.Tooltip)
		end
		return slider
	end

	function Tab:Dropdown(options)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		options = options or {}
		local dd = Dropdown.new(self.Container, options, self.Theme, self.Menu)
		table.insert(self.Components, dd)
		if dd.Flag then
			self.Menu:_trackFlagged(dd)
		end
		if options.Tooltip and self.Menu then
			self.Menu:BindTooltip(dd.Container, options.Tooltip)
		end
		return dd
	end

	function Tab:Keybind(options)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		options = options or {}
		local kb = Keybind.new(self.Container, options, self.Theme, self.Menu)
		table.insert(self.Components, kb)
		if kb.Flag then
			self.Menu:_trackFlagged(kb)
		end
		if options.Tooltip and self.Menu then
			self.Menu:BindTooltip(kb.Container, options.Tooltip)
		end
		return kb
	end

	function Tab:Input(options)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		options = options or {}
		local ti = TextInput.new(self.Container, options, self.Theme)
		table.insert(self.Components, ti)
		if ti.Flag then
			self.Menu:_trackFlagged(ti)
		end
		if options.Tooltip and self.Menu then
			self.Menu:BindTooltip(ti.Container, options.Tooltip)
		end
		return ti
	end

	--[[ Tab methods ]]
	function Tab:Checkbox(options)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		options = options or {}
		local c = Checkbox.new(self.Container, options, self.Theme)
		table.insert(self.Components, c)
		self.Menu:_makeSelectable(c.Container)
		if c.Flag then
			self.Menu:_trackFlagged(c)
		end
		if options.Tooltip and self.Menu then
			self.Menu:BindTooltip(c.Container, options.Tooltip)
		end
		return c
	end
	function Tab:Collapsible(title, options)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		local c = Collapsible.new(self.Container, title, options, self.Theme)
		c._menu = self.Menu
		table.insert(self.Components, c)
		return c
	end
	function Tab:Columns(options)
		if destroyedFactoryResult(self) then
			return nil, "destroyed"
		end
		local c = Columns.new(self.Container, options or {}, self.Theme, self.Menu)
		table.insert(self.Components, c)
		return c
	end
	function Tab:Destroy()
		if self._destroyed then
			return
		end
		self._destroyed = true
		if self.Menu and not self.Menu._destroyed then
			local removedIndex
			for i, tab in ipairs(self.Menu.Tabs) do
				if tab == self then
					removedIndex = i
					table.remove(self.Menu.Tabs, i)
					break
				end
			end
			if self.Menu.ActiveTab == self then
				local replacement = removedIndex and self.Menu.Tabs[math.min(removedIndex, #self.Menu.Tabs)] or nil
				if replacement then
					self.Menu:SelectTab(replacement)
				else
					self.Menu.ActiveTab = nil
					if self.Menu.ActiveBar then
						self.Menu.ActiveBar.BackgroundTransparency = 1
					end
				end
			elseif self.Menu.ActiveTab and self.Menu.ActiveBar then
				self.Menu:_positionActiveBar(self.Menu.ActiveTab, false)
			end
		end
		for _, c in ipairs(self.Components) do
			if c.Destroy then
				c:Destroy()
			end
		end
		self.Components = {}
		if self.Container then
			self.Container:Destroy()
		end
		if self.TabButton then
			self.TabButton:Destroy()
		end
	end

	function Tab:ApplyTheme(theme)
		self.Theme = theme
		if not self.TabButton then
			return
		end
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
			if layout then
				layout.Padding = UDim.new(0, theme.Spacing)
			end
		end
		-- Push to every child component
		for _, c in ipairs(self.Components) do
			if c.ApplyTheme then
				c:ApplyTheme(theme)
			end
		end
		-- Re-apply active/inactive styling
		if self.Menu and self.Menu.ActiveTab == self then
			self.TabButton.BackgroundTransparency = 0
			self.TabButton.BackgroundColor3 = theme.TabActive
			if self._glow then
				self._glow.BackgroundTransparency = 0.85
			end
			if lbl then
				lbl.TextColor3 = theme.SidebarTextActive
			end
		else
			self.TabButton.BackgroundTransparency = 1
			if lbl then
				lbl.TextColor3 = theme.SidebarText
			end
		end
	end
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
			isFiniteNumber(self.MinSize.X)
				and isFiniteNumber(self.MinSize.Y)
				and self.MinSize.X > 0
				and self.MinSize.Y > 0,
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
				self._shadow.Position =
					UDim2.fromOffset(self.Frame.Position.X.Offset - 8, self.Frame.Position.Y.Offset - 8)
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
				if
					i.UserInputType == Enum.UserInputType.MouseButton1
					or i.UserInputType == Enum.UserInputType.Touch
				then
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
				if
					i.UserInputType == Enum.UserInputType.MouseButton1
					or i.UserInputType == Enum.UserInputType.Touch
				then
					dragging = false
					if not didDrag then
						self:_restore()
					end
				end
			end)
			self._minDragInputCon = game:GetService("UserInputService").InputChanged:Connect(function(i)
				if
					dragging
					and (
						i.UserInputType == Enum.UserInputType.MouseMovement
						or i.UserInputType == Enum.UserInputType.Touch
					)
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
				if
					i.UserInputType == Enum.UserInputType.MouseButton1
					or i.UserInputType == Enum.UserInputType.Touch
				then
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
				if
					i.UserInputType == Enum.UserInputType.MouseButton1
					or i.UserInputType == Enum.UserInputType.Touch
				then
					nlDragging = false
					if not nlDidDrag then
						self:_restore()
					end
				end
			end)
			self._noLogoDragCon = game:GetService("UserInputService").InputChanged:Connect(function(i)
				if
					nlDragging
					and (
						i.UserInputType == Enum.UserInputType.MouseMovement
						or i.UserInputType == Enum.UserInputType.Touch
					)
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
	function Menu:_positionActiveBar(tab, animate)
		if not tab or not self.ActiveBar then
			return
		end
		local tabIdx = 0
		for i, candidate in ipairs(self.Tabs) do
			if candidate == tab then
				tabIdx = i
				break
			end
		end
		if tabIdx == 0 then
			return
		end

		if self._activeBarTween then
			self._activeBarTween:Cancel()
			self._activeBarTween = nil
		end

		local scrollY = self.SidebarList and self.SidebarList.CanvasPosition.Y or 0
		local position = UDim2.fromOffset(5, (tabIdx - 1) * 40 + 9 - scrollY)
		self.ActiveBar.BackgroundTransparency = 0
		if animate then
			local tween = self:_transition(self.ActiveBar, 0.22, { Position = position })
			self._activeBarTween = tween
			if tween then
				tween.Completed:Connect(function()
					if self._activeBarTween == tween then
						self._activeBarTween = nil
					end
				end)
			else
				self._activeBarTween = nil
			end
		else
			self.ActiveBar.Position = position
		end
	end

	function Menu:SelectTab(tab)
		if self.ActiveTab == tab then
			return
		end
		self:HideDropdownPopup()
		local offsetY = 36

		-- Hide old tab content immediately (no glitchy slide-out)
		local hadPrevTab = self.ActiveTab ~= nil
		if self.ActiveTab then
			local old = self.ActiveTab
			old.Container.Visible = false
			old.Container.Position = UDim2.fromOffset(6, 6) -- reset
			old.TabButton.BackgroundTransparency = 1
			if old._glow then
				old._glow.BackgroundTransparency = 1
			end
			local lbl = old.TabButton:FindFirstChild("Label")
			if lbl then
				lbl.TextColor3 = self.Theme.SidebarText
			end
		end

		self.ActiveTab = tab
		if tab then
			-- New tab slides in from below
			tab.Container.Position = UDim2.fromOffset(6, offsetY)
			tab.Container.Visible = true
			self:_transition(tab.Container, 0.22, { Position = UDim2.fromOffset(6, 6) })

			self:_positionActiveBar(tab, hadPrevTab)

			-- Tab button visual
			tab.TabButton.BackgroundTransparency = 0
			tab.TabButton.BackgroundColor3 = self.Theme.TabActive
			if tab._glow then
				tab._glow.BackgroundTransparency = 0.85
			end
			local lbl = tab.TabButton:FindFirstChild("Label")
			if lbl then
				lbl.TextColor3 = self.Theme.SidebarTextActive
			end
		end
	end

	function Menu:ShowDropdownPopup(atPos, atSize, opts, selectedIdx, onClick, isMulti, dd)
		if self._destroyed or not self.Gui or not self.Frame then
			return false, "destroyed"
		end
		if type(opts) ~= "table" then
			return false, "expected options table"
		end
		self:HideDropdownPopup()
		self._popupFocusReturn = self:_beginTransientFocus(dd and dd.SelectBtn)
		self._popupGen = (self._popupGen or 0) + 1 -- bump generation so stale close handlers bail out

		local uis = game:GetService("UserInputService")
		local theme = self.Theme
		local frameAbs = self.Frame.AbsolutePosition
		local frameSiz = self.Frame.AbsoluteSize
		atPos = typeof(atPos) == "Vector2" and atPos or frameAbs
		atSize = typeof(atSize) == "Vector2" and atSize or Vector2.new(0, 0)
		local py = 0
		isMulti = isMulti or false
		dd = dd or self._activeDropdown -- fallback to _activeDropdown if not passed

		-- Determine panel width from the longest option, with room for the
		-- selection mark and comfortable right-side breathing space.
		local viewport = self:_viewportSize()
		local textService = game:GetService("TextService")
		local longestOptionWidth = 0
		for _, option in ipairs(opts) do
			local measured =
				textService:GetTextSize(tostring(option), theme.FontSize, theme.Font, Vector2.new(1000, 100)).X
			longestOptionWidth = math.max(longestOptionWidth, measured)
		end
		local PANEL_CHROME = 78
		local MIN_W = 160
		local PREF_W = math.ceil(math.max(MIN_W, longestOptionWidth + PANEL_CHROME))
		local COMFORT_W = math.min(140, PREF_W)
		local USABLE_W = 80 -- absolute minimum; below this the panel has negative/zero inner content
		local rightEdge = frameAbs.X + frameSiz.X
		local rightRoom = viewport.X - rightEdge - 4 -- 4px margin from screen edge
		local leftRoom = frameAbs.X - 4 -- space to the left of the menu
		local w, px
		local modal = false
		if rightRoom >= COMFORT_W then
			-- Right side: comfortable space for full panel
			w = math.min(PREF_W, rightRoom)
			px = frameSiz.X
		elseif rightRoom >= USABLE_W then
			-- Right side constrained but still large enough for valid content
			w = rightRoom
			px = frameSiz.X
		elseif leftRoom >= COMFORT_W then
			-- Right side insufficient → left fallback with comfortable width
			w = math.min(PREF_W, leftRoom)
			px = -w
		elseif leftRoom >= USABLE_W then
			-- Left side constrained but still large enough for valid content
			w = leftRoom
			px = -w
		else
			-- On narrow/mobile viewports, present a centered modal instead of
			-- creating an unusable side panel or leaving the dropdown "open".
			modal = true
			w = math.min(360, math.max(1, viewport.X - self.SafePadding * 2))
			px = 0
		end

		-- Classic desktop side panel fills the complete menu height. Narrow
		-- viewports keep the centered modal behavior and safe viewport padding.
		local OPT_H = math.max(32, self.TouchTargetSize)
		local clampedH = frameSiz.Y
		if modal then
			clampedH = math.max(1, math.min(frameSiz.Y, viewport.Y - self.SafePadding * 2))
		end
		local popupParent = self.Frame
		if modal then
			self._activePopupOverlay = U.Create("ImageButton", {
				Name = "DropdownOverlay",
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 0.48,
				BorderSizePixel = 0,
				AutoButtonColor = false,
				ZIndex = 9999,
				Parent = self.Gui,
			})
			self._activePopupOverlay.MouseButton1Click:Connect(function()
				self:HideDropdownPopup()
			end)
			popupParent = self.Gui
		end

		-- Create popup with 0 width → tween to slide in from right
		local popup = U.Create("Frame", {
			Name = modal and "DropdownModal" or "DropdownPopup",
			Size = UDim2.fromOffset(0, clampedH),
			Position = modal and UDim2.fromScale(0.5, 0.5) or UDim2.fromOffset(px, py),
			AnchorPoint = modal and Vector2.new(0.5, 0.5) or Vector2.new(0, 0),
			BackgroundColor3 = theme.Sidebar,
			BorderSizePixel = 0,
			ZIndex = 10000,
			Parent = popupParent,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = popup })
		U.Create("UIStroke", {
			Color = theme.Border,
			Thickness = 1,
			Transparency = 0.25,
			Parent = popup,
		})
		-- Content wrapper (avoids SideLine interfering with children)
		local content = U.Create("Frame", {
			Name = "Content",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 10001,
			Parent = popup,
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
			Visible = not modal,
			Parent = popup,
		})

		local firstOptionButton
		if #opts > 0 then
			-- ScrollingFrame for option list (content-aware)
			local optionList = U.Create("ScrollingFrame", {
				Name = "OptionList",
				Size = UDim2.new(1, -16, 1, -16),
				Position = UDim2.fromOffset(8, 8),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ScrollBarThickness = 3,
				ScrollBarImageColor3 = theme.ScrollBar,
				CanvasSize = UDim2.fromOffset(0, (#opts * OPT_H) + math.max(0, #opts - 1) * 2),
				ZIndex = 10001,
				Parent = content,
			})
			U.Create("UIListLayout", {
				Padding = UDim.new(0, 2),
				SortOrder = Enum.SortOrder.LayoutOrder,
				Parent = optionList,
			})

			-- Create option buttons with direct dropdown reference
			for i, opt in ipairs(opts) do
				local sel = false
				if isMulti then
					sel = dd and dd._selected[opt] or false
				else
					sel = dd and tostring(opt) == tostring(dd.Value) or false
				end
				local btn = U.Create("TextButton", {
					Name = "Option",
					Size = UDim2.new(1, -6, 0, OPT_H),
					Text = "",
					BackgroundColor3 = sel and theme.Accent or theme.Element,
					BackgroundTransparency = sel and 0.25 or 0.6,
					AutoButtonColor = false,
					ZIndex = 10001,
					Parent = optionList,
				})
				self:_makeSelectable(btn)
				if not firstOptionButton then
					firstOptionButton = btn
				end
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
				btn.Activated:Connect(function()
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
					local curSel = isMulti and (dd and dd._selected[opt])
						or (not isMulti and dd and tostring(opt) == tostring(dd.Value))
					if curSel then
						btn.BackgroundColor3 = theme.Accent
						btn.BackgroundTransparency = 0.25 -- back to normal selected
					else
						btn.BackgroundColor3 = theme.Element
						btn.BackgroundTransparency = 0.6
					end
				end)
			end
		else
			-- Empty-state: centered in the panel area
			U.Create("TextLabel", {
				Name = "EmptyState",
				Size = UDim2.new(1, -12, 1, 0),
				Position = UDim2.fromOffset(6, 0),
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
		self._activePopupModal = modal
		self:_transition(popup, 0.25, { Size = UDim2.fromOffset(w, clampedH) })
		if self._popupFocusReturn and firstOptionButton then
			game:GetService("GuiService").SelectedObject = firstOptionButton
		end

		-- Close on click outside (generation-guarded: stale invocations after a new popup are no-ops)
		local closeGen = self._popupGen
		self._popupUISCon = uis.InputBegan:Connect(function(input, gpe)
			if gpe then
				return
			end
			if
				input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch
			then
				task.wait()
				if closeGen ~= self._popupGen then
					return
				end -- popup was replaced while yielding
				local activePopup = self._activePopupFrame
				if not activePopup then
					return
				end
				local point, popupPos, popupSize =
					input.Position, activePopup.AbsolutePosition, activePopup.AbsoluteSize
				local insidePopup = point.X >= popupPos.X
					and point.X <= popupPos.X + popupSize.X
					and point.Y >= popupPos.Y
					and point.Y <= popupPos.Y + popupSize.Y
				if not insidePopup then
					self:HideDropdownPopup()
				end
			end
		end)
		return true
	end

	function Menu:HideDropdownPopup()
		if self._popupUISCon then
			self._popupUISCon:Disconnect()
			self._popupUISCon = nil
		end
		if self._activePopupFrame then
			local popup = self._activePopupFrame
			self._activePopupFrame = nil
			local curSize = popup.Size
			self:_transition(
				popup,
				0.2,
				{ Size = UDim2.fromOffset(0, curSize.Y.Offset) },
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.In,
				function()
					pcall(function()
						popup:Destroy()
					end)
				end
			)
		end
		if self._activePopupOverlay then
			self._activePopupOverlay:Destroy()
			self._activePopupOverlay = nil
		end
		self._activePopupModal = nil
		local focusReturn = self._popupFocusReturn
		self._popupFocusReturn = nil
		self:_restoreTransientFocus(focusReturn)
		if self._activeDropdown then
			self._activeDropdown.Open = false
			if self._activeDropdown._arrow and self._activeDropdown._arrowDown then
				applyIconToLabel(self._activeDropdown._arrow, self._activeDropdown._arrowDown)
			end
			self._activeDropdown = nil
		end
	end

	function Menu:Tab(options)
		if self._destroyed then
			return nil, "destroyed"
		end
		options = options or {}
		return Tab.new(self, options)
	end
	function Menu:_createOverview()
		if not self.StatsConfig.Enabled or self._overviewTab then
			return self._overviewTab
		end
		local theme = self.Theme
		local cfg = self.StatsConfig
		local support = self.SupportConfig
		local tab = Tab.new(self, { Text = cfg.TabName, Icon = cfg.TabIcon, Tooltip = "Account and session overview" })
		self._overviewTab = tab
		tab._isOverview = true
		local root = tab.Container
		root.Name = "OverviewContent"
		root.ScrollBarThickness = 0
		root.ScrollingEnabled = false
		root.CanvasSize = UDim2.fromOffset(0, 0)
		for _, child in ipairs(root:GetChildren()) do
			if child:IsA("UIListLayout") or child:IsA("UIPadding") then
				child:Destroy()
			end
		end

		local themed = {}
		local textStyles = {}
		local icons = {}
		local overviewConns = {}
		local profileEnabled = cfg.ShowProfile
		local infoEnabled = cfg.ShowGame or cfg.ShowServer
		local supportEnabled = cfg.ShowSupport and (support.Discord or support.Callback)
		local contentTop = 40
		local contentBottom = 276
		local sectionGap = 8
		local profileHeight = profileEnabled and 88 or 0
		local infoHeight = infoEnabled and 76 or 0
		local supportHeight = supportEnabled and 56 or 0
		local totalHeight = profileHeight
			+ infoHeight
			+ supportHeight
			+ (profileEnabled and infoEnabled and sectionGap or 0)
			+ (infoEnabled and supportEnabled and sectionGap or 0)
			+ (profileEnabled and not infoEnabled and supportEnabled and sectionGap or 0)
		local sectionY = contentTop + math.max(0, math.floor((contentBottom - contentTop - totalHeight) / 2))
		local function card(name, position, size, radius)
			local frame = U.Create("Frame", {
				Name = name,
				Position = position,
				Size = size,
				BackgroundColor3 = theme.Element,
				BorderSizePixel = 0,
				Parent = root,
			})
			U.Create("UICorner", { CornerRadius = UDim.new(0, radius or 8), Parent = frame })
			local stroke = U.Create("UIStroke", {
				Color = theme.ElementBorder,
				Transparency = 0.6,
				Thickness = 1,
				Parent = frame,
			})
			table.insert(themed, { kind = "card", frame = frame, stroke = stroke })
			return frame
		end
		local function label(parent, text, position, size, font, textSize, color, colorRole, fontRole)
			local value = U.Create("TextLabel", {
				Position = position,
				Size = size,
				BackgroundTransparency = 1,
				Text = text,
				Font = font,
				TextSize = textSize,
				TextColor3 = color,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextTruncate = Enum.TextTruncate.AtEnd,
				Parent = parent,
			})
			table.insert(textStyles, {
				label = value,
				colorRole = colorRole,
				fontRole = fontRole,
			})
			return value
		end

		label(
			root,
			string.upper(cfg.TabName),
			UDim2.fromOffset(2, 0),
			UDim2.new(1, -4, 0, 20),
			theme.FontBold,
			16,
			theme.TextPrimary,
			"TextPrimary",
			"FontBold"
		)
		label(
			root,
			"Your account and current session",
			UDim2.fromOffset(2, 19),
			UDim2.new(1, -4, 0, 16),
			theme.Font,
			13,
			theme.TextMuted,
			"TextMuted",
			"Font"
		)

		local players = game:GetService("Players")
		local player = players.LocalPlayer
		if cfg.ShowProfile then
			local profile = card("Profile", UDim2.new(0, 0, 0, sectionY), UDim2.new(1, 0, 0, profileHeight), 10)
			local accent = U.Create("Frame", {
				Name = "Accent",
				Position = UDim2.fromOffset(0, 12),
				Size = UDim2.fromOffset(3, 64),
				BackgroundColor3 = theme.Accent,
				BorderSizePixel = 0,
				Parent = profile,
			})
			table.insert(themed, { kind = "accent", frame = accent })
			local avatar = U.Create("ImageLabel", {
				Name = "Avatar",
				Position = UDim2.fromOffset(12, 12),
				Size = UDim2.fromOffset(64, 64),
				BackgroundColor3 = theme.ElementHover,
				BorderSizePixel = 0,
				Parent = profile,
			})
			U.Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = avatar })
			local avatarStroke =
				U.Create("UIStroke", { Color = theme.Accent, Transparency = 0.65, Thickness = 1, Parent = avatar })
			table.insert(themed, { kind = "avatar", frame = avatar, stroke = avatarStroke })
			local displayName = player and player.DisplayName or "Player"
			local userName = player and ("@" .. player.Name) or "@unknown"
			local accountInfo = player and (("%d days · ID %d"):format(player.AccountAge, player.UserId))
				or "Account unavailable"
			label(
				profile,
				displayName,
				UDim2.fromOffset(88, 13),
				UDim2.new(1, -174, 0, 20),
				theme.FontBold,
				16,
				theme.TextPrimary,
				"TextPrimary",
				"FontBold"
			)
			label(
				profile,
				userName,
				UDim2.fromOffset(88, 34),
				UDim2.new(1, -102, 0, 18),
				theme.Font,
				14,
				theme.TextSecondary,
				"TextSecondary",
				"Font"
			)
			label(
				profile,
				accountInfo,
				UDim2.fromOffset(88, 55),
				UDim2.new(1, -102, 0, 16),
				theme.Font,
				13,
				theme.TextMuted,
				"TextMuted",
				"Font"
			)
			label(
				profile,
				"● Ready",
				UDim2.new(1, -80, 0, 14),
				UDim2.fromOffset(68, 18),
				theme.FontBold,
				13,
				Color3.fromRGB(70, 220, 120),
				"Status",
				"FontBold"
			).TextXAlignment =
				Enum.TextXAlignment.Right
			if player then
				task.spawn(function()
					local ok, image = pcall(
						players.GetUserThumbnailAsync,
						players,
						player.UserId,
						Enum.ThumbnailType.HeadShot,
						Enum.ThumbnailSize.Size150x150
					)
					if ok and avatar and avatar.Parent then
						avatar.Image = image
					end
				end)
			end
		end

		if profileEnabled then
			sectionY += profileHeight + ((infoEnabled or supportEnabled) and sectionGap or 0)
		end
		local showGame, showServer = cfg.ShowGame, cfg.ShowServer
		local rowY = sectionY
		local rowGap = 8
		local function infoCard(name, xScale, xOffset, widthScale, widthOffset, iconName)
			local info = card(name, UDim2.new(xScale, xOffset, 0, rowY), UDim2.new(widthScale, widthOffset, 0, 76), 8)
			local icon = renderIcon(info, iconName, {
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.new(1, -26, 0, 10),
				ImageColor3 = theme.TextMuted,
			})
			if icon then
				table.insert(icons, { icon = icon, role = "TextMuted" })
			end
			return info
		end
		local gameCard = showGame
			and infoCard("Game", 0, 0, showServer and 0.5 or 1, showServer and -(rowGap / 2) or 0, "gamepad-2")
		local serverCard = showServer
			and infoCard(
				"Server",
				showGame and 0.5 or 0,
				showGame and (rowGap / 2) or 0,
				showGame and 0.5 or 1,
				showGame and -(rowGap / 2) or 0,
				"server"
			)
		if gameCard then
			label(
				gameCard,
				"GAME",
				UDim2.fromOffset(12, 8),
				UDim2.new(1, -44, 0, 16),
				theme.FontBold,
				12,
				theme.TextMuted,
				"TextMuted",
				"FontBold"
			)
			local gameName = label(
				gameCard,
				"Current Experience",
				UDim2.fromOffset(12, 29),
				UDim2.new(1, -24, 0, 19),
				theme.FontBold,
				15,
				theme.TextPrimary,
				"TextPrimary",
				"FontBold"
			)
			label(
				gameCard,
				"Place " .. tostring(game.PlaceId),
				UDim2.fromOffset(12, 51),
				UDim2.new(1, -24, 0, 15),
				theme.Font,
				12,
				theme.TextMuted,
				"TextMuted",
				"Font"
			)
			task.spawn(function()
				local marketplace = game:GetService("MarketplaceService")
				local fetched, details = pcall(marketplace.GetProductInfo, marketplace, game.PlaceId)
				if fetched and details and gameName and gameName.Parent then
					gameName.Text = details.Name or gameName.Text
				end
			end)
		end
		if serverCard then
			label(
				serverCard,
				"SERVER",
				UDim2.fromOffset(12, 8),
				UDim2.new(1, -44, 0, 16),
				theme.FontBold,
				12,
				theme.TextMuted,
				"TextMuted",
				"FontBold"
			)
			local playerCount = label(
				serverCard,
				"",
				UDim2.fromOffset(12, 29),
				UDim2.new(1, -24, 0, 19),
				theme.FontBold,
				15,
				theme.TextPrimary,
				"TextPrimary",
				"FontBold"
			)
			local function updatePlayers()
				if playerCount and playerCount.Parent then
					playerCount.Text = ("%d / %d Players"):format(#players:GetPlayers(), players.MaxPlayers)
				end
			end
			updatePlayers()
			label(
				serverCard,
				"● Connected",
				UDim2.fromOffset(12, 51),
				UDim2.new(1, -24, 0, 15),
				theme.Font,
				12,
				Color3.fromRGB(70, 220, 120),
				"Status",
				"Font"
			)
			table.insert(overviewConns, players.PlayerAdded:Connect(updatePlayers))
			table.insert(self._overviewConns, overviewConns[#overviewConns])
			table.insert(
				overviewConns,
				players.PlayerRemoving:Connect(function()
					task.defer(updatePlayers)
				end)
			)
			table.insert(self._overviewConns, overviewConns[#overviewConns])
		end

		if infoEnabled then
			sectionY += infoHeight + (supportEnabled and sectionGap or 0)
		end
		if supportEnabled then
			local supportCard = card("Support", UDim2.new(0, 0, 0, sectionY), UDim2.new(1, 0, 0, supportHeight), 8)
			label(
				supportCard,
				support.Title or "Need Support?",
				UDim2.fromOffset(12, 8),
				UDim2.new(1, -158, 0, 19),
				theme.FontBold,
				15,
				theme.TextPrimary,
				"TextPrimary",
				"FontBold"
			)
			label(
				supportCard,
				support.Description or "Get help or join the community",
				UDim2.fromOffset(12, 29),
				UDim2.new(1, -158, 0, 16),
				theme.Font,
				12,
				theme.TextMuted,
				"TextMuted",
				"Font"
			)
			local button = U.Create("ImageButton", {
				Name = "SupportButton",
				Position = UDim2.new(1, -138, 0.5, -14),
				Size = UDim2.fromOffset(126, 28),
				BackgroundColor3 = theme.ElementHover,
				AutoButtonColor = false,
				Parent = supportCard,
			})
			self:_makeSelectable(button)
			U.Create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = button })
			local buttonStroke =
				U.Create("UIStroke", { Color = theme.Accent, Transparency = 0.5, Thickness = 1, Parent = button })
			local supportIcon = renderIcon(
				button,
				support.ButtonIcon or "message-circle",
				{ Size = UDim2.fromOffset(15, 15), Position = UDim2.fromOffset(9, 7), ImageColor3 = theme.TextPrimary }
			)
			if supportIcon then
				table.insert(icons, { icon = supportIcon, role = "TextPrimary" })
			end
			local supportLabel = label(
				button,
				support.ButtonText or "Join Discord",
				UDim2.fromOffset(30, 0),
				UDim2.new(1, -36, 1, 0),
				theme.FontBold,
				13,
				theme.TextPrimary,
				"TextPrimary",
				"FontBold"
			)
			supportLabel.TextXAlignment = Enum.TextXAlignment.Center
			table.insert(themed, { kind = "button", frame = button, stroke = buttonStroke })
			button.Activated:Connect(function()
				local url = support.Discord
				if type(support.Callback) == "function" then
					task.spawn(support.Callback, url)
					return
				end
				local env = type(getgenv) == "function" and getgenv() or _G
				local clipboard = type(env) == "table" and rawget(env, "setclipboard") or nil
				if type(clipboard) == "function" and url then
					local copied = pcall(clipboard, url)
					if copied then
						self:Notify({
							Title = "Discord Copied",
							Content = "Invite link copied to clipboard.",
							Type = "Success",
						})
					else
						self:Notify({ Title = "Discord", Content = url, Type = "Info" })
					end
				elseif url then
					self:Notify({ Title = "Discord", Content = url, Type = "Info" })
				end
			end)
		end
		local baseDestroy = tab.Destroy
		tab.Destroy = function(overview)
			if overview._destroyed then
				return
			end
			for _, connection in ipairs(overviewConns) do
				connection:Disconnect()
				for i = #self._overviewConns, 1, -1 do
					if self._overviewConns[i] == connection then
						table.remove(self._overviewConns, i)
					end
				end
			end
			table.clear(overviewConns)
			if self._overviewTab == overview then
				self._overviewTab = nil
			end
			baseDestroy(overview)
		end
		tab.ApplyTheme = function(overview, newTheme)
			overview.Theme = newTheme
			for _, entry in ipairs(themed) do
				if entry.frame and entry.frame.Parent then
					if entry.kind == "accent" then
						entry.frame.BackgroundColor3 = newTheme.Accent
					elseif entry.kind == "button" or entry.kind == "avatar" then
						entry.frame.BackgroundColor3 = newTheme.ElementHover
					else
						entry.frame.BackgroundColor3 = newTheme.Element
					end
				end
				if entry.stroke and entry.stroke.Parent then
					entry.stroke.Color = (entry.kind == "button" or entry.kind == "avatar") and newTheme.Accent
						or newTheme.ElementBorder
				end
			end
			for _, entry in ipairs(textStyles) do
				if entry.label and entry.label.Parent then
					entry.label.Font = newTheme[entry.fontRole]
					entry.label.TextColor3 = entry.colorRole == "Status" and Color3.fromRGB(70, 220, 120)
						or newTheme[entry.colorRole]
				end
			end
			for _, entry in ipairs(icons) do
				if entry.icon and entry.icon.Parent then
					if entry.icon:IsA("ImageLabel") then
						entry.icon.ImageColor3 = newTheme[entry.role]
					elseif entry.icon:IsA("TextLabel") then
						entry.icon.TextColor3 = newTheme[entry.role]
					end
				end
			end
			theme = newTheme
			Tab.ApplyTheme(overview, newTheme)
		end

		tab._overviewThemed = themed
		return tab
	end
	function Menu:_trackFlagged(ctrl)
		if ctrl.Flag then
			ctrl._menu = self
			if self._flagRegistry[ctrl.Flag] ~= nil then
				warn(("[FyyUI] Duplicate Flag '%s' — overwriting previous controller"):format(ctrl.Flag))
			end
			self._flagRegistry[ctrl.Flag] = ctrl
		end
	end

	function Menu:_untrackFlagged(ctrl)
		if ctrl and ctrl.Flag and self._flagRegistry[ctrl.Flag] == ctrl then
			self._flagRegistry[ctrl.Flag] = nil
		end
	end

	function Menu:_registerKeybind(kb)
		table.insert(self._keybindList, kb)
	end

	function Menu:_unregisterKeybind(kb)
		for i, v in ipairs(self._keybindList) do
			if v == kb then
				table.remove(self._keybindList, i)
				break
			end
		end
	end

	function Menu:ExportConfig(options)
		if self._destroyed then
			return nil, "destroyed"
		end
		if options ~= nil and type(options) ~= "table" then
			return nil, "Invalid config export options"
		end
		local schemaVersion = options and options.SchemaVersion
		if schemaVersion ~= nil and schemaVersion ~= 2 then
			return nil, "Unsupported config schema version"
		end
		local isV2 = schemaVersion == 2
		local snapshot = isV2
				and {
					Schema = CONFIG_V2_SCHEMA,
					SchemaVersion = 2,
					Version = LIBRARY_VERSION,
					Values = {},
				}
			or {
				Schema = "FyyUI.Config.v1",
				Version = LIBRARY_VERSION,
				Values = {},
			}
		local estimatedBytes = 64
		for flag, ctrl in pairs(self._flagRegistry) do
			local value
			if ctrl.Numeric and ctrl.IsEmpty and ctrl:IsEmpty() then
				value = ""
			else
				value = ctrl:GetValue()
			end
			if isV2 then
				if type(flag) ~= "string" or flag == "" or #flag > 128 then
					return nil, "Invalid config v2: invalid flag"
				end
				if value == nil then
					-- nil is not representable in JSON objects; omit unbound keybinds.
				elseif ctrl._capturing ~= nil and typeof(value) == "EnumItem" then
					value = value.Name
				end
				if value ~= nil then
					local copied, err = copyJSONSafeValue(value, { Nodes = 0, Bytes = 0 }, {}, 0)
					if err then
						return nil, "Invalid config v2 for " .. flag .. ": " .. err
					end
					estimatedBytes = estimatedBytes + (#flag * 6) + estimateJSONSafeValueBytes(copied) + 4
					if estimatedBytes > MAX_CONFIG_JSON_BYTES then
						return nil, "Config JSON is too large"
					end
					snapshot.Values[flag] = copied
				end
			else
				snapshot.Values[flag] = value
			end
		end
		return snapshot
	end

	function Menu:ImportConfig(snapshot, options)
		if self._destroyed then
			return false, "destroyed"
		end
		if type(snapshot) ~= "table" then
			return false, "Invalid config: expected a table"
		end
		if snapshot.SchemaVersion ~= nil or snapshot.Schema == CONFIG_V2_SCHEMA then
			local validEnvelope, normalizedOrError = validateConfigV2Envelope(snapshot)
			if not validEnvelope then
				return false, normalizedOrError
			end
			snapshot = normalizedOrError
		end
		if type(snapshot.Values) ~= "table" then
			return false, "Invalid config: missing Values table"
		end
		local noCallbacks = options and options.NoCallbacks == true
		local details = { Applied = {}, Failed = {}, Unknown = {} }
		local function validateValue(ctrl, value)
			if ctrl._destroyed then
				return false, "destroyed"
			end
			if ctrl.Multi then
				if type(value) ~= "table" then
					return false, "expected options table"
				end
				local count, maxIndex = 0, 0
				for index, option in pairs(value) do
					if type(index) ~= "number" or index < 1 or index % 1 ~= 0 then
						return false, "expected dense options array"
					end
					count = count + 1
					maxIndex = math.max(maxIndex, index)
					if not ctrl:_optIndex(ctrl.Options, option) then
						return false, "unknown option"
					end
				end
				if count ~= maxIndex then
					return false, "expected dense options array"
				end
				return true
			end
			if ctrl.Numeric then
				if value == "" then
					return true
				end
				local number = tonumber(value)
				if not isFiniteNumber(number) then
					return false, "expected finite number"
				end
				return true
			end
			if ctrl.Options then
				if value == "" then
					if ctrl.AllowNone or #ctrl.Options == 0 then
						return true
					end
					return false, "selection required"
				end
				if not ctrl:_optIndex(ctrl.Options, value) then
					return false, "unknown option"
				end
				return true
			end
			if ctrl._capturing ~= nil then
				if value == nil then
					return true
				end
				if typeof(value) == "EnumItem" then
					if value.EnumType == Enum.KeyCode then
						return true
					end
					return value == Enum.UserInputType.MouseButton1
						or value == Enum.UserInputType.MouseButton2
						or value == Enum.UserInputType.MouseButton3
				end
				if type(value) == "string" then
					for _, item in ipairs(Enum.KeyCode:GetEnumItems()) do
						if item.Name == value then
							return true
						end
					end
					for _, item in ipairs(Enum.UserInputType:GetEnumItems()) do
						if
							item.Name == value
							and (
								item == Enum.UserInputType.MouseButton1
								or item == Enum.UserInputType.MouseButton2
								or item == Enum.UserInputType.MouseButton3
							)
						then
							return true
						end
					end
				end
				return false, "expected a KeyCode, MouseButton input, key name, or nil"
			end
			if type(ctrl.Value) == "boolean" and type(value) ~= "boolean" then
				return false, "expected boolean"
			end
			if ctrl.Min ~= nil and ctrl.Max ~= nil and not isFiniteNumber(value) then
				return false, "expected finite number"
			end
			return true
		end

		-- Validate every registered controller before applying any state change.
		for flag, value in pairs(snapshot.Values) do
			local ctrl = self._flagRegistry[flag]
			if ctrl then
				local valid, validationError = validateValue(ctrl, value)
				if not valid then
					table.insert(details.Failed, { Flag = flag, Error = validationError })
				end
			end
		end
		if #details.Failed > 0 then
			return false, details
		end

		for flag, value in pairs(snapshot.Values) do
			local ctrl = self._flagRegistry[flag]
			if ctrl then
				local ok, applied, err = pcall(function()
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
								local changed, changeErr = ctrl:SetValue(opt, noCallbacks)
								if changed == false then
									return false, changeErr
								end
							end
						end
						return true
					else
						if ctrl._setValueNoCallbackPosition == 3 then
							return ctrl:SetValue(value, false, noCallbacks)
						else
							return ctrl:SetValue(value, noCallbacks)
						end
					end
				end)
				if ok and applied ~= false then
					table.insert(details.Applied, flag)
				elseif ok then
					table.insert(details.Failed, { Flag = flag, Error = tostring(err or "setter rejected value") })
				else
					table.insert(details.Failed, { Flag = flag, Error = tostring(applied) })
				end
			else
				table.insert(details.Unknown, flag)
			end
		end
		if #details.Failed > 0 then
			return false, details
		end
		return true, details
	end

	function Menu:ExportConfigJSON()
		if self._destroyed then
			return nil, "destroyed"
		end
		local snapshot, exportError = self:ExportConfig({ SchemaVersion = 2 })
		if not snapshot then
			return nil, exportError
		end
		local serviceOk, httpService = pcall(function()
			return game:GetService("HttpService")
		end)
		if not serviceOk or not httpService then
			return nil, "JSON support is unavailable"
		end
		local encodedOk, encodedOrError = pcall(function()
			return httpService:JSONEncode(snapshot)
		end)
		if not encodedOk or type(encodedOrError) ~= "string" then
			return nil, "Failed to encode config JSON"
		end
		if #encodedOrError > MAX_CONFIG_JSON_BYTES then
			return nil, "Config JSON is too large"
		end
		return encodedOrError
	end

	function Menu:ImportConfigJSON(json, options)
		if self._destroyed then
			return false, "destroyed"
		end
		if type(json) ~= "string" then
			return false, "Invalid config JSON: expected a string"
		end
		if #json > MAX_CONFIG_JSON_BYTES then
			return false, "Invalid config JSON: input is too large"
		end
		local serviceOk, httpService = pcall(function()
			return game:GetService("HttpService")
		end)
		if not serviceOk or not httpService then
			return false, "JSON support is unavailable"
		end
		local decodedOk, snapshotOrError = pcall(function()
			return httpService:JSONDecode(json)
		end)
		if not decodedOk then
			return false, "Invalid config JSON"
		end
		return self:ImportConfig(snapshotOrError, options)
	end
	function Menu:Notify(options)
		if self._destroyed or not self.NotifBox then
			return nil, "destroyed"
		end
		options = options or {}
		local title = options.Title or ""
		local content = options.Content or (options.Text and tostring(options.Text)) or ""
		local duration = options.Duration == nil and 3 or options.Duration
		assert(
			isFiniteNumber(duration) and duration >= 0,
			"FyyUI Notify: Duration must be a non-negative finite number"
		)
		local notifType = options.Type or "Info"
		local theme = self.Theme

		-- Type configuration: accent + Lucide icon
		local typeDefs = {
			Info = { accent = Color3.fromRGB(0, 130, 250), icon = "info" },
			Success = { accent = Color3.fromRGB(0, 180, 80), icon = "circle-check" },
			Warning = { accent = Color3.fromRGB(220, 180, 40), icon = "triangle-alert" },
			Error = { accent = Color3.fromRGB(220, 60, 60), icon = "circle-x" },
		}
		local cfg = typeDefs[notifType] or typeDefs.Info
		local iconData = resolveIcon(cfg.icon)

		-- Layout constants
		local PAD = 12
		local GAP = 5
		local CARD_W = 320
		local ICON_SZ = 20
		local hasTitle = title ~= ""
		local hasContent = content ~= ""

		-- Compute content text height
		local contentW = CARD_W - PAD * 2
		local contentH = 0
		local textSvc = game:GetService("TextService")
		if hasContent then
			local sz = textSvc:GetTextSize(content, theme.FontSize, theme.Font, Vector2.new(contentW, 1000))
			contentH = sz.Y
		end

		-- Card height: top pad + icon row + (gap + content) + bottom pad + progress bar
		local bodyTop = PAD + ICON_SZ
		if hasContent then
			bodyTop = bodyTop + GAP + contentH
		end
		local cardH = math.max(bodyTop + PAD + 3, 54)

		-- ── Build card ──
		local frame = U.Create("Frame", {
			Name = "Notification",
			Size = UDim2.fromOffset(CARD_W, cardH),
			BackgroundColor3 = theme.Element,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			Parent = self.NotifBox,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = frame })
		U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = frame })

		-- Icon
		if iconData and iconData.Image then
			U.Create("ImageLabel", {
				Name = "Icon",
				Size = UDim2.fromOffset(ICON_SZ, ICON_SZ),
				Position = UDim2.fromOffset(PAD, PAD),
				BackgroundTransparency = 1,
				Image = iconData.Image,
				ImageColor3 = cfg.accent,
				Parent = frame,
			})
		end

		-- Title (right of icon)
		local titleLabel
		if hasTitle then
			local titleX = iconData and (PAD + ICON_SZ + 8) or PAD
			titleLabel = U.Create("TextLabel", {
				Name = "Title",
				Size = UDim2.new(0, CARD_W - titleX - PAD, 0, theme.FontSize + 2),
				Position = UDim2.fromOffset(titleX, PAD),
				BackgroundTransparency = 1,
				Text = title,
				Font = theme.FontBold,
				TextSize = theme.FontSize,
				TextColor3 = theme.TextPrimary,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
				TextWrapped = false,
				Parent = frame,
			})
		end

		-- Content (below icon row, full width)
		local contentLabel
		if hasContent then
			local contentY = PAD + ICON_SZ + GAP
			contentLabel = U.Create("TextLabel", {
				Name = "Content",
				Size = UDim2.new(0, contentW, 0, contentH),
				Position = UDim2.fromOffset(PAD, contentY),
				BackgroundTransparency = 1,
				Text = content,
				Font = theme.Font,
				TextSize = theme.FontSize,
				TextColor3 = theme.TextSecondary,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
				TextWrapped = true,
				Parent = frame,
			})
		end

		-- Progress track + fill (bottom of card)
		local progressTrack = U.Create("Frame", {
			Name = "ProgressTrack",
			Size = UDim2.new(1, -(PAD * 2), 0, 3),
			Position = UDim2.fromOffset(PAD, cardH - 9),
			BackgroundColor3 = theme.ElementHover,
			BorderSizePixel = 0,
			Parent = frame,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = progressTrack })
		local progressFill = U.Create("Frame", {
			Name = "ProgressFill",
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.fromOffset(0, 0),
			BackgroundColor3 = cfg.accent,
			BorderSizePixel = 0,
			Parent = progressTrack,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = progressFill })

		-- ── Entrance setup ──
		local ts = game:GetService("TweenService")
		local dismissed = false
		local progressTween
		local enterTween
		local dismissTask

		-- Record
		local record = {
			frame = frame,
			h = cardH,
			dismiss = nil,
			posTween = nil,
		}
		table.insert(self._activeNotifs, record)
		frame.AnchorPoint = Vector2.new(0, 1)
		self:_reflowNotifs(not self._reducedMotion, record)
		local bottomOffset = 0
		local GAP_BETWEEN = 4
		for _, rec in ipairs(self._activeNotifs) do
			if rec == record then
				break
			end
			bottomOffset = bottomOffset + rec.h + GAP_BETWEEN
		end
		local targetPosition = UDim2.new(0, 0, 1, -bottomOffset)

		-- Place at entrance offset, then animate to target
		if not self._reducedMotion then
			frame.Position = UDim2.new(0, 24, 1, 0)
			frame.BackgroundTransparency = 1
			for _, child in ipairs(frame:GetChildren()) do
				if child:IsA("TextLabel") then
					child.TextTransparency = 1
				end
				if child:IsA("ImageLabel") then
					child.ImageTransparency = 1
				end
				if child:IsA("Frame") then
					child.BackgroundTransparency = 1
				end
				if child:IsA("UIStroke") then
					child.Transparency = 1
				end
			end
			if progressTrack then
				progressTrack.BackgroundTransparency = 1
			end
			if progressFill then
				progressFill.BackgroundTransparency = 1
			end

			-- Entrance: slide in from right + fade
			enterTween = self:_transition(frame, 0.3, {
				Position = targetPosition,
				BackgroundTransparency = 0,
			}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			-- Fade children in alongside
			for _, child in ipairs(frame:GetChildren()) do
				if child:IsA("TextLabel") then
					self:_transition(child, 0.25, { TextTransparency = 0 })
				elseif child:IsA("ImageLabel") then
					self:_transition(child, 0.25, { ImageTransparency = 0 })
				elseif child:IsA("Frame") then
					self:_transition(child, 0.25, { BackgroundTransparency = 0 })
				elseif child:IsA("UIStroke") then
					self:_transition(child, 0.25, { Transparency = 0.6 })
				end
			end
			if progressTrack then
				self:_transition(progressTrack, 0.25, { BackgroundTransparency = 0 })
			end
			if progressFill then
				self:_transition(progressFill, 0.25, { BackgroundTransparency = 0 })
			end
		else
			frame.Position = targetPosition
			frame.BackgroundTransparency = 0
		end

		-- ── Local dismiss function ──
		local function dismiss()
			if dismissed or not frame or not frame.Parent then
				return false
			end
			dismissed = true

			-- Cancel scheduled dismiss & tweens
			if dismissTask then
				task.cancel(dismissTask)
				dismissTask = nil
			end
			if progressTween then
				progressTween:Cancel()
				progressTween = nil
			end
			if enterTween then
				enterTween:Cancel()
				enterTween = nil
			end

			-- Cancel any in-flight positional tween tracked on this record
			if record.posTween then
				record.posTween:Cancel()
				record.posTween = nil
			end

			-- The parent has fixed geometry, so preserving this local Y guarantees
			-- the card cannot move vertically while it exits.
			local exitPosition = frame.Position

			-- Remove from active layout while keeping the live card visible.
			for i, rec in ipairs(self._activeNotifs) do
				if rec.frame == frame then
					table.remove(self._activeNotifs, i)
					break
				end
			end

			if not self._reducedMotion then
				-- Reflow siblings immediately; the exiting card is no longer part of
				-- active layout and keeps its own frozen Y until destruction.
				self:_reflowNotifs(true)

				-- Exit: slide only on X. Y is copied without modification.
				self:_transition(
					frame,
					0.3,
					{
						Position = UDim2.new(
							exitPosition.X.Scale,
							exitPosition.X.Offset + 40,
							exitPosition.Y.Scale,
							exitPosition.Y.Offset
						),
						BackgroundTransparency = 1,
					},
					Enum.EasingStyle.Quint,
					Enum.EasingDirection.In,
					function()
						if frame and frame.Parent then
							frame:Destroy()
						end
					end
				)
				for _, child in ipairs(frame:GetDescendants()) do
					if child:IsA("TextLabel") then
						self:_transition(child, 0.2, { TextTransparency = 1 })
					elseif child:IsA("ImageLabel") then
						self:_transition(child, 0.2, { ImageTransparency = 1 })
					elseif child:IsA("Frame") then
						self:_transition(child, 0.2, { BackgroundTransparency = 1 })
					elseif child:IsA("UIStroke") then
						self:_transition(child, 0.2, { Transparency = 1 })
					end
				end
			else
				-- ReducedMotion: destroy + reflow immediately
				if frame then
					frame:Destroy()
				end
				self:_reflowNotifs(false)
			end
			return true
		end
		record.dismiss = dismiss

		-- ── Auto-dismiss ──
		if duration > 0 then
			if not self._reducedMotion then
				progressTween = ts:Create(progressFill, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
					Size = UDim2.new(0, 0, 1, 0),
				})
				progressTween:Play()
			end
			dismissTask = task.delay(duration, function()
				if self._destroyed or dismissed or not frame or not frame.Parent then
					return
				end
				dismissTask = nil
				dismiss()
			end)
		end

		-- ── Handle ──
		local handle = {}
		function handle:Dismiss()
			return dismiss()
		end
		function handle:Update(...)
			if dismissed or not frame or not frame.Parent then
				return false, "dismissed"
			end
			local args = { ... }
			-- Backward-compat: single arg updates Content, clears Title
			if #args == 1 and type(args[1]) == "string" then
				content = args[1]
				title = ""
				hasTitle = false
				hasContent = content ~= ""
			elseif #args >= 2 then
				title = tostring(args[1] or "")
				content = tostring(args[2] or "")
				hasTitle = title ~= ""
				hasContent = content ~= ""
			end

			-- Recalculate height
			contentH = 0
			if hasContent then
				local sz = textSvc:GetTextSize(content, theme.FontSize, theme.Font, Vector2.new(contentW, 1000))
				contentH = sz.Y
			end
			local newBodyTop = PAD + ICON_SZ
			if hasContent then
				newBodyTop = newBodyTop + GAP + contentH
			end
			local newCardH = math.max(newBodyTop + PAD + 3, 54)

			-- Update labels
			if titleLabel then
				titleLabel.Text = title
				titleLabel.Visible = hasTitle
			elseif hasTitle then
				-- Need to create title label
				local titleX = iconData and (PAD + ICON_SZ + 8) or PAD
				titleLabel = U.Create("TextLabel", {
					Name = "Title",
					Size = UDim2.new(0, CARD_W - titleX - PAD, 0, theme.FontSize + 2),
					Position = UDim2.fromOffset(titleX, PAD),
					BackgroundTransparency = 1,
					Text = title,
					Font = theme.FontBold,
					TextSize = theme.FontSize,
					TextColor3 = theme.TextPrimary,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
					TextWrapped = false,
					Parent = frame,
				})
			end
			if not hasTitle and titleLabel then
				titleLabel.Visible = false
			end

			if contentLabel then
				contentLabel.Text = content
				contentLabel.Size = UDim2.new(0, contentW, 0, contentH)
				local newContentY = PAD + ICON_SZ + GAP
				contentLabel.Position = UDim2.fromOffset(PAD, newContentY)
				contentLabel.Visible = hasContent
			elseif hasContent then
				local contentY = PAD + ICON_SZ + GAP
				contentLabel = U.Create("TextLabel", {
					Name = "Content",
					Size = UDim2.new(0, contentW, 0, contentH),
					Position = UDim2.fromOffset(PAD, contentY),
					BackgroundTransparency = 1,
					Text = content,
					Font = theme.Font,
					TextSize = theme.FontSize,
					TextColor3 = theme.TextSecondary,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
					TextWrapped = true,
					Parent = frame,
				})
			end
			if not hasContent and contentLabel then
				contentLabel.Visible = false
			end

			-- Update frame size
			frame.Size = UDim2.fromOffset(CARD_W, newCardH)
			record.h = newCardH
			progressTrack.Position = UDim2.fromOffset(PAD, newCardH - 9)

			-- Reflow siblings
			self:_reflowNotifs(not self._reducedMotion)
			return true
		end

		return handle
	end

	function Menu:_reflowNotifs(animated, excludedRecord)
		if self._destroyed or not self._activeNotifs then
			return
		end
		if animated and self._reducedMotion then
			animated = false
		end
		local bottomOffset = 0
		local GAP = 4
		for i = 1, #self._activeNotifs do
			local rec = self._activeNotifs[i]
			local frame = rec.frame
			local target = UDim2.new(0, 0, 1, -bottomOffset)
			if rec ~= excludedRecord then
				bottomOffset = bottomOffset + rec.h + GAP
			end
			if rec ~= excludedRecord and frame and frame.Parent then
				if animated then
					-- Cancel any existing positional tween before starting a new one
					if rec.posTween then
						rec.posTween:Cancel()
						rec.posTween = nil
					end
					rec.posTween = self:_transition(frame, 0.25, {
						Position = target,
					}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				else
					frame.Position = target
				end
			end
		end
	end
	function Menu:_dragging()
		local topbar = self.Topbar
		local frame = self.Frame
		local shadow = self._shadow
		local dragging, ds, sp
		local uis = game:GetService("UserInputService")
		local CLAMP_MARGIN = 40

		topbar.InputBegan:Connect(function(input)
			local t = input.UserInputType
			if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
				dragging = true
				ds = input.Position
				sp = frame.Position
			end
		end)
		self._dragInputCon = uis.InputChanged:Connect(function(input, gpe)
			if gpe then
				return
			end
			if
				(
					input.UserInputType == Enum.UserInputType.MouseMovement
					or input.UserInputType == Enum.UserInputType.Touch
				) and dragging
			then
				local delta = input.Position - ds
				-- Clamp so at least CLAMP_MARGIN px of the frame stays visible in the viewport
				local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize
					or Vector2.new(1920, 1080)
				local fs = frame.AbsoluteSize
				local rawX = sp.X.Scale * viewport.X + sp.X.Offset + delta.X
				local rawY = sp.Y.Scale * viewport.Y + sp.Y.Offset + delta.Y
				local clampedX = math.clamp(rawX, -fs.X + CLAMP_MARGIN, viewport.X - CLAMP_MARGIN)
				local clampedY = math.clamp(rawY, -fs.Y + CLAMP_MARGIN, viewport.Y - CLAMP_MARGIN)
				frame.Position = UDim2.new(
					sp.X.Scale,
					clampedX - sp.X.Scale * viewport.X,
					sp.Y.Scale,
					clampedY - sp.Y.Scale * viewport.Y
				)
				if shadow then
					shadow.Position = UDim2.new(
						sp.X.Scale,
						clampedX - sp.X.Scale * viewport.X - 8,
						sp.Y.Scale,
						clampedY - sp.Y.Scale * viewport.Y - 8
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

	function Menu:_closeTransientUi()
		self:HideDropdownPopup()
		self:CloseCommandPalette()
		self._tooltipPending = false
		self._tooltipTarget = nil
		self:_hideTooltip()
		if self._confirmPopup then
			local confirm = self._confirmPopup
			self._confirmPopup = nil
			for _, instance in pairs(confirm) do
				pcall(function()
					instance:Destroy()
				end)
			end
		end
	end

	function Menu:_setInternalsVisible(visible)
		if self.Sidebar then
			self.Sidebar.Visible = visible
		end
		if self.ContentArea then
			self.ContentArea.Visible = visible
		end
		if self.SidebarLine then
			self.SidebarLine.Visible = visible
		end
		if self.TitleLogo then
			self.TitleLogo.Visible = visible
		end
		if self.TitleAccent then
			self.TitleAccent.Visible = visible and self._titleBranded
		end
		if self.Title then
			self.Title.Visible = visible
		end
		if self.Topbar then
			for _, child in ipairs(self.Topbar:GetChildren()) do
				if child:IsA("ImageButton") then
					child.Visible = visible
				end
			end
		end
	end

	function Menu:_setMenuTransitionVisual(scale, backgroundTransparency, shadowTransparency, outlineTransparency)
		if self._uiScale then
			self._uiScale.Scale = scale or self.Scale
		end
		if self.Frame and backgroundTransparency ~= nil then
			self.Frame.BackgroundTransparency = backgroundTransparency
		end
		if self._shadow and shadowTransparency ~= nil then
			self._shadow.BackgroundTransparency = shadowTransparency
		end
		local outline = self.Frame and self.Frame:FindFirstChildOfClass("UIStroke")
		if outline and outlineTransparency ~= nil then
			outline.Transparency = outlineTransparency
		end
	end

	function Menu:_refreshRestoredLayout()
		self:_applyResponsiveLayout(true)
		if not self.ContentArea then
			return
		end
		for _, child in ipairs(self.ContentArea:GetChildren()) do
			if child:IsA("ScrollingFrame") then
				local layout = child:FindFirstChildOfClass("UIListLayout")
				if layout then
					local padding = child:FindFirstChildOfClass("UIPadding")
					local paddingY = padding and (padding.PaddingTop.Offset + padding.PaddingBottom.Offset) or 0
					child.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + paddingY)
				end
			end
		end
	end

	function Menu:_minimize()
		if self._destroyed then
			return
		end
		if self.Minimized then
			return true
		end
		self:_closeTransientUi()
		self:_setInternalsVisible(false)
		self.Minimized = true
		self._minPrevSize = self.Frame.Size
		self._minPrevPos = self.Frame.Position

		self._minimizeToken = (self._minimizeToken or 0) + 1
		local minimizeToken = self._minimizeToken
		local pending = self._shadow and 3 or 2
		local function finishMinimize()
			pending -= 1
			if pending > 0 then
				return
			end
			if self._destroyed or self._minimizeToken ~= minimizeToken or not self.Minimized or not self.Visible then
				if self._minimizeToken == minimizeToken then
					self:_setInternalsVisible(true)
					self:_setMenuTransitionVisual(self.Scale, self._baseBackgroundTransparency, 0.55, 0.25)
				end
				return
			end
			if self._minGui then
				self._minFrame.Position = self._minSavedPos or self._minInitialPos
				self._minFrame.Active = true
				self._minFrame.BackgroundTransparency = 0
				if self._minScale then
					self._minScale.Scale = 1
				end
				local icon = self._minFrame:FindFirstChild("Icon")
				if icon then
					icon.ImageTransparency = 0
				end
				self._minGui.Enabled = true
				self._minGui.Parent = self.GuiParent
				self.Gui.Enabled = false
			elseif self._noLogoRestoreGui then
				if self._noLogoRestoreBtn and self._noLogoSavedPos then
					self._noLogoRestoreBtn.Position = self._noLogoSavedPos
				end
				self._noLogoRestoreGui.Enabled = true
				self._noLogoRestoreGui.Parent = self.GuiParent
				self.Gui.Enabled = false
			end
		end
		self:_transition(self.Frame, 0.22, {
			Position = self.Frame.Position + UDim2.fromOffset(0, 8),
			BackgroundTransparency = math.min(1, self._baseBackgroundTransparency + 0.72),
		}, Enum.EasingStyle.Quad, Enum.EasingDirection.In, finishMinimize)
		self:_transition(
			self._uiScale,
			0.22,
			{ Scale = self.Scale * 0.96 },
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.In,
			finishMinimize
		)
		if self._shadow then
			self:_transition(self._shadow, 0.18, { BackgroundTransparency = 1 }, nil, nil, finishMinimize)
		end
	end

	function Menu:_restore()
		if self._destroyed or self._restoring or not self.Minimized then
			return
		end
		self._restoring = true
		self._minimizeToken = (self._minimizeToken or 0) + 1
		local restoreToken = self._minimizeToken
		self.Minimized = false
		local guiWasEnabled = self.Gui.Enabled
		local minGuiWasEnabled = self._minGui and self._minGui.Enabled or false
		local noLogoGuiWasEnabled = self._noLogoRestoreGui and self._noLogoRestoreGui.Enabled or false

		local restorePos = self._minPrevPos or self._initialPos
		self.Frame.Size = self._minPrevSize or self._initialSize
		self.Frame.Position = restorePos + UDim2.fromOffset(0, 8)
		self:_setMenuTransitionVisual(self.Scale * 0.96, math.min(1, self._baseBackgroundTransparency + 0.72), 1, 1)
		self.Gui.Enabled = true
		self:_refreshRestoredLayout()
		if self._minFrame and self._minGui and self._minGui.Enabled then
			self._minFrame.Active = false
			local icon = self._minFrame:FindFirstChild("Icon")
			self:_transition(
				self._minFrame,
				0.12,
				{ BackgroundTransparency = 1 },
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.In
			)
			if self._minScale then
				self:_transition(self._minScale, 0.12, { Scale = 0.9 }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			end
			if icon then
				self:_transition(icon, 0.1, { ImageTransparency = 1 }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			end
			local function hideMinimizeGui()
				if self._destroyed or self._minimizeToken ~= restoreToken then
					return
				end
				self._minGui.Enabled = false
			end
			if self._reducedMotion then
				hideMinimizeGui()
			else
				task.delay(0.12, hideMinimizeGui)
			end
		elseif self._noLogoRestoreGui then
			self._noLogoRestoreGui.Enabled = false
		end

		local pending = self._shadow and 3 or 2
		local function finishRestore()
			pending -= 1
			if pending <= 0 then
				if self._destroyed or self._minimizeToken ~= restoreToken then
					if not self._destroyed then
						self.Minimized = true
						self.Gui.Enabled = guiWasEnabled
						if self._minGui then
							self._minGui.Enabled = minGuiWasEnabled
						end
						if self._noLogoRestoreGui then
							self._noLogoRestoreGui.Enabled = noLogoGuiWasEnabled
						end
					end
					self._restoring = false
					return
				end
				self:_setInternalsVisible(true)
				self._restoring = false
				if self._minFrame then
					self._minFrame.Active = true
					self._minFrame.BackgroundTransparency = 0
					if self._minScale then
						self._minScale.Scale = 1
					end
					local icon = self._minFrame:FindFirstChild("Icon")
					if icon then
						icon.ImageTransparency = 0
					end
				end
				if self._noLogoRestoreGui then
					self._noLogoRestoreGui.Enabled = false
				end
				self:_refreshRestoredLayout()
				local activeTab = self.ActiveTab
				if activeTab and activeTab.Components then
					for _, comp in ipairs(activeTab.Components) do
						if type(comp) == "table" and type(comp._updateSize) == "function" then
							pcall(comp._updateSize, comp, true)
						end
					end
				end
			end
		end
		self:_transition(
			self.Frame,
			0.24,
			{ Position = restorePos, BackgroundTransparency = self._baseBackgroundTransparency },
			Enum.EasingStyle.Quint,
			Enum.EasingDirection.Out,
			finishRestore
		)
		self:_transition(
			self._uiScale,
			0.24,
			{ Scale = self.Scale },
			Enum.EasingStyle.Quint,
			Enum.EasingDirection.Out,
			finishRestore
		)
		if self._shadow then
			self:_transition(self._shadow, 0.22, { BackgroundTransparency = 0.55 }, nil, nil, finishRestore)
		else
			-- Frame and scale are the only completion signals when no shadow exists.
			-- Keep the restoring lock until both callbacks above complete.
		end
	end

	function Menu:_toggleMaximize()
		if self._destroyed or self._maximizing then
			return
		end
		self._maximizing = true
		self.Maximized = not self.Maximized
		self.Gui.Enabled = true
		if self.Minimized then
			self.Minimized = false
			self:_setInternalsVisible(true)
			if self._minGui then
				self._minGui.Enabled = false
			end
			if self._noLogoRestoreGui then
				self._noLogoRestoreGui.Enabled = false
			end
		end

		if self._maximizeTween then
			self._maximizeTween:Cancel()
		end
		local viewport = self:_viewportSize()
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

		self._maximizeTween = self:_transition(
			self.Frame,
			0.25,
			{ Size = targetSize, Position = targetPosition },
			Enum.EasingStyle.Quart,
			Enum.EasingDirection.Out,
			function()
				if self._destroyed then
					return
				end
				self._maximizing = false
				self._maximizeTween = nil
				if self._updateShadow then
					self._updateShadow()
				end
			end
		)
	end

	function Menu:_resizable()
		local grip = U.Create("ImageButton", {
			Name = "ResizeGrip",
			Size = UDim2.fromOffset(44, 44),
			Position = UDim2.new(1, -44, 1, -44),
			BackgroundTransparency = 1,
			AutoButtonColor = false,
			Active = true,
			Parent = self.Frame,
		})
		local gripVisual = U.Create("Frame", {
			Name = "Visual",
			Size = UDim2.fromOffset(14, 14),
			Position = UDim2.new(1, -14, 1, -14),
			BackgroundColor3 = self.Theme.TextMuted,
			BackgroundTransparency = 0.6,
			BorderSizePixel = 0,
			Parent = grip,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 2), Parent = gripVisual })

		local frame = self.Frame
		local shadow = self._shadow
		local uis = game:GetService("UserInputService")
		local resizing, rs, rsiz, resizeInputObj

		grip.InputBegan:Connect(function(input)
			local t = input.UserInputType
			if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
				resizing = true
				resizeInputObj = input
				rs = input.Position
				rsiz = frame.Size
			end
		end)
		self._resizeInputCon = uis.InputChanged:Connect(function(input, _)
			local t = input.UserInputType
			-- gpe guard removed: while actively resizing we must follow all mouse/touch movement.
			-- For touch, only follow the specific initiating touch (not unrelated touches).
			local isOurTouch = (t == Enum.UserInputType.Touch and input == resizeInputObj)
			if ((t == Enum.UserInputType.MouseMovement) or isOurTouch) and resizing then
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
				if not self._responsiveApplied and not self.Maximized then
					self._responsiveBaseSize = frame.Size
					self._responsiveBasePosition = frame.Position
				end
				if shadow then
					shadow.Size = UDim2.fromOffset(nw + 16, nh + 16)
				end
			end
		end)
		self._resizeEndCon = uis.InputEnded:Connect(function(input, _)
			local t = input.UserInputType
			-- gpe guard removed: must always stop resize on release.
			-- Mouse: any MouseButton1 release stops resize.
			-- Touch: only the specific initiating touch release stops resize.
			if resizing then
				if
					t == Enum.UserInputType.MouseButton1 or (t == Enum.UserInputType.Touch and input == resizeInputObj)
				then
					resizing = false
					resizeInputObj = nil
				end
			end
		end)
	end

	function Menu:SetVisible(v)
		if self._destroyed then
			return false, "destroyed"
		end
		if type(v) ~= "boolean" then
			return false, "expected boolean"
		end
		self.Visible = v
		if not self.Gui then
			return false, "missing gui"
		end
		if v then
			-- Restore visibility without accidentally unminimizing
			if self.Minimized then
				self.Gui.Enabled = false
				if self._minGui then
					self._minGui.Enabled = true
					self._minGui.Parent = self.GuiParent
				elseif self._noLogoRestoreGui then
					self._noLogoRestoreGui.Enabled = true
					self._noLogoRestoreGui.Parent = self.GuiParent
				end
			else
				self.Gui.Enabled = true
				self:_setMenuTransitionVisual(self.Scale, self._baseBackgroundTransparency, 0.55, 0.25)
				self:_setInternalsVisible(true)
			end
			if self._notifGui then
				self._notifGui.Enabled = true
			end
		else
			-- Deliberately hidden: close dropdown, suppress restore/notif GUIs
			self:_closeTransientUi()
			if self._minGui then
				self._minGui.Enabled = false
			end
			if self._noLogoRestoreGui then
				self._noLogoRestoreGui.Enabled = false
			end
			if self._notifGui then
				self._notifGui.Enabled = false
			end
			self.Gui.Enabled = false
		end
		return true
	end

	function Menu:ToggleVisibility()
		return self:SetVisible(not self.Visible)
	end
	function Menu:GetVisible()
		return self.Visible
	end
	function Menu:SetTitle(t)
		if self._destroyed or not self.Title then
			return false, "destroyed"
		end
		if type(t) ~= "string" then
			return false, "expected string"
		end
		self._titleText = t
		self._refreshTitle()
		return true
	end

	function Menu:_confirmClose()
		if self._confirmPopup then
			return
		end
		-- Close any active dropdown first so it cannot overlay the confirmation UI
		self:HideDropdownPopup()
		self._confirmFocusReturn = self:_beginTransientFocus(self.Topbar)
		local theme = self.Theme
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
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
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
		U.Create(
			"UIStroke",
			{ Color = Color3.fromRGB(255, 255, 255), Transparency = 0.88, Thickness = 1, Parent = popup }
		)

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
			self:_makeSelectable(b)
			U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = b })
			local bs = U.Create("UIScale", { Parent = b, Scale = 1 })
			U.Create("TextLabel", {
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Text = text,
				Font = theme.FontBold,
				TextSize = 15,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				ZIndex = 15,
				Parent = b,
			})
			b.MouseEnter:Connect(function()
				self:_transition(b, 0.12, { BackgroundColor3 = hovColor, BackgroundTransparency = 0.05 })
			end)
			b.MouseLeave:Connect(function()
				self:_transition(b, 0.12, { BackgroundColor3 = defColor, BackgroundTransparency = 0.25 })
			end)
			b.MouseButton1Down:Connect(function()
				self:_transition(bs, 0.05, { Scale = 0.95 })
			end)
			b.MouseButton1Up:Connect(function()
				self:_transition(bs, 0.08, { Scale = 1 })
			end)
			b.Activated:Connect(cb)
			return b
		end

		self._confirmPopup = { popup = popup, overlay = overlay, shadow = shadow }

		-- Fade IN: only overlay dims (popup already fully visible & clickable)
		self:_transition(overlay, 0.2, { BackgroundTransparency = 0.5 })

		-- Close
		local closing = false
		local function closePopup(cb)
			if closing then
				return
			end
			closing = true
			self:_transition(overlay, 0.2, { BackgroundTransparency = 1 }, nil, nil, function()
				if self._destroyed then
					return
				end
				if overlay then
					overlay:Destroy()
				end
				if popup then
					popup:Destroy()
				end
				if shadow then
					shadow:Destroy()
				end
				self._confirmPopup = nil
				local focusReturn = self._confirmFocusReturn
				self._confirmFocusReturn = nil
				self:_restoreTransientFocus(focusReturn)
				if cb then
					cb()
				end
			end)
		end

		local noButton = makeBtn("No", 20, Color3.fromRGB(55, 55, 68), Color3.fromRGB(75, 75, 90), function()
			closePopup(nil)
		end)
		makeBtn("Yes", 140, Color3.fromRGB(170, 45, 45), Color3.fromRGB(210, 60, 60), function()
			closePopup(function()
				self:SetVisible(false)
			end)
		end)
		if self._confirmFocusReturn then
			game:GetService("GuiService").SelectedObject = noButton
		end
	end

	function Menu:Destroy()
		if self._destroyed then
			return
		end
		self:_closeTransientUi()
		self._destroyed = true
		self._minimizeToken = (self._minimizeToken or 0) + 1
		if self._activeNotifs then
			local activeNotifs = table.clone(self._activeNotifs)
			for _, record in ipairs(activeNotifs) do
				if record.frame then
					record.frame:Destroy()
				end
			end
			table.clear(self._activeNotifs)
		end

		-- Disconnect all service-level connections
		if self._heartbeatCon then
			self._heartbeatCon:Disconnect()
			self._heartbeatCon = nil
		end
		for _, connection in ipairs(self._overviewConns or {}) do
			connection:Disconnect()
		end
		self._overviewConns = {}
		if self._popupUISCon then
			self._popupUISCon:Disconnect()
			self._popupUISCon = nil
		end
		if self._dragInputCon then
			self._dragInputCon:Disconnect()
			self._dragInputCon = nil
		end
		if self._minDragInputCon then
			self._minDragInputCon:Disconnect()
			self._minDragInputCon = nil
		end
		if self._noLogoDragCon then
			self._noLogoDragCon:Disconnect()
			self._noLogoDragCon = nil
		end
		if self._sidebarScrollCon then
			self._sidebarScrollCon:Disconnect()
			self._sidebarScrollCon = nil
		end
		if self._resizeInputCon then
			self._resizeInputCon:Disconnect()
			self._resizeInputCon = nil
		end
		if self._resizeEndCon then
			self._resizeEndCon:Disconnect()
			self._resizeEndCon = nil
		end
		if self._cameraCon then
			self._cameraCon:Disconnect()
			self._cameraCon = nil
		end
		if self._cameraViewportCon then
			self._cameraViewportCon:Disconnect()
			self._cameraViewportCon = nil
		end
		if self._keybindInputCon then
			self._keybindInputCon:Disconnect()
			self._keybindInputCon = nil
		end
		if self._keybindEndCon then
			self._keybindEndCon:Disconnect()
			self._keybindEndCon = nil
		end
		if self._scaleTween then
			self._scaleTween:Cancel()
			self._scaleTween = nil
		end
		if self._activeBarTween then
			self._activeBarTween:Cancel()
			self._activeBarTween = nil
		end

		-- Destroy external ScreenGuis owned by this menu
		if self._notifGui then
			self._notifGui:Destroy()
			self._notifGui = nil
		end
		if self._minGui then
			self._minGui:Destroy()
			self._minGui = nil
		end
		if self._noLogoRestoreGui then
			self._noLogoRestoreGui:Destroy()
			self._noLogoRestoreGui = nil
		end

		-- Destroy any active confirm-close popup
		if self._confirmPopup then
			if self._confirmPopup.overlay then
				self._confirmPopup.overlay:Destroy()
			end
			if self._confirmPopup.popup then
				self._confirmPopup.popup:Destroy()
			end
			if self._confirmPopup.shadow then
				self._confirmPopup.shadow:Destroy()
			end
			self._confirmPopup = nil
		end

		-- Close any active dropdown popup
		if self._activePopupFrame then
			self._activePopupFrame:Destroy()
			self._activePopupFrame = nil
		end
		if self._activePopupOverlay then
			self._activePopupOverlay:Destroy()
			self._activePopupOverlay = nil
		end
		if self._activeDropdown then
			self._activeDropdown = nil
		end

		-- Tooltip cleanup
		self._tooltipPending = false
		self._tooltipTarget = nil
		self._tooltipActive = false
		if self._tooltipTween then
			self._tooltipTween:Cancel()
			self._tooltipTween = nil
		end
		if self._mouseCon then
			self._mouseCon:Disconnect()
			self._mouseCon = nil
		end
		for _, data in pairs(self._tooltips) do
			if data.unbind then
				data.unbind()
			end
		end
		self._tooltips = {}
		if self._tooltipLabel then
			self._tooltipLabel:Destroy()
			self._tooltipLabel = nil
		end

		-- Destroy tabs
		for _, tab in ipairs(self.Tabs) do
			tab:Destroy()
		end
		self.Tabs = {}

		-- Destroy main GUI last
		if self.Gui then
			self.Gui:Destroy()
			self.Gui = nil
		end
	end
	function Menu:_ApplyTheme(theme)
		if not self.Frame then
			return
		end

		-- Main frame
		self.Frame.BackgroundColor3 = theme.Background
		local corner = self.Frame:FindFirstChildOfClass("UICorner")
		if corner then
			corner.CornerRadius = UDim.new(0, theme.CornerRadius)
		end
		local frameStroke = self.Frame:FindFirstChildOfClass("UIStroke")
		if frameStroke then
			frameStroke.Color = theme.Outline
		end

		-- Shadow
		if self._shadow then
			self._shadow.BackgroundColor3 = theme.Shadow
			local shadowCorner = self._shadow:FindFirstChildOfClass("UICorner")
			if shadowCorner then
				shadowCorner.CornerRadius = UDim.new(0, theme.CornerRadius + 2)
			end
		end

		-- Topbar
		self.Topbar.BackgroundColor3 = theme.Topbar
		local topCorner = self.Topbar:FindFirstChildOfClass("UICorner")
		if topCorner then
			topCorner.CornerRadius = UDim.new(0, theme.CornerRadius)
		end
		local topFill = self.Topbar:FindFirstChild("Fill")
		if topFill then
			topFill.BackgroundColor3 = theme.Topbar
		end

		-- Title
		self.Title.TextColor3 = theme.TextPrimary
		self.Title.Font = Enum.Font.BuilderSansBold
		self.Title.TextSize = 17
		if self.TitleAccent then
			self.TitleAccent.TextColor3 = theme.Accent
			self.TitleAccent.Font = Enum.Font.BuilderSansExtraBold
			self.TitleAccent.TextSize = 17
		end
		if self._refreshTitle then
			self._refreshTitle()
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
		if grip then
			local visual = grip:FindFirstChild("Visual")
			if visual then
				visual.BackgroundColor3 = theme.TextMuted
			end
		end

		-- No-logo restore button (minimize affordance)
		if self._noLogoRestoreBtn then
			self._noLogoRestoreBtn.BackgroundColor3 = theme.Element
			self._noLogoRestoreBtn.TextColor3 = theme.TextPrimary
			local restoreStroke = self._noLogoRestoreBtn:FindFirstChildOfClass("UIStroke")
			if restoreStroke then
				restoreStroke.Color = theme.Accent
			end
		end
		if self._minFrame then
			self._minFrame.BackgroundColor3 = theme.Element
			local minStroke = self._minFrame:FindFirstChildOfClass("UIStroke")
			if minStroke then
				minStroke.Color = theme.Accent
			end
		end
		if self.SidebarLine then
			self.SidebarLine.BackgroundColor3 = theme.Border
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
					local stroke = notif:FindFirstChildOfClass("UIStroke")
					if stroke then
						stroke.Color = theme.ElementBorder
					end
					local icon = notif:FindFirstChild("Icon")
					if icon and icon:IsA("ImageLabel") then
						icon.ImageColor3 = icon.ImageColor3 -- keep type accent, already set
					end
					local titleLbl = notif:FindFirstChild("Title")
					if titleLbl and titleLbl:IsA("TextLabel") then
						titleLbl.Font = theme.FontBold
						titleLbl.TextSize = theme.FontSize
						titleLbl.TextColor3 = theme.TextPrimary
					end
					local contentLbl = notif:FindFirstChild("Content")
					if contentLbl and contentLbl:IsA("TextLabel") then
						contentLbl.Font = theme.Font
						contentLbl.TextSize = theme.FontSize
						contentLbl.TextColor3 = theme.TextSecondary
					end
					local track = notif:FindFirstChild("ProgressTrack")
					if track and track:IsA("Frame") then
						track.BackgroundColor3 = theme.ElementHover
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
			if stroke then
				stroke.Color = theme.Outline
			end
		end

		-- Command Palette (if currently open)
		if self._paletteFrame then
			self._paletteFrame.BackgroundColor3 = theme.Background
			local stroke = self._paletteFrame:FindFirstChildOfClass("UIStroke")
			if stroke then
				stroke.Color = theme.Outline
			end
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
		if self._destroyed then
			return false, "destroyed"
		end
		if type(themeOrName) == "string" then
			local builtin = Theme[themeOrName]
			if not builtin then
				return false, "Unknown built-in theme: " .. tostring(themeOrName)
			end
			self.Theme = builtin
		elseif type(themeOrName) == "table" then
			self.Theme = Theme:Override(Theme.Dark, themeOrName)
		else
			return false, "Expected a theme name (string) or theme table"
		end
		self:_ApplyTheme(self.Theme)
		return true
	end

	function Menu:SetScale(value)
		if self._destroyed then
			return false, "destroyed"
		end
		if not isFiniteNumber(value) then
			return false, "expected finite number"
		end
		value = math.clamp(value, 0.75, 1.35)
		self.Scale = value
		self:_applyResponsiveLayout()
		if not self._uiScale then
			return true
		end
		if self._reducedMotion then
			self._uiScale.Scale = value
		else
			if self._scaleTween then
				self._scaleTween:Cancel()
			end
			self._scaleTween = game:GetService("TweenService"):Create(
				self._uiScale,
				TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ Scale = value }
			)
			self._scaleTween:Play()
		end
		return true
	end

	function Menu:GetScale()
		if self._destroyed then
			return nil, "destroyed"
		end
		return self.Scale
	end

	--[[ Tooltip System ]]

	--- Bind a tooltip to any Instance.
	--- @param instance Instance — the GUI element that triggers the tooltip
	--- @param text string — tooltip text (supports RichText)
	--- @return function unbind — call to remove this tooltip binding
	function Menu:BindTooltip(instance, text)
		if self._destroyed or not instance then
			return function() end
		end

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
			if self._tooltips then
				self._tooltips[boundInstance] = nil
			end
			if self._tooltipTarget == boundInstance then
				self._tooltipPending = false
				self._tooltipTarget = nil
				self:_hideTooltip()
			end
		end

		-- MouseEnter: start delay timer
		table.insert(
			conns,
			instance.MouseEnter:Connect(function()
				if self._destroyed then
					return
				end
				self._tooltipPending = true
				self._tooltipTarget = instance
				task.delay(0.4, function()
					if not self._tooltipPending or self._tooltipTarget ~= instance or self._destroyed then
						return
					end
					if not instance or not instance.Parent then
						self._tooltipPending = false
						self._tooltipTarget = nil
						return
					end
					self:_showTooltip(text)
				end)
			end)
		)

		-- MouseLeave: hide immediately
		table.insert(
			conns,
			instance.MouseLeave:Connect(function()
				self._tooltipPending = false
				self._tooltipTarget = nil
				self:_hideTooltip()
			end)
		)

		-- Click (any mouse button on the instance): hide
		table.insert(
			conns,
			instance.InputBegan:Connect(function(input)
				if
					input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.MouseButton2
					or input.UserInputType == Enum.UserInputType.MouseButton3
				then
					self._tooltipPending = false
					self._tooltipTarget = nil
					self:_hideTooltip()
				end
			end)
		)

		self._tooltips[instance] = { unbind = disconnectAll, text = text }
		return disconnectAll
	end

	function Menu:_showTooltip(text)
		if self._destroyed or not self._tooltipLabel then
			return
		end
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
		if self._tooltipTween then
			self._tooltipTween:Cancel()
		end
		self._tooltipTween = self:_transition(label, 0.12, {
			BackgroundTransparency = 0.08,
			TextTransparency = 0,
		})
		self._tooltipActive = true
	end

	function Menu:_hideTooltip()
		if not self._tooltipLabel or not self._tooltipActive then
			return
		end
		self._tooltipActive = false
		if self._tooltipTween then
			self._tooltipTween:Cancel()
			self._tooltipTween = nil
		end

		local label = self._tooltipLabel
		self:_transition(
			label,
			0.08,
			{
				BackgroundTransparency = 1,
				TextTransparency = 1,
			},
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.In,
			function()
				label.Visible = false
			end
		)
	end

	function Menu:_updateTooltipPosition()
		if not self._tooltipLabel or not self._tooltipLabel.Visible then
			return
		end
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
			if not tab._destroyed then
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
	end

	function Menu:_indexTabComponents(components, tab, collapsible)
		for _, comp in ipairs(components) do
			if type(comp) == "table" and comp._destroyed then
				continue
			end
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
			pcall(function()
				btn:Destroy()
			end)
		end
		self._paletteResultButtons = {}

		local q = query:lower()
		local filtered = {}
		for _, item in ipairs(self._paletteIndex) do
			if (#q == 0 or item.text:lower():find(q, 1, true)) and #filtered < self._paletteMaxResults then
				table.insert(filtered, item)
			end
		end
		self._paletteFilteredResults = filtered

		if self._paletteEmpty then
			self._paletteEmpty.Visible = #filtered == 0
		end
		if not self._paletteFrame then
			return
		end
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
		if n == 0 then
			return
		end
		self._paletteSelectedIndex = self._paletteSelectedIndex + 1
		if self._paletteSelectedIndex > n then
			self._paletteSelectedIndex = 1
		end
		self:_updatePaletteSelection()
	end

	function Menu:_paletteSelectPrev()
		local n = #self._paletteFilteredResults
		if n == 0 then
			return
		end
		self._paletteSelectedIndex = self._paletteSelectedIndex - 1
		if self._paletteSelectedIndex < 1 then
			self._paletteSelectedIndex = n
		end
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
		if not result then
			return
		end
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
		if not tab.Container or not container or not container:IsDescendantOf(tab.Container) then
			return
		end
		local scroll = tab.Container
		-- Scroll the container into view
		task.spawn(function()
			task.wait(0.05)
			if not scroll or not container or not container:IsDescendantOf(scroll) then
				return
			end
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
			if not container or container.Parent == nil then
				return
			end
			local ts = game:GetService("TweenService")
			ts:Create(container, TweenInfo.new(0.4), { BackgroundTransparency = origTrans }):Play()
			task.delay(0.1, function()
				if container then
					container.BackgroundColor3 = origColor
				end
			end)
		end)
	end

	function Menu:OpenCommandPalette()
		if self._destroyed or not self.Visible or self.Minimized then
			return false, "not visible"
		end
		if self._paletteOpen then
			self:CloseCommandPalette()
		end
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
		local palW, palH = self:_modalSize(380, 310, 180, 180)
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
		table.insert(
			conns,
			self._paletteSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
				self:_filterPaletteResults(self._paletteSearchBox.Text)
			end)
		)
		table.insert(
			conns,
			uis.InputBegan:Connect(function(pi, pgpe)
				if not self._paletteOpen then
					return
				end
				if pi.UserInputType ~= Enum.UserInputType.Keyboard then
					return
				end
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
			end)
		)
		self._paletteConns = conns

		-- Show frames
		self._paletteOverlay.Visible = true
		self._paletteFrame.Visible = true

		-- Animate in
		self:_transition(self._paletteOverlay, 0.15, { BackgroundTransparency = 0.45 })
		self._paletteFrame.Size = UDim2.fromOffset(0, 0)
		self:_transition(self._paletteFrame, 0.2, { Size = UDim2.fromOffset(palW, palH) })

		-- Focus search box after a tick
		task.spawn(function()
			task.wait(0.1)
			if self._paletteSearchBox then
				self._paletteSearchBox:CaptureFocus()
			end
		end)
		return true
	end

	function Menu:CloseCommandPalette()
		if not self._paletteOpen then
			return
		end
		self._paletteOpen = false

		if self._paletteConns then
			for _, c in ipairs(self._paletteConns) do
				pcall(function()
					c:Disconnect()
				end)
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
	local FyyUI = { Version = LIBRARY_VERSION, Theme = Theme }

	function FyyUI.SetIconModule(mod)
		IconModule = mod
	end

	function FyyUI.LoadRemoteIconModule(url)
		return loadRemoteIconModule(url)
	end
	function FyyUI.GetIconModule()
		return IconModule
	end

	function FyyUI.Menu(options)
		options = options or {}
		local name = options.Theme or "Dark"
		local theme = type(name) == "string" and Theme[name] or name
		if not theme then
			theme = Theme.Dark
		end
		if type(theme) == "table" then
			theme = Theme:Override(Theme.Dark, theme)
		end
		if options.ColorOverride then
			theme = Theme:Override(theme, options.ColorOverride)
		end
		return Menu.new(options, theme)
	end

	return FyyUI
end)()
