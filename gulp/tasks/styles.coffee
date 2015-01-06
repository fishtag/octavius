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
  .pipe plugins.size()
  .pipe gulp.dest paths.styles.dest
