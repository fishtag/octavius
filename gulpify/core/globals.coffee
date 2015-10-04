global.__base = __dirname + '/..'
global.__app = __dirname + '/../../app'
global.__public = __dirname + '/../../public'
global._ = require 'underscore'
global.Radio = new (require 'events').EventEmitter()
global.gulp = require 'gulp'