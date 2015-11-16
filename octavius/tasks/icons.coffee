Task = require "#{__base}/core/task"
del = require 'del'
vinylPaths = require 'vinyl-paths'
svgmin = require 'gulp-svgmin'
iconfont = require 'gulp-iconfont'
consolidate = require 'gulp-consolidate'
debug = require 'gulp-debug'

class IconsTask extends Task
  _paths:
    scss: global.__app+'/sass/'
  options:
    livereload: {}
    watch: global.__app+'/icons/**/*.svg'
  fontName: 'icon'

  develop: ->
    gulp.src @_paths.scss + '/_icons.scss' # Remove old scss
      .pipe vinylPaths del
    gulp.src @paths().source + '**/*.svg'
      .pipe svgmin() # Optimize each SVG icon
      .pipe iconfont { # Generate icon font
        fontName: @fontName
        fontHeight: 500
        normalize: true
      }
      .on 'glyphs', (glyphs, options) =>
        console.log glyphs
        gulp.src "#{__base}/templates/_icons.scss"
          .pipe consolidate 'lodash', { # Use special template for lodash
            glyphs: glyphs
            fontName: @fontName
            fontPath: "../icons/"
            className: @fontName
          }
          .pipe gulp.dest @_paths.scss
      .pipe gulp.dest @paths().destination

module.exports = IconsTask