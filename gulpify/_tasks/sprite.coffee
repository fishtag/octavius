spriteConfig =
  imgName: 'icons.png'
  cssName: '_icons.scss'
  imgPath: paths.images.dest.replace('/public/assets', '.') + 'icons.png'

gulp.task 'sprite', ->
  spriteData = gulp.src paths.sprite.src
    .pipe plugins.spritesmith
      imgName: spriteConfig.imgName
      cssName: spriteConfig.cssName
      imgPath: spriteConfig.imgPath
      cssVarMap: (sprite) ->
        sprite.name = "icon-#{sprite.name}"
        return
  spriteData.img.pipe gulp.dest paths.images.dest
  spriteData.css.pipe gulp.dest paths.styles.src

unless skipBuild
  # Start task on gulp start
  gulp.start 'sprite'

  plugins.watch paths.app_short+'icons/**/*', () ->
    sequence 'sprite', 'livereload'