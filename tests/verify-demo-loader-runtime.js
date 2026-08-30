const fs = require('node:fs');
const source = fs.readFileSync('demo.lua', 'utf8');
function assert(value, message) { if (!value) throw new Error(message); }
assert(source.includes('/FyyUI.lua'), 'demo must fetch stable FyyUI.lua');
assert(!source.includes('FyyUIKeyService.lua'), 'demo must not fetch Key Service bundle');
assert(!source.includes(':KeyService('), 'demo must not mount Key Service tab');
assert(!source.includes('/api/v1/check/challenge'), 'demo must not authorize keys');
assert(source.includes('__FYY_ACCESS_HANDOFF'), 'demo must consume loader handoff');
assert(source.includes('/api/v1/check/heartbeat'), 'demo must retain heartbeat');
assert(source.includes('menu:OnDestroy(stopAccessHeartbeat)'), 'demo must stop heartbeat on destroy');
console.log('demo loader-runtime contract passed');
