Task = require "#{__base}/core/task"
Sass = require 'gulp-sass'
ImportOnce = require 'node-sass-import-once'
Sourcemaps = require 'gulp-sourcemaps'
Autoprefixer = require 'gulp-autoprefixer'
CSSMin = require 'gulp-cssmin'
Filter = require 'gulp-filter'

class SassTask extends Task
  _paths:
    destination: 'css'
  options:
    watch: global.__app+'/sass/**/*.sass'

  develop: ->
    gulp.src [@paths().source + '**/*.sass', @paths().source + '**/*.css']
      .pipe Sourcemaps.init()
      .pipe Sass()
        .on("error", Gulpify::log.error)
      .pipe Sourcemaps.write()
      .pipe Sourcemaps.init loadMaps:true
      .pipe Autoprefixer
        browsers: ['last 3 versions']
      .pipe Sourcemaps.write('.', {includeContent:false, sourceRoot:'.'})
      .pipe gulp.dest @paths().destination
      .pipe Filter '**/*.css'
      .pipe browserSync.reload stream:true

  production: ->
    gulp.src @paths().source + '**/*.sass'
      .pipe Sass()
        .on("error", Gulpify::log.error)
      .pipe Autoprefixer
        browsers: ['last 3 versions']
      .pipe CSSMin()
      .pipe gulp.dest @paths().destination

module.exports = SassTask