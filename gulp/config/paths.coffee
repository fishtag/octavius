base =
  app: './app/'
  app_short: 'app/'
  public: './public/'
  dest: './public/'
  tmp: './tmp/'
  assets: './public/assets/'
  bower: './bower_components/'

paths =
  app: base.app
  app_short: base.app_short
  bower: 'bower_components'
  assets: base.assets
  public: base.public

# Images task
  images:
    src: base.app + "images/**/*.*"
    dest: base.assets + "images/"

# Fonts task
  fonts:
    src: base.app + "fonts/**/*.*"
    dest: base.assets + "fonts/"

# Icon fonts task
  iconsfonts:
    src: base.app + "svg/**/*.*"
    dest: base.assets + "fonts/iconsfont"

# Sounds task
  sounds:
    src: base.app + "sounds/**/*.*"
    dest: base.assets + "sounds/"

# Coffee folder
  coffee:
    src: base.app + "coffee/"
    dest: base.assets + "js/"

# Slim task
  slim:
    src: base.app + "slim/"
    short: base.app_short + "slim/"
    tmp: base.app + "html/"
    dest: base.public


# Javascript merge task
  scripts:
    src: base.app + "js/"
    dest: base.assets + "js"

# Scss task
  styles:
    src: base.app + "scss/"
    src_css: base.app + "css/"
    dest: base.assets + "css/"
    tmp: base.tmp + "css/"
    files: base.app + "scss/**/*.scss"

# Sprite generation task
  sprite:
    src: base.app + "images/icons/*"

# Not bower vendor files
  vendor:
    js: base.app + "vendor/js/*"

module.exports = paths