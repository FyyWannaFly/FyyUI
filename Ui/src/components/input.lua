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
