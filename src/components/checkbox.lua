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
