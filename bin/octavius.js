#!/usr/bin/env node
require('coffee-script/register')
var pjson = require('../package.json');
var cli = require('commander');
var options = {};

cli
  .version(pjson.version)
  .option('-s, --server', 'Start HTTP server at public folder')
  .option('-S, --server-only', 'Start HTTP server at public folder without start tasks')
  .option('-w, --no-watch', 'Run tasks in any mode only once without watch')
  .option('-p, --production', 'Run all Octavius tasks in production mode and exit')
  .parse(process.argv);

// Exit with 0 or 1
var failed = false;
process.once('exit', function(code) {
    if (code === 0 && failed) {
        process.exit(1);
    }
});

if (cli.server) { options.server = true; }
if (cli.serverOnly) { options.serverOnly = true; }
if (cli.watch === false) { options.once = true; }
if (cli.production) { options.production = true; }

process.nextTick(function() {
    Octavius = require('../octavius/octavius');
    Octavius.start(options);
});