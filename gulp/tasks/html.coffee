checkGem 'slim'
slim = require '../scripts/slim'

# Render slim files to tmp html files
gulp.task "slimRender", () ->
  gulp.src paths.slim.src + "**/*.slim"
  .pipe slim app.config.html.slim
    .on("error", handleError)
  .pipe gulp.dest paths.slim.dest

unless skipBuild
  # Start task on gulp start
  sequence 'slimRender'

  # Start watch process
  plugins.watch paths.slim.short + '**/*.slim', () ->
    sequence 'slimRender', 'livereload'