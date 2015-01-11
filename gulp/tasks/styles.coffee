checkGem 'compass'

gulp.task 'styles', ->
  sequence 'sass', 'css-import', 'livereload'

gulp.task "sass", ->
  sassFiles = gulp.src paths.styles.src + "application.scss"
  .pipe(plugins.compass({
      css: paths.styles.dest
      sass: paths.styles.src
      sourcemap: true
    })).on("error", handleError)
  .pipe gulp.dest paths.styles.dest

gulp.task "css-import", ->
  gulp.src paths.styles.src_css + "vendor.css"
  .pipe plugins.cssimport { extensions: ["css"] }
  .pipe gulp.dest paths.styles.dest

# Start task on gulp start
gulp.start 'styles'

plugins.watch paths.app_short+'scss/**/*.scss', () ->
  gulp.start 'styles'
