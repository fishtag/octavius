global.__base = __dirname + '/..'
global.__app = __dirname + '/../../app'
global.__public = __dirname + '/../../public'
global._ = require 'underscore'
global.async = require 'async'
global.requireDirectory = require 'require-directory'
global.Radio = new (require 'events').EventEmitter()
global.gulp = require 'gulp'

global.requireTasks = (module, path) ->
  requireDirectory(module, path, {
    rename: (filename, joined, filename2) ->
      path = joined.split('gulpify/tasks/')[1]
      .replace '/',':'
      .replace '.coffee',''
      path
  })