sassStyle = 'expanded'
sourceMap = true

gulp.task "styles", ->
  sassFiles = gulp.src paths.styles.src + "/application.scss"
    .pipe(plugins.sass({
      style: sassStyle
      sourcemap: sourceMap
      precision: 2
      errLogToConsole: true
    })).on "error", (err) ->
      new gutil.PluginError("CSS", err,
        showStack: true
      )
  es.concat sassFiles
  .pipe plugins.concat("style.min.css")
  .pipe gulp.dest paths.styles.dest

# Start task on gulp start
gulp.start "styles"

plugins.watch paths.app_short+'scss/**/*.scss', () ->
  sequence 'styles', 'livereload'
