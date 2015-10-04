colors = require('colors')
class GulpifyLog
  constructor: ->
  info: (message) ->
    console.log "Gulpify: #{message}".blue

module.exports = new GulpifyLog()