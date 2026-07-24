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
