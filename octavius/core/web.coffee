Express = require 'express'

class WebService
  constructor: (services) ->
    @services = services
    @_initServer()

  _initServer: ->
    @server = Express()

    @server.get '/', (req, res) =>
      res.send('Octavius control panel');

    @server.get '/:service/:method', (req, res) =>
      unless @services.get(req.params.service)
        res.send('Requested Octavius service not found');
      else
        Radio.emit "#{req.params.service}:#{req.params.method}", {
          callback: (message) ->
            res.send(message)
        }

    @server.listen(2000)

module.exports = WebService