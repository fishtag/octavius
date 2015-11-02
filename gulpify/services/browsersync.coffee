Service = require "#{__base}/core/service"

class BrowsersyncService extends Service
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
    @callback(undefined, @)

  reload: (options) ->
    @server.reload options.options
    options.callback('All browsers successfull reloaded') if options.callback


module.exports = BrowsersyncService