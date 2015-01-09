spriteConfig =
  imgName: "icons.png"
  cssName: "_icons.scss"
  imgPath: paths.images.dest.replace("public", "") + "icons.png"

gulp.task "sprite", ->
  spriteData = gulp.src paths.sprite.src
    .pipe plugins.spritesmith {
      imgName: spriteConfig.imgName
      cssName: spriteConfig.cssName
      imgPath: spriteConfig.imgPath
      cssVarMap: (sprite) ->
        sprite.name = "icon-" + sprite.name
        return
    }
  spriteData.img.pipe gulp.dest paths.images.dest
  spriteData.css.pipe gulp.dest paths.styles.src

# Start task on gulp start
gulp.start "sprite"