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
