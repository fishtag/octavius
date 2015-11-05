Task = require "#{__base}/core/task"
BowerFiles = require 'main-bower-files'
Concat = require 'gulp-concat'

class BowerFilesTask extends Task
  _paths:
    destination: 'lib'
  options:
    asset: true
    livereload: false

  develop: ->
    return unless fileExists(__bower)
    gulp.src BowerFiles()
      .pipe gulp.dest @paths().destination

  production: ->
    return unless fileExists(__bower)
    files = BowerFiles()
    gulp.src files
      .pipe Concat 'libraries.js'
      .pipe gulp.dest @paths().destination

module.exports = BowerFilesTask