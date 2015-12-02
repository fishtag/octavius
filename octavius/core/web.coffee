Express = require 'express'
Path = require 'path'

class WebService
  @port: __port
  constructor: (services) ->
    _.bindAll @, '_errorHandler'

    @services = services

    @_initServer()
    @_initRoutes()

  _initServer: ->
    @server = Express()
    @_initListener()

  _initListener: ->
    @listener.close() if @listener
    @listener = @server.listen WebService.port, () ->
      Application::log.info "Control panel successful started on #{WebService.port} port"
    @listener.on 'error', @_errorHandler

  _initRoutes: ->
    @server.use Express.static Path.join __public

    @server.get '/:service/:method', (req, res) =>
      unless @services.get(req.params.service)
        res.send('Requested Octavius service not found');
      else
        Radio.emit "#{req.params.service}:#{req.params.method}", {
          callback: (message) ->
            res.send(message)
        }

  _errorHandler: (error) ->
    if error.code == 'EADDRINUSE'
      Application::log.error "Web: port #{WebService.port} in use, retrying with port #{WebService.port + 2}..."
      WebService.port = WebService.port + 2
      setTimeout =>
        @_initListener()
      , 1000

module.exports = WebService