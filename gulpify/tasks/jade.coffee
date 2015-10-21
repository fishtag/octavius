Task = require "#{__base}/core/task"
Jade = require 'gulp-jade'
Minify = require 'gulp-htmlmin'

class JadeTask extends Task
  _paths:
    destination: '/'
  options:
    asset: false
    livereload: {}
    watch: global.__app+'/jade/**/*.jade'

  develop: ->
    gulp.src @paths().source + '/*.jade'
      .pipe Jade()
      .pipe gulp.dest @paths().destination

  production: ->
    gulp.src @paths().source + '/*.jade'
      .pipe Jade()
      .pipe Minify
        collapseWhitespace: true
      .pipe gulp.dest @paths().destination

module.exports = JadeTask