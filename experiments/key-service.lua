--[[ Experimental Key Service ]]
-- UI and lifecycle only. Networking, HWID, cryptography, and backend policy
-- belong to the external Validate/GetKey callbacks supplied by the loader.

local KeyServiceController = {}
KeyServiceController.__index = KeyServiceController

local KEY_SERVICE_STATES = {
	idle = true,
	validating = true,
	authorized = true,
	invalid = true,
	error = true,
	disabled = true,
}

local function keyServiceColor(theme, state)
	if state == "authorized" then return theme.ToggleOn end
	if state == "invalid" or state == "error" then return Color3.fromRGB(235, 95, 95) end
	if state == "validating" then return theme.Accent end
	return theme.TextMuted
end

local function keyServiceMessage(state)
	local messages = {
		idle = "Waiting for a license key.",
		validating = "Validating your license…",
		authorized = "Access granted. Loading the mapped runtime…",
		invalid = "The license could not be validated.",
		error = "Validation is temporarily unavailable.",
		disabled = "Key Service is disabled.",
	}
	return messages[state]
end

local function normalizeValidationResult(result, secondary)
	if type(result) == "boolean" then
		return {
			Success = result,
			State = result and "authorized" or "invalid",
			Message = type(secondary) == "string" and secondary or nil,
		}
	end
	if type(result) ~= "table" or type(result.Success) ~= "boolean" then
		return nil, "Validate must return a boolean or result table"
	end
	local state = result.State or (result.Success and "authorized" or "invalid")
	if not KEY_SERVICE_STATES[state] or state == "idle" or state == "validating" or state == "disabled" then
		return nil, "Validate returned an unsupported terminal state"
	end
	if (result.Success and state ~= "authorized") or (not result.Success and state ~= "invalid" and state ~= "error") then
		return nil, "Validate returned an inconsistent success state"
	end
	return {
		Success = result.Success,
		State = state,
		Message = type(result.Message) == "string" and result.Message or nil,
		Metadata = result.Metadata,
		Context = result.Context,
	}
end

local function validateKeyServiceOptions(options)
	if type(options) ~= "table" then return false, "expected options table" end
	if options.Mode ~= nil and options.Mode ~= "Gate" and options.Mode ~= "Embedded" then
		return false, "Mode must be Gate or Embedded"
	end
	if options.Enabled ~= nil and type(options.Enabled) ~= "boolean" then
		return false, "Enabled must be a boolean"
	end
	for _, name in ipairs({ "Validate", "OnAuthorized", "OnStateChanged", "GetKey" }) do
		if options[name] ~= nil and type(options[name]) ~= "function" then
			return false, name .. " must be a function"
		end
	end
	if type(options.Validate) ~= "function" then return false, "Validate callback required" end
	return true
end

function KeyServiceController:_setInteractive(enabled)
	local input = self.KeyInput
	if input and input.TextBox then
		input.TextBox.TextEditable = enabled
		input.TextBox.Active = enabled
		input.TextBox.Selectable = enabled
		input.TextBox.BackgroundTransparency = enabled and 0 or 0.35
	end
	local button = self.ValidateButton
	if button and button.Container then
		button.Container.Active = enabled
		button.Container.Selectable = enabled
		button.Container.BackgroundTransparency = enabled and 0 or 0.35
	end
end

function KeyServiceController:_clearKey()
	if self.KeyInput then
		pcall(function() self.KeyInput:SetValue("", true) end)
	end
end

function KeyServiceController:SetState(state, message)
	if self._destroyed then return false, "destroyed" end
	if not KEY_SERVICE_STATES[state] then return false, "unsupported state" end
	self.State = state
	self.Message = type(message) == "string" and message or keyServiceMessage(state)
	if self.StatusCard then
		self.StatusCard:SetStatus(self.Message, keyServiceColor(self.Menu.Theme, state))
	end
	self:_setInteractive(self.Enabled and state ~= "validating" and state ~= "authorized")
	if type(self.Options.OnStateChanged) == "function" then
		task.spawn(self.Options.OnStateChanged, state, self.Message, self)
	end
	return true
end

function KeyServiceController:GetState()
	return self.State
end

function KeyServiceController:GetEnabled()
	return self.Enabled
end

local function keyInputFactory(context, options)
	local theme = context.Theme
	local controller = {}
	controller.Container = context.Create("Frame", {
		Name = "KeyServiceInput",
		Size = UDim2.new(1, -12, 0, 68),
		Position = UDim2.fromOffset(6, 0),
		BackgroundColor3 = theme.Element,
		BorderSizePixel = 0,
		Parent = context.Parent,
	})
	context.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = controller.Container })
	context.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = controller.Container })
	controller.Label = context.Create("TextLabel", {
		Name = "Label",
		Size = UDim2.new(1, -20, 0, 18),
		Position = UDim2.fromOffset(10, 5),
		BackgroundTransparency = 1,
		Text = options.Text or "License Key",
		Font = theme.FontBold,
		TextSize = theme.FontSizeSmall,
		TextColor3 = theme.TextSecondary,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = controller.Container,
	})
	controller.TextBox = context.Create("TextBox", {
		Name = "TextBox",
		Size = UDim2.new(1, -20, 0, 32),
		Position = UDim2.fromOffset(10, 29),
		BackgroundColor3 = theme.ElementHover,
		BorderSizePixel = 0,
		ClearTextOnFocus = false,
		MultiLine = false,
		Text = "",
		PlaceholderText = options.Placeholder or "FYY-PREMIUM-...",
		PlaceholderColor3 = theme.TextMuted,
		TextColor3 = theme.TextPrimary,
		Font = Enum.Font.Code,
		TextSize = theme.FontSizeSmall,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = controller.Container,
	})
	context.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = controller.TextBox })
	context.Create("UIPadding", {
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
		Parent = controller.TextBox,
	})
	controller.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
		local normalized = controller.TextBox.Text:gsub("[\r\n]+", " ")
		if normalized ~= controller.TextBox.Text then controller.TextBox.Text = normalized end
	end)
	controller.TextBox.FocusLost:Connect(function(enterPressed)
		if enterPressed and type(options.OnSubmit) == "function" then options.OnSubmit() end
	end)
	function controller:SetValue(value)
		if self._destroyed then return false, "destroyed" end
		self.TextBox.Text = type(value) == "string" and value or tostring(value or "")
		return true
	end
	function controller:GetValue()
		return self._destroyed and "" or self.TextBox.Text
	end
	function controller:Focus()
		if self._destroyed then return false, "destroyed" end
		self.TextBox:CaptureFocus()
		return true
	end
	function controller:ApplyTheme(nextTheme)
		theme = nextTheme
		if self._destroyed then return end
		self.Container.BackgroundColor3 = theme.Element
		local stroke = self.Container:FindFirstChildOfClass("UIStroke")
		if stroke then stroke.Color = theme.ElementBorder end
		self.Label.Font = theme.FontBold
		self.Label.TextSize = theme.FontSizeSmall
		self.Label.TextColor3 = theme.TextSecondary
		self.TextBox.BackgroundColor3 = theme.ElementHover
		self.TextBox.TextColor3 = theme.TextPrimary
		self.TextBox.PlaceholderColor3 = theme.TextMuted
	end
	function controller:Destroy()
		if self._destroyed then return end
		self._destroyed = true
		self.TextBox.Text = ""
		self.Container:Destroy()
	end
	return controller
end

function KeyServiceController:_mount()
	if self._destroyed or not self.Enabled or self.Tab then return end
	if self.Mode == "Gate" and #self.Menu.Tabs > 0 then
		return false, "Gate mode must mount before runtime tabs"
	end
	local tab = self.Menu:Tab({
		Text = self.Options.TabName or "Access",
		Icon = self.Options.TabIcon or "key-round",
		Tooltip = self.Options.Tooltip or "License access",
	})
	self.Tab = tab
	tab:BoldLabel({
		Text = self.Options.Title or "Fyy License Access",
		Description = self.Options.Description or "Secure key validation for this runtime.",
	})
	self.StatusCard = tab:Description({
		Title = self.Options.CardTitle or "ACCESS REQUIRED",
		Description = self.Options.CardDescription or "Enter your license key to unlock this runtime.",
		Footer = self.Options.CardFooter or "Keys are kept in memory only and are never saved by FyyUI.",
		Status = keyServiceMessage("idle"),
	})
	self.KeyInput = tab:Custom(keyInputFactory, {
		Text = self.Options.InputText or "License Key",
		Placeholder = self.Options.Placeholder or "FYY-PREMIUM-...",
		OnSubmit = function() self:Authorize() end,
	})
	self.ValidateButton = tab:Button({
		Text = self.Options.ButtonText or "Validate And Continue",
		Description = self.Options.ButtonDescription or "Verify this license for the current runtime",
		Icon = self.Options.ButtonIcon or "shield-check",
		Callback = function() self:Authorize() end,
	})
	if type(self.Options.GetKey) == "function" then
		self.GetKeyButton = tab:Button({
			Text = self.Options.GetKeyText or "Get Free Key",
			Description = self.Options.GetKeyDescription or "Open the official access flow",
			Icon = self.Options.GetKeyIcon or "external-link",
			Callback = function()
				if self._destroyed or not self.Enabled or self.State == "validating" then return end
				local ok, result = pcall(self.Options.GetKey, self)
				if not ok then
					self.Menu:Notify({ Title = "Get Key Unavailable", Content = tostring(result), Type = "Error", Duration = 3 })
				end
			end,
		})
	end
	self:SetState("idle")
	return true
end

function KeyServiceController:SetEnabled(enabled)
	if self._destroyed then return false, "destroyed" end
	if type(enabled) ~= "boolean" then return false, "expected boolean" end
	if self.Enabled == enabled then return true end
	self.Enabled = enabled
	self._requestToken += 1
	self:_clearKey()
	if enabled then
		local mounted, mountError = self:_mount()
		if mounted == false then
			self.Enabled = false
			return false, mountError
		end
	else
		if self.Tab then self.Tab:Destroy() end
		self.Tab = nil
		self.StatusCard = nil
		self.KeyInput = nil
		self.ValidateButton = nil
		self.GetKeyButton = nil
		self.State = "disabled"
		self.Message = keyServiceMessage("disabled")
	end
	return true
end

function KeyServiceController:Authorize(rawKey)
	if self._destroyed then return false, "destroyed" end
	if not self.Enabled then return false, "disabled" end
	if self.State == "validating" or self.State == "authorized" then return false, "busy" end
	local value = rawKey
	if value == nil and self.KeyInput then value = self.KeyInput:GetValue() end
	if type(value) ~= "string" then value = "" end
	value = value:match("^%s*(.-)%s*$") or ""
	if value == "" then
		self:SetState("invalid", "Enter a license key before continuing.")
		if self.KeyInput then self.KeyInput:Focus() end
		return false, "empty"
	end

	self._requestToken += 1
	local requestToken = self._requestToken
	self:SetState("validating", self.Options.ValidatingText)
	task.spawn(function()
		local ok, primary, secondary = pcall(self.Options.Validate, value, {
			Menu = self.Menu,
			Service = self,
			Mode = self.Mode,
		})
		value = nil
		if self._destroyed or requestToken ~= self._requestToken then return end
		self:_clearKey()
		if not ok then
			self:SetState("error", self.Options.ErrorText or "Validation failed. Try again.")
			return
		end
		local result, resultError = normalizeValidationResult(primary, secondary)
		if not result then
			self:SetState("error", resultError)
			return
		end
		if not result.Success then
			self:SetState(result.State, result.Message)
			return
		end

		self:SetState("authorized", result.Message)
		if type(self.Options.OnAuthorized) == "function" then
			local mounted, mountError = pcall(self.Options.OnAuthorized, result, self)
			if not mounted then
				self:SetState("error", "Runtime setup failed: " .. tostring(mountError))
				return
			end
		end
		if self.Mode == "Gate" and self.Tab then
			self.Tab:Destroy()
			self.Tab = nil
			self.StatusCard = nil
			self.KeyInput = nil
			self.ValidateButton = nil
			self.GetKeyButton = nil
		end
	end)
	return true
end

function KeyServiceController:Reset()
	if self._destroyed then return false, "destroyed" end
	self._requestToken += 1
	self:_clearKey()
	if self.Enabled and not self.Tab then
		local mounted, mountError = self:_mount()
		if mounted == false then return false, mountError end
	end
	return self:SetState(self.Enabled and "idle" or "disabled")
end

function KeyServiceController:Destroy()
	if self._destroyed then return end
	self._destroyed = true
	self._requestToken += 1
	self:_clearKey()
	if self.Tab then self.Tab:Destroy() end
	self.Tab = nil
	self.StatusCard = nil
	self.KeyInput = nil
	self.ValidateButton = nil
	self.GetKeyButton = nil
	if self.Menu and self.Menu._keyServices then
		for index, service in ipairs(self.Menu._keyServices) do
			if service == self then table.remove(self.Menu._keyServices, index); break end
		end
	end
end

function Menu:KeyService(options)
	if self._destroyed then return nil, "destroyed" end
	local valid, validationError = validateKeyServiceOptions(options)
	if not valid then return nil, validationError end
	local service = setmetatable({
		Menu = self,
		Options = options,
		Mode = options.Mode or "Embedded",
		Enabled = options.Enabled ~= false,
		State = options.Enabled == false and "disabled" or "idle",
		Message = keyServiceMessage(options.Enabled == false and "disabled" or "idle"),
		_requestToken = 0,
		_destroyed = false,
	}, KeyServiceController)
	self._keyServices = self._keyServices or {}
	table.insert(self._keyServices, service)
	self:OnDestroy(function() service:Destroy() end)
	if service.Enabled then
		local mounted, mountError = service:_mount()
		if mounted == false then
			service:Destroy()
			return nil, mountError
		end
	end
	return service
end
