Task = require "#{__base}/core/task"
Coffee = require 'gulp-coffee'
Sourcemaps = require 'gulp-sourcemaps'

class CoffeeTask extends Task
  _paths:
    destination: 'js'
  options:
    livereload: {}
    watch: global.__app+'/coffee/**/*.coffee'

  develop: ->
    gulp.src @paths().source + '**/*.coffee'
      .pipe Sourcemaps.init()
      .pipe Coffee()
        .on("error", Application::log.error)
      .pipe Sourcemaps.write()
      .pipe gulp.dest @paths().destination

  production: ->
    gulp.src @paths().source + '**/*.coffee'
      .pipe Coffee()
        .on("error", Application::log.error)
      .pipe gulp.dest @paths().destination

module.exports = CoffeeTask