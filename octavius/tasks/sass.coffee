Task = require "#{__base}/core/task"
Sass = require 'gulp-sass'
CSSImport = require 'gulp-import-css'
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
      .pipe Sass()
        .on("error", Application::log.error)
      .pipe CSSImport()
        .on("error", Application::log.error)
      .pipe Autoprefixer
        browsers: ['last 3 versions']
      .pipe gulp.dest @paths().destination
      .pipe Filter '**/*.css'
      .pipe browserSync.reload stream:true

  production: ->
    gulp.src @paths().source + '**/*.sass'
      .pipe Sass()
        .on("error", Application::log.error)
      .pipe Autoprefixer
        browsers: ['last 3 versions']
      .pipe CSSMin()
      .pipe gulp.dest @paths().destination

module.exports = SassTask