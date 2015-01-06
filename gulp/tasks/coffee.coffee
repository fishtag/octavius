# Compile all coffee script files and place it into public/js folder
gulp.task 'scripts', () ->
  gulp.src paths.coffee.src + '**/*.coffee'
    .pipe sourcemaps.init()
    .pipe plugins.coffee()
    .pipe sourcemaps.write()
    .pipe gulp.dest "#{paths.assets}/js"