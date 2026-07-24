#!/usr/bin/env node

const fs = require("node:fs");
const path = require("node:path");

const ROOT = path.resolve(__dirname, "..");
const INPUT = process.argv.slice(2).find((argument) => !argument.startsWith("--"));
const SOURCE_PATH = INPUT ? path.resolve(ROOT, INPUT) : path.join(ROOT, "fyyui.lua");
const FORCE = process.argv.includes("--force");

if (!FORCE) {
	console.error("Refusing to overwrite src/. Re-run with --force only when intentionally re-extracting a monolith.");
	process.exit(1);
}
const source = fs.readFileSync(SOURCE_PATH, "utf8").replace(/\r\n?/g, "\n");

const modules = [
	["src/bootstrap.lua", 15, 557],
	["src/components/toggle.lua", 558, 758],
	["src/components/slider.lua", 759, 1045],
	["src/components/dropdown.lua", 1046, 1618],
	["src/components/keybind.lua", 1619, 1949],
	["src/components/input.lua", 1950, 2174],
	["src/components/checkbox.lua", 2731, 2884],
	["src/layout/collapsible.lua", 2885, 3569],
	["src/layout/columns.lua", 3570, 4231],
	["src/navigation/tab.lua", 2175, 2730, 4232, 4350],
	["src/menu/constructor.lua", 4351, 5383],
	["src/menu/navigation.lua", 5384, 5790],
	["src/menu/overview.lua", 5791, 6250],
	["src/menu/config.lua", 6251, 6558],
	["src/menu/notifications.lua", 6559, 7011],
	["src/menu/window.lua", 7012, 7852],
	["src/menu/theme_tooltip.lua", 7853, 8254],
	["src/menu/palette.lua", 8255, 8722],
	["src/export.lua", 8723, 8753],
];

const lines = source.split("\n");

function dedent(rangeLines) {
	return rangeLines.map((line) => (line.startsWith("\t") ? line.slice(1) : line)).join("\n").replace(/\s*$/, "") + "\n";
}

for (const [relativePath, ...bounds] of modules) {
	let content = "";
	for (let i = 0; i < bounds.length; i += 2) {
		content += dedent(lines.slice(bounds[i] - 1, bounds[i + 1]));
		if (i + 2 < bounds.length) {
			content += "\n";
		}
	}
	const absolutePath = path.join(ROOT, relativePath);
	fs.mkdirSync(path.dirname(absolutePath), { recursive: true });
	fs.writeFileSync(absolutePath, content, "utf8");
}

console.log(`Extracted ${modules.length} source files from fyyui.lua.`);
