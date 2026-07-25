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
