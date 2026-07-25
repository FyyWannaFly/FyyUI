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
