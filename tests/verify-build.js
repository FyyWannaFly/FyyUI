#!/usr/bin/env node

const assert = require("node:assert/strict");
const crypto = require("node:crypto");
const fs = require("node:fs");
const path = require("node:path");
const childProcess = require("node:child_process");

const root = path.resolve(__dirname, "..");
const bundlePath = path.join(root, "FyyUI.lua");

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
assert.equal(sources.length, 20, "the modular architecture must contain exactly 20 Luau source files");

runBuild("--check");
const before = hashBundle();
runBuild();
const after = hashBundle();
assert.equal(after, before, "rebuilding must produce byte-identical deterministic output");

const bundle = fs.readFileSync(bundlePath, "utf8");
assert.match(bundle, /Copyright \(c\) 2026 FyyWannaFly\. All rights reserved\./, "bundle must retain copyright");
assert.match(bundle, /Unauthorized copying, modification, or redistribution is prohibited\./, "bundle must retain license notice");
assert.match(bundle, /^return \(function\(\)/m, "bundle must preserve the shared private closure");
assert.match(bundle, /\n\s*return FyyUI\nend\)\(\)\n$/, "bundle must preserve the public export and final closure");
assert.match(bundle, /options\.InvokeDefaultCallbacks == nil or type\(options\.InvokeDefaultCallbacks\) == "boolean"/, "menu must validate default callback opt-in");
assert.match(bundle, /self\.InvokeDefaultCallbacks = options\.InvokeDefaultCallbacks == true/, "default callbacks must remain menu opt-in");
assert.match(bundle, /controller\._supportsDefaultCallback ~= true/, "only compatible value controllers may initialize callbacks");
assert.match(bundle, /if type\(value\) == "table" then value = table\.clone\(value\) end/, "multi-dropdown defaults must use a callback snapshot");
assert.match(bundle, /ctrl\._defaultCallbackInvoked = true[\s\S]*self\._pendingConfigValues\[ctrl\.Flag\] = nil/, "pending config must suppress duplicate default initialization");
assert.doesNotMatch(fs.readFileSync(path.join(root, "src", "components", "keybind.lua"), "utf8"), /_supportsDefaultCallback = true/, "keybind activation callbacks must not receive key defaults");

console.log(`Verified deterministic one-file bundle from ${sources.length} source files (${after.slice(0, 12)}).`);
