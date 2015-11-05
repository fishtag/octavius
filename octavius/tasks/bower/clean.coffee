Task = require "#{__base}/core/task"
Del = require('del')

class BowerCleanTask extends Task
  _paths:
    destination: 'lib'
  options:
    asset: true
    livereload: false

  develop: ->
    Del @paths().destination

module.exports = BowerCleanTask