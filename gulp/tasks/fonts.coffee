# Copy all fonts to public/assets/fonts
gulp.task "fonts", ->
  gulp.src paths.fonts.src
    .pipe gulp.dest paths.fonts.dest
