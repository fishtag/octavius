Task = require "#{__base}/core/task"
Del = require('del')

class BowerInitTask extends Task
  _paths:
    destination: 'lib'
  options:
    asset: true
    livereload: false

  develop: ->
    return if fileExists(__bower)



module.exports = BowerInitTask