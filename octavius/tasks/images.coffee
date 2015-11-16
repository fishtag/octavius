Task = require "#{__base}/core/task"
Imagemin = require 'gulp-imagemin'

class CoffeeTask extends Task
  options:
    livereload: {}
    watch: global.__app+'/images/**/*.*'

  develop: ->
    gulp.src @paths().source + '**/*.*'
      .pipe Imagemin {
          progressive: true
          svgoPlugins: [{removeViewBox: false}]
        }
      .on("error", Application::log.error)
      .pipe gulp.dest @paths().destination

module.exports = CoffeeTask