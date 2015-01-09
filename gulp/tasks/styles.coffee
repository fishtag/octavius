checkGem 'compass'

gulp.task "styles", ->
  sassFiles = gulp.src paths.styles.src + "/application.scss"
    .pipe(plugins.compass({
        css: paths.styles.dest
        sass: paths.styles.src
      })).on "error", (error) ->
        console.log error
   .pipe gulp.dest paths.styles.dest

# Start task on gulp start
gulp.start "styles"

plugins.watch paths.app_short+'scss/**/*.scss', () ->
  sequence 'styles', 'livereload'
