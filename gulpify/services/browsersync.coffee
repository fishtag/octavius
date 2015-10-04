Service = require "#{__base}/core/service"
browserSync = require 'browser-sync'

class Browsersync extends Service
  events:
    'reload': 'reload'

  initialize: ->
    @start() if Gulpify::develop

  start: ->
    @server = browserSync
      xip: true
      open: false#'external'
      browser: 'google chrome'
      server:
        baseDir: './public'

  reload: (options) ->
    @server.reload options

module.exports = Browsersync