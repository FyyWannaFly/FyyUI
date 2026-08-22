local function applyConfigValue(ctrl, value, noCallbacks)
	local setter = ctrl.SetValue or ctrl.SetKey
	if not setter then
		return false, "controller has no config setter"
	end

	-- A single-select dropdown treats selecting its active value as a user click
	-- that clears the selection when AllowNone=true. Config restore is an
	-- assignment, not a click: preserve an already-matching saved value.
	if ctrl.Options and not ctrl.Multi and ctrl.GetValue and ctrl:GetValue() == value then
		if not noCallbacks and type(ctrl.Callback) == "function" then
			task.spawn(ctrl.Callback, value)
		end
		return true
	end

	if ctrl._setValueNoCallbackPosition == 3 then
		return setter(ctrl, value, false, noCallbacks)
	end
	return setter(ctrl, value, noCallbacks)
end

function Menu:_trackFlagged(ctrl)
	if ctrl.Flag then
		ctrl._menu = self
		if self._flagRegistry[ctrl.Flag] ~= nil then
			warn(("[FyyUI] Duplicate Flag '%s' — overwriting previous controller"):format(ctrl.Flag))
		end
		self._flagRegistry[ctrl.Flag] = ctrl
		local pending = self._pendingConfigValues and self._pendingConfigValues[ctrl.Flag]
		if pending then
			local ok, applied = pcall(applyConfigValue, ctrl, pending.Value, pending.NoCallbacks)
			if ok and applied ~= false then
				self._pendingConfigValues[ctrl.Flag] = nil
			end
		end
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
	local details = { Applied = {}, Failed = {}, Unknown = {}, Pending = {} }
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
					return applyConfigValue(ctrl, value, noCallbacks)
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
			if options and options.DeferUnknown == true then
				self._pendingConfigValues[flag] = { Value = value, NoCallbacks = noCallbacks }
				table.insert(details.Pending, flag)
			end
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

local ConfigTabController = {}
ConfigTabController.__index = ConfigTabController

local function configEnvironment()
	return type(getgenv) == "function" and getgenv() or _G
end

local function sanitizeProfileName(name)
	if type(name) ~= "string" then
		return nil, "expected profile name"
	end
	name = name:match("^%s*(.-)%s*$") or ""
	if name == "" or #name > 48 or name:find("[\\/%.:]") or not name:match("^[%w _%-]+$") then
		return nil, "profile names may contain letters, numbers, spaces, _ and -"
	end
	return name
end

local function defaultConfigStorage(folder)
	local env = configEnvironment()
	for _, key in ipairs({ "isfolder", "makefolder", "isfile", "readfile", "writefile", "listfiles", "delfile" }) do
		if type(env[key]) ~= "function" then
			return nil, "persistent storage is unavailable"
		end
	end
	local function ensureFolder()
		if not env.isfolder(folder) then
			env.makefolder(folder)
		end
	end
	return {
		List = function()
			ensureFolder()
			local profiles = {}
			for _, path in ipairs(env.listfiles(folder)) do
				local file = tostring(path):gsub("\\", "/"):match("([^/]+)%.json$")
				if file and file ~= ".autoload" then
					table.insert(profiles, file)
				end
			end
			table.sort(profiles)
			return profiles
		end,
		Read = function(name)
			ensureFolder()
			local path = folder .. "/" .. name .. ".json"
			if not env.isfile(path) then
				return nil, "profile not found"
			end
			return env.readfile(path)
		end,
		Write = function(name, json)
			ensureFolder()
			env.writefile(folder .. "/" .. name .. ".json", json)
			return true
		end,
		Delete = function(name)
			local path = folder .. "/" .. name .. ".json"
			if env.isfile(path) then
				env.delfile(path)
			end
			return true
		end,
	}
end

local function normalizeStorage(storage, folder)
	if storage == nil then
		return defaultConfigStorage(folder)
	end
	if type(storage) ~= "table" then
		return nil, "Storage must be a table"
	end
	for _, method in ipairs({ "List", "Read", "Write", "Delete" }) do
		if type(storage[method]) ~= "function" then
			return nil, "Storage must provide List, Read, Write and Delete"
		end
	end
	return storage
end

function ConfigTabController:_notify(title, content, kind)
	self.Menu:Notify({ Title = title, Content = content, Type = kind or "Info", Duration = 3 })
end

function ConfigTabController:_call(method, ...)
	if not self.Storage then
		return false, self.StorageError
	end
	local ok, result, extra = pcall(self.Storage[method], ...)
	if not ok then
		return false, tostring(result)
	end
	if result == nil or result == false then
		return false, extra or "storage operation failed"
	end
	return true, result
end

function ConfigTabController:GetProfiles()
	local ok, profiles = self:_call("List")
	return ok and profiles or nil, ok and nil or profiles
end

function ConfigTabController:Refresh(preferred)
	local profiles, err = self:GetProfiles()
	if not profiles then
		if self.Status then
			self.Status.TextLabel.Text = self.StorageError or err
		end
		return false, err
	end
	self.Profiles = profiles
	local selected = preferred or self.SelectedProfile or self.DefaultProfile
	local options = profiles
	if #options == 0 then
		options = { "No profiles" }
		selected = "No profiles"
	elseif not table.find(options, selected) then
		selected = options[1]
	end
	self.SelectedProfile = selected ~= "No profiles" and selected or nil
	self.ProfileDropdown:SetOptions(options, selected, true)
	if self.Status then
		self.Status.TextLabel.Text = self.SelectedProfile and ("Selected: " .. self.SelectedProfile)
			or "No saved profiles"
	end
	return true, self.Profiles
end

function ConfigTabController:Save(name)
	name = name or self.NameInput:GetValue()
	if name == "" then
		name = self.SelectedProfile or self.DefaultProfile
	end
	local safe, err = sanitizeProfileName(name)
	if not safe then
		return false, err
	end
	local json, exportError = self.Menu:ExportConfigJSON()
	if not json then
		return false, exportError
	end
	local ok, writeError = self:_call("Write", safe, json)
	if not ok then
		return false, writeError
	end
	self.SelectedProfile = safe
	self.NameInput:SetValue(safe, true)
	self:Refresh(safe)
	return true, safe
end

function ConfigTabController:Load(name)
	local safe, err = sanitizeProfileName(name or self.SelectedProfile)
	if not safe then
		return false, err
	end
	local ok, json = self:_call("Read", safe)
	if not ok then
		return false, json
	end
	local imported, details =
		self.Menu:ImportConfigJSON(json, { NoCallbacks = not self.LoadCallbacks, DeferUnknown = true })
	if not imported then
		return false, details
	end
	self.SelectedProfile = safe
	return true, details
end

function ConfigTabController:Delete(name)
	local safe, err = sanitizeProfileName(name or self.SelectedProfile)
	if not safe then
		return false, err
	end
	local ok, deleteError = self:_call("Delete", safe)
	if not ok then
		return false, deleteError
	end
	if self.AutoloadProfile == safe then
		self:ClearAutoload()
	end
	self.SelectedProfile = nil
	self:Refresh()
	return true
end

function ConfigTabController:_writeAutoload()
	local httpService = game:GetService("HttpService")
	local ok, metadata = pcall(httpService.JSONEncode, httpService, {
		Enabled = self.AutoloadEnabled,
		Profile = self.AutoloadProfile,
	})
	if not ok then
		return false, "failed to encode autoload metadata"
	end
	return self:_call("Write", ".autoload", metadata)
end

function ConfigTabController:SetAutoload(name)
	local safe, err = sanitizeProfileName(name or self.SelectedProfile)
	if not safe then
		return false, err
	end
	self.AutoloadEnabled, self.AutoloadProfile = true, safe
	self.AutoloadToggle:SetValue(true, true, true)
	local ok, writeError = self:_writeAutoload()
	if ok then
		self.AutoloadStatus.TextLabel.Text = "Autoload: " .. safe
	end
	return ok, writeError or safe
end

function ConfigTabController:ClearAutoload()
	self.AutoloadEnabled, self.AutoloadProfile = false, nil
	self.AutoloadToggle:SetValue(false, true, true)
	local ok, err = self:_writeAutoload()
	self.AutoloadStatus.TextLabel.Text = "Autoload is disabled"
	return ok, err
end

function ConfigTabController:_readAutoload()
	local ok, json = self:_call("Read", ".autoload")
	if not ok then
		return false, json
	end
	local httpService = game:GetService("HttpService")
	local decodedOk, decoded = pcall(httpService.JSONDecode, httpService, json)
	if not decodedOk or type(decoded) ~= "table" then
		return false, "invalid autoload metadata"
	end
	local safe = sanitizeProfileName(decoded.Profile)
	self.AutoloadEnabled = decoded.Enabled == true and safe ~= nil
	self.AutoloadProfile = safe
	self.AutoloadToggle:SetValue(self.AutoloadEnabled, true, true)
	self.AutoloadStatus.TextLabel.Text = self.AutoloadEnabled and ("Autoload: " .. safe) or "Autoload is disabled"
	return true
end

function ConfigTabController:Destroy()
	if self._destroyed then
		return
	end
	if self.Tab and not self.Tab._destroyed then
		self.Tab:Destroy()
	end
	self._destroyed = true
end

function Menu:ConfigTab(options)
	if self._destroyed then
		return nil, "destroyed"
	end
	options = options or {}
	assert(type(options) == "table", "FyyUI ConfigTab: options must be a table")
	local folder = options.Folder or "FyyUI/Configs"
	assert(type(folder) == "string" and folder ~= "" and not folder:find("%.%."), "FyyUI ConfigTab: invalid Folder")
	local storage, storageError = normalizeStorage(options.Storage, folder)
	local controller = setmetatable({
		Menu = self,
		Folder = folder,
		Storage = storage,
		StorageError = storageError,
		DefaultProfile = options.DefaultProfile or "Default",
		LoadCallbacks = options.LoadCallbacks == true,
		AllowDelete = options.AllowDelete ~= false,
		AllowImportExport = options.AllowImportExport ~= false,
		Profiles = {},
	}, ConfigTabController)
	local tab = self:Tab({ Text = options.Text or "Config", Icon = options.Icon or "settings-2" })
	controller.Tab = tab
	tab._configController = controller
	table.insert(self._configTabs, controller)
	local baseTabDestroy = tab.Destroy
	tab.Destroy = function(configTab)
		for i = #self._configTabs, 1, -1 do
			if self._configTabs[i] == controller then
				table.remove(self._configTabs, i)
			end
		end
		controller._destroyed = true
		baseTabDestroy(configTab)
	end

	local profiles = tab:Collapsible("Configurations", { DefaultOpen = true })
	controller.ProfileDropdown = profiles:Dropdown({
		Text = "Profile",
		Options = { "No profiles" },
		Default = "No profiles",
		Callback = function(value)
			if value ~= "No profiles" then
				controller.SelectedProfile = value
				if controller.NameInput then
					controller.NameInput:SetValue(value, true)
				end
			end
		end,
	})
	controller.NameInput =
		profiles:Input({ Text = "Profile Name", Placeholder = controller.DefaultProfile, ClearOnFocus = false })
	local profileActions = profiles:Columns({ Count = 2, Ratios = { 1, 1 }, Gap = 8 })
	profileActions:Column(1):Button({
		Text = "Save Config",
		Icon = "save",
		Callback = function()
			local ok, result = controller:Save()
			controller:_notify(ok and "Config Saved" or "Save Failed", tostring(result), ok and "Success" or "Error")
		end,
	})
	profileActions:Column(2):Button({
		Text = "Load Config",
		Icon = "folder-open",
		Callback = function()
			local ok, result = controller:Load()
			controller:_notify(
				ok and "Config Loaded" or "Load Failed",
				ok and tostring(controller.SelectedProfile) or tostring(result),
				ok and "Success" or "Error"
			)
		end,
	})
	local profileManage = profiles:Columns({ Count = 2, Ratios = { 1, 1 }, Gap = 8 })
	profileManage:Column(1):Button({
		Text = "Refresh",
		Icon = "refresh-cw",
		Callback = function()
			controller:Refresh()
		end,
	})
	if controller.AllowDelete then
		profileManage:Column(2):Button({
			Text = "Delete Config",
			Icon = "trash-2",
			Color = Color3.fromRGB(235, 95, 95),
			Callback = function()
				local ok, result = controller:Delete()
				controller:_notify(
					ok and "Config Deleted" or "Delete Failed",
					ok and "Selected profile deleted." or tostring(result),
					ok and "Success" or "Error"
				)
			end,
		})
	end
	controller.Status = profiles:Label({ Text = storage and "No saved profiles" or storageError })

	local autoload = tab:Collapsible("Autoload", { DefaultOpen = true })
	controller.AutoloadToggle = autoload:Toggle({
		Text = "Load on Execute",
		Default = false,
		Callback = function(enabled)
			controller.AutoloadEnabled = enabled
			controller:_writeAutoload()
		end,
	})
	controller.AutoloadStatus = autoload:Label({ Text = "Autoload is disabled" })
	local autoActions = autoload:Columns({ Count = 2, Ratios = { 1, 1 }, Gap = 8 })
	autoActions:Column(1):Button({
		Text = "Set Selected",
		Icon = "zap",
		Callback = function()
			local ok, result = controller:SetAutoload()
			controller:_notify(
				ok and "Autoload Set" or "Autoload Failed",
				tostring(result),
				ok and "Success" or "Error"
			)
		end,
	})
	autoActions:Column(2):Button({
		Text = "Clear Autoload",
		Icon = "x",
		Callback = function()
			local ok, result = controller:ClearAutoload()
			controller:_notify(
				ok and "Autoload Cleared" or "Autoload Failed",
				ok and "Autoload is disabled." or tostring(result),
				ok and "Success" or "Error"
			)
		end,
	})

	if controller.AllowImportExport then
		local transfer = tab:Collapsible("Import & Export", { DefaultOpen = true })
		controller.JsonInput =
			transfer:Input({ Text = "Config JSON", Placeholder = "Paste JSON", ClearOnFocus = false })
		local transferActions = transfer:Columns({ Count = 2, Ratios = { 1, 1 }, Gap = 8 })
		transferActions:Column(1):Button({
			Text = "Copy JSON",
			Icon = "copy",
			Callback = function()
				local json, err = self:ExportConfigJSON()
				if not json then
					controller:_notify("Export Failed", tostring(err), "Error")
					return
				end
				controller.JsonInput:SetValue(json, true)
				local env = configEnvironment()
				local copied = type(env.setclipboard) == "function" and pcall(env.setclipboard, json)
				controller:_notify(
					"Config Exported",
					copied and "JSON copied to clipboard." or "JSON placed in the input field.",
					"Success"
				)
			end,
		})
		transferActions:Column(2):Button({
			Text = "Import JSON",
			Icon = "download",
			Callback = function()
				local ok, details = self:ImportConfigJSON(
					controller.JsonInput:GetValue(),
					{ NoCallbacks = not controller.LoadCallbacks, DeferUnknown = true }
				)
				controller:_notify(
					ok and "Config Imported" or "Import Failed",
					ok and ("Applied %d values."):format(#details.Applied) or tostring(details),
					ok and "Success" or "Error"
				)
			end,
		})
	end

	controller:Refresh()
	controller:_readAutoload()
	if options.AutoLoad ~= false and controller.AutoloadEnabled and controller.AutoloadProfile then
		local ok, err = controller:Load(controller.AutoloadProfile)
		if not ok then
			controller:_notify("Autoload Failed", tostring(err), "Warning")
		end
	end
	return controller
end
