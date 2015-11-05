global.fs = require 'fs'
global.fileExists = (file) ->
  result = true
  try
    stat = fs.statSync file
  catch err
    result = false
  finally
    return result

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

YamlConfig = require 'node-yaml-config'
global.Config = YamlConfig.load "#{__base}/config.yml"
if fileExists "#{process.cwd()}/octavius.yml"
  global.Config = _.extend global.Config, YamlConfig.load "#{process.cwd()}/octavius.yml"
