base =
  app: './app/'
  public: './public/'
  dest: './public/'
  bower: './bower_components/'

paths =

# Images task
  images:
    src: base.app + "images/**/*.*"
    dest: base.dest + "images/"

# Fonts task
  fonts:
    src: base.app + "fonts/**/*.*"
    dest: base.dest + "fonts/"

# Sounds task
  sounds:
    src: base.app + "sounds/**/*.*"
    dest: base.dest + "sounds/"

# Coffee folder
  coffee:
    src: base.app + "coffee/"
    dest: base.dest + "js/"

# Slim task
  slim:
    src: base.app + "slim/"
    tmp: base.app + "html/"
    dest: base.public


# Javascript merge task
  scripts:
    src: base.app + "js/"
    dest: base.dest + "js/"
    libs: base.dest + "js/libs/"

# Scss task
  styles:
    src: base.app + "scss/"
    dest: base.dest + "css/"

# Sprite generation task
  sprite:
    src: base.app + "images/icons/*"

module.exports = paths