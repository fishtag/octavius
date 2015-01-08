base =
  app: './app/'
  app_short: 'app/'
  public: './public/'
  dest: './public/'
  assets: './public/assets/'
  bower: './bower_components/'

paths =
  app: base.app
  app_short: base.app_short
  bower: 'bower_components'
  assets: base.assets

# Images task
  images:
    src: base.app + "images/**/*.*"
    dest: base.assets + "images/"

# Fonts task
  fonts:
    src: base.app + "fonts/**/*.*"
    dest: base.assets + "fonts/"

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
    dest: base.assets + "css/"
    files: base.app + "scss/**/*.scss"

# Sprite generation task
  sprite:
    src: base.app + "images/icons/*"

# Not bower vendor files
  vendor:
    js: base.app + "vendor/js/*"

module.exports = paths