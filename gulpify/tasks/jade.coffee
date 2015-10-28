Task = require "#{__base}/core/task"
Path = require 'path'
Jade = require 'gulp-jade'
Data = require 'gulp-data'
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
      .pipe Data (file) ->
        require "#{global.__app}/data/#{Path.basename(file.path, '.jade')}.json"
      .on("error", Gulpify::log.error)
      .pipe Jade()
        .on("error", Gulpify::log.error)
      .pipe gulp.dest @paths().destination

  production: ->
    gulp.src @paths().source + '/*.jade'
      .pipe Jade()
        .on("error", Gulpify::log.error)
      .pipe Minify
        collapseWhitespace: true
      .pipe gulp.dest @paths().destination

module.exports = JadeTask