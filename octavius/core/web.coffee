Express = require 'express'

class WebService
  @port: 2000
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

    try
      @server.listen(WebService.port)
    catch err
      Application::log.error err
      exit(1)
    finally
      Application::log.info "Control panel successful started on #{WebService.port} port"

module.exports = WebService