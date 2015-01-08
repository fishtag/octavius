checkGem 'slim'

# Render slim files to tmp html files
gulp.task "slimRender", () ->
  gulp.src paths.slim.src + "**/*.slim"
  .pipe plugins.slim config.html.slim
  .pipe gulp.dest paths.slim.tmp

# Use include functionality on tmp html files and merge it into index.html
gulp.task "htmlInclude", ["slimRender"], () ->
  gulp.src paths.slim.tmp + "*.html"
  .pipe plugins.fileInclude config.html.include
  .pipe plugins.jsbeautifier config.html.beautifier
  .pipe gulp.dest paths.slim.dest

# Start watch process
plugins.watch paths.slim.short + '**/*.slim', () ->
  sequence 'slimRender', 'htmlInclude', 'livereload'