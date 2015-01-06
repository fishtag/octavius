execSync = require("exec-sync")
colors = require('colors')

global.isGemInstalled = (gem) ->
  stdout = execSync "gem list -i #{gem}"
  (stdout == 'true')

global.checkGem = (gem) ->
  unless isGemInstalled gem
    console.log """Error: Ruby gem '#{gem}' is not installed. Please run
      \tsudo gem install #{gem}
      in your console.""".red
    process.exit code=0