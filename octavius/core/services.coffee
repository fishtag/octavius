requireDirectory = require 'require-directory'

class Services
  options:
    services: "#{__base}/services"

  constructor: (options = {}) ->
    @options = _.extend Services::options, options
    @services = {}

  load: (callback) ->
    services = requireDirectory(module, @options.services)
    tasks = []
    _.each services, (serviceClass, name) =>
      tasks.push (callback) =>
        Application::log.info "initialize #{serviceClass.name} service"
        @services[name] = new serviceClass(callback)
    async.series tasks, (err, results) ->
      callback()

  get: (serviceName) ->
    @services[serviceName]

module.exports = Services