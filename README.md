Gulpify project
=======
This is a simple web project that use Gulp for precompile all assets:

- Slim with include
- SCSS
- CoffeeScript
- Optimize images
- Generate sprites from images folder
- Generate WebFont from folder of SVG files
- Organize folder structure (copying fonts, sounds etc)

## Main features

- Easy installation and ready to work after 3 commands
- CoffeeScript based Gulpfile 
- Useful Gulpfiles structure with tasks, utils etc
- Full bower support (Automatic concat and optimize bower components from bower.js)
- LiveReload support (Chrome extension needed)
 
## Requirements
- *nix like OS (Mac OS is recommended)
- Homebrew (Mac OS) or any OS package manager
- node.js
- npm

----

## Installation (Mac OS)
### Node.js
`brew install node`
### Node Package Manager (NPM)
*Note: strongly unrecommended to install NPM via Homebrew, because there may be problems with access permissions*

`curl -L https://npmjs.com/install.sh | sh`
### Clone Git project
`git clone https://github.com/fishtag/gulpify.git`

### Install required NPM packages
`npm install --save-dev`

**Thats all! You're ready to Gulpify your new project!**

## Start gulp
*Note: Use Webstorm 9 Gulp support or start process from your Terminal with this command:*

`gulp`

----


# Upcoming features

- Favicon generation for all devices
- Production mode with uglify support
- Browser error reports via LiveReload functionality