requireDirectory = require 'require-directory'
class Services
  options:
    services: "#{__base}/services"

  constructor: (options = {}) ->
    @options = _.extend Services::options, options
    @services = {}

  load: (path = @options.services, callback) ->
    async.map requireDirectory(module, path), @loadService, (services) =>
      @services = services
      callback()

  loadService: (serviceClass, callback) ->
    Gulpify::log.info "initialize #{serviceClass.name} service"
    "#{serviceClass.name}": new serviceClass()

module.exports = Services