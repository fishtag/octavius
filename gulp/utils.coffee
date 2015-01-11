fs = require 'fs'

# Error handler
global.handleError = (error) ->
  console.log error.toString()
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