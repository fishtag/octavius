Service = require "#{__base}/core/service"
Bower = if fileExists(__bower) then require('bower') else false

class BowerService extends Service
  events:
    'install': 'install'
    'prune': 'prune'

  initialize: ->
    @start()

  install: (callback) ->
    return callback() unless fileExists(__bower)
    Bower.commands.install()
      .on 'end', (result) ->
        callback result

  prune: (callback) ->
    return callback() unless fileExists(__bower)
    Bower.commands
      .prune()
      .on 'end', (result) ->
        callback result

module.exports = BowerService