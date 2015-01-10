checkGem 'compass'

gulp.task 'styles', ->
  sequence 'sass', 'css-import', 'style-concat', 'livereload'

gulp.task "sass", ->
  sassFiles = gulp.src paths.styles.src + "application.scss"
  .pipe(plugins.compass({
      css: paths.styles.tmp
      sass: paths.styles.src
    })).on("error", handleError)
  .pipe gulp.dest paths.styles.tmp

gulp.task "css-import", ->
  gulp.src paths.styles.src_css + "vendor.css"
  .pipe plugins.cssimport { extensions: ["css"] }
  .pipe gulp.dest paths.styles.tmp

gulp.task "style-concat", ->
  gulp.src [paths.styles.tmp + "/vendor.css", paths.styles.tmp + "/application.css"]
  .pipe plugins.concat('application.css')
  .pipe gulp.dest paths.styles.dest

# Start task on gulp start
gulp.start 'styles'

plugins.watch paths.app_short+'scss/**/*.scss', () ->
  gulp.start 'styles'
