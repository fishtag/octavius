# Place non bower files into vendor/js folder
gulp.task 'vendor', () ->
  gulp.src paths.vendor.js
  .pipe plugins.concat('vendor.js')
  .pipe gulp.dest "#{paths.assets}/js"

unless skipBuild
  # Start task on gulp start
  gulp.start "vendor"
