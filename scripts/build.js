#!/usr/bin/env node

const fs = require("node:fs");
const path = require("node:path");

const ROOT = path.resolve(__dirname, "..");
const OUTPUT = path.join(ROOT, "fyyui.lua");
const SOURCE_ROOT = path.join(ROOT, "src");
const SOURCES = [
	"src/bootstrap.lua",
	"src/components/toggle.lua",
	"src/components/slider.lua",
	"src/components/dropdown.lua",
	"src/components/keybind.lua",
	"src/components/input.lua",
	"src/components/checkbox.lua",
	"src/layout/columns.lua",
	"src/layout/collapsible.lua",
	"src/navigation/tab.lua",
	"src/menu/constructor.lua",
	"src/menu/navigation.lua",
	"src/menu/overview.lua",
	"src/menu/config.lua",
	"src/menu/notifications.lua",
	"src/menu/window.lua",
	"src/menu/theme_tooltip.lua",
	"src/menu/palette.lua",
	"src/export.lua",
];

const HEADER = `--[[
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
`;

function normalize(text) {
	return text.replace(/^\uFEFF/, "").replace(/\r\n?/g, "\n").replace(/\s*$/, "");
}

function indent(text) {
	return normalize(text)
		.split("\n")
		.map((line) => (line.length > 0 ? `\t${line}` : ""))
		.join("\n");
}

function build() {
	const chunks = SOURCES.map((relativePath) => {
		const absolutePath = path.join(ROOT, relativePath);
		if (!fs.existsSync(absolutePath)) {
			throw new Error(`Missing source file: ${relativePath}`);
		}
		return indent(fs.readFileSync(absolutePath, "utf8"));
	});
	return `${HEADER}${chunks.join("\n")}\nend)()\n`;
}

function listLuaFiles(directory) {
	return fs.readdirSync(directory, { withFileTypes: true }).flatMap((entry) => {
		const absolutePath = path.join(directory, entry.name);
		return entry.isDirectory() ? listLuaFiles(absolutePath) : entry.name.endsWith(".lua") ? [absolutePath] : [];
	});
}

const discovered = listLuaFiles(SOURCE_ROOT)
	.map((absolutePath) => path.relative(ROOT, absolutePath).replace(/\\/g, "/"))
	.sort();
const declared = [...SOURCES].sort();
if (JSON.stringify(discovered) !== JSON.stringify(declared)) {
	throw new Error("Source manifest mismatch: every src/**/*.lua file must appear exactly once in SOURCES");
}

const output = build();
if (process.argv.includes("--check")) {
	const current = fs.existsSync(OUTPUT) ? fs.readFileSync(OUTPUT, "utf8").replace(/^\uFEFF/, "").replace(/\r\n?/g, "\n") : "";
	if (current !== output) {
		console.error("fyyui.lua is stale. Run: node scripts/build.js");
		process.exit(1);
	}
	console.log(`fyyui.lua is synchronized with ${SOURCES.length} source files.`);
} else {
	fs.writeFileSync(OUTPUT, output, "utf8");
	console.log(`Built fyyui.lua from ${SOURCES.length} source files.`);
}
