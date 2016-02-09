global.fs = require 'fs'
global.fileExists = (file) ->
  result = true
  try
    stat = fs.statSync file
  catch err
    result = false
  finally
    return result

global.__production = process.env.PRODUCTION||=false
global.__develop = !__production

global.__port = if process.env.PORT then parseInt(process.env.PORT) else 8080

global.__base = __dirname + '/..'
global.__app = process.cwd() + '/app'
global.__public = process.cwd() + '/public'
global.__bower = process.cwd() + '/bower.json'

global._ = require 'underscore'
global.async = require 'async'
global.requireDirectory = require 'require-directory'
global.browserSync = require 'browser-sync'
global.Radio = new (require 'events').EventEmitter()
global.gulp = require 'gulp'
global.util = require 'gulp-util'

YamlConfig = require 'node-yaml-config'
global.Config = YamlConfig.load "#{__base}/config.yml"
if fileExists "#{process.cwd()}/octavius.yml"
  global.Config = _.extend global.Config, YamlConfig.load "#{process.cwd()}/octavius.yml"
