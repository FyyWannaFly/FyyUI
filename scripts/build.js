#!/usr/bin/env node

const fs = require("node:fs");
const path = require("node:path");

const ROOT = path.resolve(__dirname, "..");
const STABLE_OUTPUT = path.join(ROOT, "FyyUI.lua");
const SECONDARY_OUTPUT = path.join(ROOT, "FyyUISec.lua");
const BUILD_SECONDARY = process.argv.includes("--sec");
const OUTPUT = BUILD_SECONDARY ? SECONDARY_OUTPUT : STABLE_OUTPUT;
const SOURCE_ROOT = path.join(ROOT, "src");
const SOURCES = [
	"src/bootstrap.lua",
	"src/components/toggle.lua",
	"src/components/slider.lua",
	"src/components/dropdown.lua",
	"src/components/keybind.lua",
	"src/components/input.lua",
	"src/components/checkbox.lua",
	"src/components/description.lua",
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

const VENDOR_ICONS = path.join(ROOT, "vendor/footagesus-icons/lucide/dist/Icons.lua");

function buildRegistryChunk() {
	if (!fs.existsSync(VENDOR_ICONS)) {
		console.warn("WARN: Vendored Icons.lua not found at " + VENDOR_ICONS + "; icon registry will be empty.");
		return "--[[ Icon Registry — NOT AVAILABLE (vendor missing) ]]\nIconModule = {}\n";
	}
	let content = fs.readFileSync(VENDOR_ICONS, "utf8").trim();
	// Strip leading comments and "return" so the table literal can be assigned inline
	content = content.replace(/^(?:\s*--[^\n]*\n?)*\s*return\s+/, "");
	return [
		`--[[ Vendored Icon Registry — Footagesus/Icons (MIT) ]]`,
		`-- Vendored from Footagesus/Icons (MIT) -- https://github.com/Footagesus/Icons`,
		`-- FyyUI custom logos (fyyui-title-logo, fyyui-floating-logo) are embedded directly in Icons.lua`,
		`do`,
		`\tIconModule = ${content}`,
		`end`,
		`-- Spawn remote fetch after embedded assignment; success overrides, failure keeps fallback.`,
		`task.spawn(function()`,
		`\tlocal ok, err = loadRemoteIconModule()`,
		`\tif not ok then end -- silence fetch failure`,
		`end)`,
	].join("\n");
}

const HEADER = `--[[
FyyUI v0.19.0
Copyright (c) 2026 FyyWannaFly. All rights reserved.
Licensed for limited personal use under the repository LICENSE.
Unauthorized copying, modification, or redistribution is prohibited.
https://github.com/FyyWannaFly/FyyUI
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
	// Inject vendored icon registry after bootstrap.lua (index 0)
	const registryChunk = buildRegistryChunk();
	chunks.splice(1, 0, indent(registryChunk));
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
		console.error("FyyUI.lua is stale. Run: node scripts/build.js");
		process.exit(1);
	}
	console.log(`${path.basename(OUTPUT)} is synchronized with ${SOURCES.length} source files.`);
} else {
	fs.writeFileSync(OUTPUT, output, "utf8");
	console.log(`Built ${path.basename(OUTPUT)} from ${SOURCES.length} source files.`);
}
