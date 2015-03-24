checkGem 'compass'
checkGem 'sass-globbing'

gulp.task 'styles', ->
  sequence 'sass', 'css-import'

gulp.task "sass", ->
  sassFiles = gulp.src paths.styles.src + "application.scss"
  .pipe plugins.compass {
      require: 'sass-globbing'
      sourcemap: true
      css: paths.styles.dest
      sass: paths.styles.src
    }
  .on "error", handleError
  .pipe plugins.autoprefixer {
    browsers: ['last 3 versions']
  }
  .pipe gulp.dest paths.styles.dest
  .pipe plugins.filter '**/*.css'
  .pipe browserSync.reload stream:true

gulp.task "css-import", ->
  gulp.src paths.styles.src_css + "vendor.css"
  .pipe plugins.cssimport { extensions: ["css"] }
  .pipe gulp.dest paths.styles.dest

unless skipBuild
  # Start task on gulp start
  gulp.start 'styles'

  plugins.watch paths.app_short+'scss/**/*.scss', () ->
    gulp.start 'styles'
