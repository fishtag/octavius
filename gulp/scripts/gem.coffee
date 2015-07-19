shelljs = require("shelljs/global")
colors = require('colors')

global.isGemInstalled = (gem) ->
  stdout = exec "gem list -i #{gem}", { silent: true }
  (stdout.output.trim() == 'true')

global.checkGem = (gem) ->
  unless isGemInstalled gem
    console.log """Error: Ruby gem '#{gem}' is not installed. Please run
      \tbundle install #{gem}
      in your console.""".red
    process.exit code=0