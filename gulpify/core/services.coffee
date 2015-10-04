requireDirectory = require 'require-directory'
class Services
  options:
    services: "#{__base}/services"

  constructor: (options = {}) ->
    @options = _.extend Services::options, options
    @services = {}

  load: (path = @options.services) ->
    _.each requireDirectory(module, path), (serviceClass, name) =>
      @services[name] = new serviceClass(name)

module.exports = Services