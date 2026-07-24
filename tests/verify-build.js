#!/usr/bin/env node

const assert = require("node:assert/strict");
const crypto = require("node:crypto");
const fs = require("node:fs");
const path = require("node:path");
const childProcess = require("node:child_process");

const root = path.resolve(__dirname, "..");
const bundlePath = path.join(root, "fyyui.lua");

function runBuild(...arguments_) {
	const result = childProcess.spawnSync(process.execPath, [path.join(root, "scripts", "build.js"), ...arguments_], {
		stdio: "inherit",
	});
	assert.equal(result.status, 0, `build command failed with status ${result.status}`);
}

function hashBundle() {
	return crypto.createHash("sha256").update(fs.readFileSync(bundlePath)).digest("hex");
}

const sources = [];
for (const directory of ["components", "layout", "navigation", "menu"]) {
	const absolute = path.join(root, "src", directory);
	for (const entry of fs.readdirSync(absolute)) {
		if (entry.endsWith(".lua")) {
			sources.push(path.join(absolute, entry));
		}
	}
}
sources.push(path.join(root, "src", "bootstrap.lua"), path.join(root, "src", "export.lua"));
assert.equal(sources.length, 19, "the modular architecture must contain exactly 19 Luau source files");

runBuild("--check");
const before = hashBundle();
runBuild();
const after = hashBundle();
assert.equal(after, before, "rebuilding must produce byte-identical deterministic output");

const bundle = fs.readFileSync(bundlePath, "utf8");
assert.match(bundle, /GENERATED FILE — DO NOT EDIT DIRECTLY\./, "bundle must identify itself as generated");
assert.match(bundle, /^return \(function\(\)/m, "bundle must preserve the shared private closure");
assert.match(bundle, /\n\s*return FyyUI\nend\)\(\)\n$/, "bundle must preserve the public export and final closure");

console.log(`Verified deterministic one-file bundle from ${sources.length} source files (${after.slice(0, 12)}).`);
