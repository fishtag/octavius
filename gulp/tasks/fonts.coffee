# Copy all fonts to public/assets/fonts
gulp.task "fonts", ->
  gulp.src paths.fonts.src
    .pipe gulp.dest paths.fonts.dest

unless skipBuild
  # Start task on gulp start
  gulp.start "fonts"

  # Start watch process
  plugins.watch paths.app_short + 'fonts/**/*', () ->
    sequence 'fonts', 'livereload'