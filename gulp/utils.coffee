# Error handler
global.handleError = (error) ->
  if error.filename
    filename = _.last error.filename.split('/')
    filenameMessage = "in ".red + filename.red.underline + ':'.red
  else
    filenameMessage = ""
  if error.plugin
    console.log "Plugin".red, "#{error.plugin}".red.underline, "detects an error".red, filenameMessage
  console.log error.toString().red
  @emit 'end'

# Functions that allow to require all files from target folder
global.requireFolder = (folder) ->
  prefix = '../'
  _.each fs.readdirSync(folder), (filename) ->
    require "#{prefix}#{folder}/#{filename}"

global.requireTree = (tree) ->
  if _.isArray tree
    _.each tree, (folder) ->
      requireFolder folder
  else
    requireFolder tree