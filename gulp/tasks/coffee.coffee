# Compile all coffee script files and place it into public/js folder
gulp.task 'coffee', () ->
  gulp.src paths.coffee.src + '**/*.coffee'
    .pipe sourcemaps.init()
    .pipe plugins.coffee()
    .pipe sourcemaps.write()
    .pipe gulp.dest "#{paths.assets}/js"

# Start task on gulp start
gulp.start "coffee"

plugins.watch paths.app_short+'coffee/**/*.coffee', () ->
  sequence 'coffee', 'livereload'