Service = require "#{__base}/core/service"


class BrowsersyncService extends Service
  events:
    'reload': 'reload'

  initialize: ->
    if Application::develop
      @start()
    else
      @callback(undefined, @)

  start: ->
    @server = browserSync
      xip: true
      open: false#'external'
      browser: 'google chrome'
      server:
        baseDir: './public'
      middleware: [
        (req, res, next) =>
          unless _.isNull(req.url.match(/api/)) and !Config.data.mongodb
            collection = _.last(req.url.split('/'))
            Radio.emit 'mongo:collections', {
              collections: {collection:collection}
              callback: (task, result) ->
                res.setHeader('Content-Type', 'application/json')
                res.end(JSON.stringify(result))
            }
          else
            next()
      ], () =>
        @callback(undefined, @)


  reload: (options) ->
    @server.reload options.options
    options.callback('All browsers successfull reloaded') if options.callback


module.exports = BrowsersyncService