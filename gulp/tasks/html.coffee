checkGem 'slim'

# Render slim files to tmp html files
gulp.task "slimRender", () ->
  gulp.src paths.slim.src + "**/*.slim"
  .pipe plugins.slim pretty: true
  .pipe gulp.dest paths.slim.tmp

# Use include functionality on tmp html files and merge it into index.html
gulp.task "htmlInclude", ["slimRender"], () ->
  gulp.src paths.slim.tmp + "*.html"
  .pipe plugins.fileInclude {
    prefix: "##"
    basepath: "@file"
  }
  .pipe gulp.dest paths.slim.dest
