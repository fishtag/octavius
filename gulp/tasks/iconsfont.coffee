del = require 'del'
vinylPaths = require 'vinyl-paths'

# Generate icon font to public/assets/fonts
gulp.task "iconsfont", ->
  # Default font name
  fontName = 'iconsfont'

  gulp.src paths.iconsfonts.src
    .pipe plugins.svgmin() # Optimize each SVG icon
    .pipe plugins.iconfont { # Generate icon font
      fontName: fontName
      fontHeight: 500
      normalize: true
    }
      .on 'codepoints', (codepoints, options) -> # Generate scss template that includes to applications scss
        gulp.src "./app/scss/includes/_#{fontName}.scss" # Remove old scss
          .pipe vinylPaths del
        gulp.src "./gulp/templates/_#{fontName}.scss"
          .pipe plugins.consolidate 'lodash', { # Use special template for lodash
            glyphs: codepoints
            fontName: fontName
            fontPath: "../fonts/#{fontName}/"
            className: fontName
          }
          .pipe gulp.dest "./app/scss/includes"
    .pipe gulp.dest paths.iconsfonts.dest

# Start task on gulp start
gulp.start "iconsfont"

# Start watch process
plugins.watch paths.app_short + 'svg/**/*', () ->
  sequence 'iconsfont', 'styles', 'livereload' # Regenerate iconsfont and scss after svg folder changes