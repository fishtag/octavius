global.sourcemaps = require 'gulp-sourcemaps'

# Compile all coffee script files and place it into public/js folder
gulp.task 'coffee', () ->
  gulp.src paths.coffee.src + '**/*.coffee'
    .pipe sourcemaps.init()
    .pipe plugins.coffee()
      .on("error", handleError)
    .pipe sourcemaps.write()
    .pipe gulp.dest "#{paths.assets}/js"

unless skipBuild
  # Start task on gulp start
  gulp.start "coffee"

  plugins.watch paths.app_short+'coffee/**/*.coffee', () ->
    sequence 'coffee', 'livereload'