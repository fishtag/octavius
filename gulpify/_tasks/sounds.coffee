# Copy all sounds to public/assets/sounds
gulp.task "sounds", ->
  gulp.src paths.sounds.src
    .pipe gulp.dest paths.sounds.dest

unless skipBuild
  # Start task on gulp start
  gulp.start "sounds"