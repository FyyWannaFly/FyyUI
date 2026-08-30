local source = game:HttpGet("https://raw.githubusercontent.com/FyyWannaFly/FyyUI/main/FyyUIKeyService.lua")
local FyyUI = assert(loadstring(source))()

local menu = FyyUI.Menu({
	Title = "Fyy Community Key Service",
	Theme = "Amoled",
	Size = UDim2.fromOffset(601, 344),
	Resizable = true,
	Responsive = true,
	CompactBreakpoint = 640,
	SafePadding = 12,
	TouchTargetSize = 44,
	ReducedMotion = false,
	Stats = false,
})

local function mountRuntime()
	local main = menu:Tab({ Text = "Main", Icon = "home" })
	main:BoldLabel({ Text = "Runtime Ready", Description = "The mock authorization gate completed successfully." })
	main:Description({
		Title = "LOCAL PROTOTYPE",
		Description = "No backend, HWID, cryptography, session, or script payload is used by this demo.",
		Status = "Authorized",
	})
	main:Button({
		Text = "Reset Prototype",
		Description = "Mount the Access gate again",
		Icon = "rotate-ccw",
		Callback = function()
			for _, tab in ipairs(table.clone(menu.Tabs)) do
				if tab ~= nil then tab:Destroy() end
			end
			if menu.KeyServiceController then menu.KeyServiceController:Reset() end
		end,
	})
end

local access = menu:KeyService({
	Mode = "Gate",
	Enabled = true,
	Title = "Fyy License Access",
	Description = "Enter a local test key to unlock this prototype.",
	CardTitle = "ACCESS REQUIRED",
	CardDescription = "Use FYY-TEST-VALID for success. Any other value demonstrates the invalid state.",
	CardFooter = "Prototype only · no network request is made",
	Placeholder = "FYY-TEST-VALID",
	Validate = function(key)
		task.wait(1)
		if key == "FYY-TEST-VALID" then
			return {
				Success = true,
				State = "authorized",
				Message = "Access granted. Loading the local prototype…",
				Metadata = { Tier = "Premium" },
			}
		end
		return {
			Success = false,
			State = "invalid",
			Message = "Invalid test key. Use FYY-TEST-VALID.",
		}
	end,
	GetKey = function(service)
		local copied = false
		pcall(function()
			if type(setclipboard) == "function" then
				setclipboard("FYY-TEST-VALID")
				copied = true
			end
		end)
		service.Menu:Notify({
			Title = "Test Key",
			Content = copied and "FYY-TEST-VALID copied to clipboard." or "Use FYY-TEST-VALID.",
			Type = "Info",
			Duration = 3,
		})
	end,
	OnAuthorized = function()
		mountRuntime()
	end,
})

menu.KeyServiceController = access
