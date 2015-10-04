# Optimize images and copy it into public/images folder
gulp.task 'images', () ->
  gulp.src paths.images.src
  .pipe plugins.imagemin {
      progressive: true
      svgoPlugins: [{removeViewBox: false}]
    }
  .pipe gulp.dest paths.images.dest

unless skipBuild
  # Start task on gulp start
  gulp.start "images"

  plugins.watch paths.app_short+'images/**/*.*', () ->
    sequence 'images', 'livereload'
