Task = require "#{__base}/core/task"
Jade = require 'gulp-jade'
Minify = require 'gulp-htmlmin'

class BowerInstallTask extends Task
  _paths:
    destination: '/'
  options:
    asset: false
    livereload: false

  develop: ->
    Radio.emit 'bower:prune', () ->
      Radio.emit 'bower:install'

module.exports = BowerInstallTask