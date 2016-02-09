Task = require "#{__base}/core/task"
MainBowerFiles = require 'main-bower-files'
Filter = require 'gulp-filter'
Uglify = require 'gulp-uglify'
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
      .pipe Filter '*.js'
      .on("error", Application::log.error)
      .pipe gulp.dest @paths().destination

  production: ->
    return unless fileExists(__bower)

    files = MainBowerFiles()

    gulp.src files
      .pipe Filter '*.js'
        .on("error", Application::log.error)
      .pipe Uglify()
        .on("error", Application::log.error)
      .pipe Concat 'libraries.js'
        .on("error", Application::log.error)
      .pipe gulp.dest "#{__public}/assets/js/"

module.exports = BowerFilesTask