colors = require('colors')
class OctaviusLog
  constructor: ->
  info: (message) ->
    console.log "Octavius: #{message}".blue

  error: (error) ->
    return unless error

    if error.filename
      filename = _.last error.filename.split('/')
      filenameMessage = "in ".red + filename.red.underline + ':'.red
    else
      filenameMessage = ""
    if error.plugin
      console.log "Plugin".red, "#{error.plugin}".red.underline, "detects an error".red, filenameMessage
    console.log error.toString().red
    @emit 'end' if @emit

module.exports = new OctaviusLog()