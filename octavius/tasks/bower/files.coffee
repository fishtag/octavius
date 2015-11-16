Task = require "#{__base}/core/task"
MainBowerFiles = require 'main-bower-files'
Concat = require 'gulp-concat'

class BowerFilesTask extends Task
  _paths:
    destination: 'lib'
  options:
    asset: true
    livereload: false

  develop: ->
    return unless fileExists(__bower)

    gulp.src MainBowerFiles()
      .on("error", Application::log.error)
      .pipe gulp.dest @paths().destination
  production: ->
    return unless fileExists(__bower)
    files = MainBowerFiles()
    gulp.src files
      .pipe Concat 'libraries.js'
      .pipe gulp.dest @paths().destination

module.exports = BowerFilesTask