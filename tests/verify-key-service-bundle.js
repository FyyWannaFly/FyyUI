#!/usr/bin/env node

const assert = require('node:assert/strict');
const crypto = require('node:crypto');
const fs = require('node:fs');
const path = require('node:path');
const childProcess = require('node:child_process');

const root = path.resolve(__dirname, '..');
const stablePath = path.join(root, 'FyyUI.lua');
const secondaryPath = path.join(root, 'FyyUISec.lua');
const experimentPath = path.join(root, 'FyyUIKeyService.lua');
const extensionPath = path.join(root, 'experiments/key-service.lua');

function digest(file) {
  return crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex');
}
function buildExperiment() {
  const result = childProcess.spawnSync(process.execPath, [path.join(root, 'scripts/build.js'), '--key-service'], {
    encoding: 'utf8',
  });
  assert.equal(result.status, 0, result.stderr || result.stdout);
}

const stableBefore = digest(stablePath);
const secondaryBefore = digest(secondaryPath);
buildExperiment();
const first = digest(experimentPath);
buildExperiment();
const second = digest(experimentPath);

assert.equal(first, second, 'experimental Key Service bundle must be deterministic');
assert.equal(digest(stablePath), stableBefore, 'experimental build must not modify FyyUI.lua');
assert.equal(digest(secondaryPath), secondaryBefore, 'experimental build must not modify FyyUISec.lua');

const stable = fs.readFileSync(stablePath, 'utf8');
const experiment = fs.readFileSync(experimentPath, 'utf8');
const extension = fs.readFileSync(extensionPath, 'utf8');
assert.doesNotMatch(stable, /function Menu:KeyService/, 'stable bundle must not expose the experimental API');
assert.match(experiment, /function Menu:KeyService/, 'experimental bundle must expose Menu:KeyService');
assert.match(experiment, /Mode must be Gate or Embedded/, 'experimental bundle must validate modes');
assert.match(experiment, /Gate mode must mount before runtime tabs/, 'Gate mode must fail closed when mounted late');
assert.match(experiment, /self:_clearKey\(\)/, 'authorization must clear the key input');
assert.match(experiment, /requestToken ~= self\._requestToken/, 'async completion must be lifecycle fenced');
assert.doesNotMatch(extension, /game:HttpGet|HttpService|api\/v1|gethwid|http_request|syn\.request/, 'FyyUI Key Service must not own networking or device identity');
assert.doesNotMatch(extension, /heartbeat|sessionToken|sessionId|fetch_payload|loadstring/i, 'FyyUI Key Service must not own runtime sessions, heartbeat, or payload execution');
assert.doesNotMatch(extension, /\bFlag\s*=/, 'license input must never join config persistence');

console.log(`Verified isolated deterministic Key Service bundle (${second.slice(0, 12)}).`);
