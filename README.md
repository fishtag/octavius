Gulpify project
=======
This is a simple web project that use Gulp for precompile all assets:

- Slim with include
- SCSS with [Autoprefixer](https://github.com/postcss/autoprefixer-core)
- CoffeeScript
- Optimize images
- Generate sprites from images folder
- Generate WebFont from folder of SVG files
- Organize folder structure (copying fonts, sounds etc)
- Deploy by ssh or ftp

## Main features

- **Easy installation** and ready to work after 3 commands
- **CoffeeScript based** Gulpfile 
- **Useful Gulpfiles structure** with tasks, utils etc
- Full **bower support** (Automatic concat and optimize bower components from bower.js)
- **BrowserSync** support with *.xip.io external link (no need Chrome extension)
- **Service tasks:**
  - **block** - creates block in slim and scss folders and append includes in index files
 
## Requirements
- *nix like OS (Mac OS is recommended)
- **Homebrew** (Mac OS) or your operating system **package manager**
- **node.js** as main engine
- **npm** as node.js package manager

----

## Installation (Mac OS)
### Node.js
`brew install node`

### Node Version Manager
`brew install nvm`

### Node Package Manager (NPM)
*Note: strongly unrecommended to install NPM via Homebrew, because there may be problems with access permissions*

`curl -L https://npmjs.com/install.sh | sh`
### Clone Git project
`git clone https://github.com/fishtag/gulpify.git`

### Install latest tested Node.js release
`nvm install 0.12.7`

*Note: later you can use this construction for choose correct node.js version*

`nvm use 0.12.7`

### Install required NPM packages
`npm install`

### Install Ruby version manager
`brew install rbenv ruby-build`

### Install latest tested Ruby version
`rbenv install 2.1.5`

### Install required Ruby gems via bundler
`gem install bundler && bundle`

## Start gulp
*Note: Use Webstorm 9 Gulp support or start process from your Terminal with this command:*

`gulp`

----
# Additional information
## Bower components installation
All bower components automatically concatenates into one file libraries.js. Gulp get main file of each component by its 'main' attribute in bower.json. So if you want automatically attach new component to your project you shoud do it with this command:

`bower install backbone --save`

*Important! Gulp does not find your component without dependency in bower.json. Flag **--save** means that the information about the component will be included in the main bower.json file.*

----

# Deploy tasks
## ssh
You can deploy your public folder by ssh with this command:

`gulp --deploy`

All configuration options available in **/gulp/config.yml** file **deploy.rsync** section

*Important! You must have **ssh public key** on your target server. You can read more about this [here](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2).*

## ftp
You can deploy your public folder via ftp with this command:

`gulp --deploy --ftp`

All configuration options available in **/gulp/config.yml** file **deploy.ftp** section.

----

# Service tasks
## block
This task creates block in your app/slim and scss/includes folders and append include directives to index.slim and applications.scss files. To create new block run this command in your terminal:

`gulp block --name=%your-block-name%`

----

# Changelog

## v0.2
- Fix v0.12.* node.js issues. Now you can use latest engine in your projects
- Replace gulp-file-include package with build-in Slim include plugin
- Replace v0.12.* node.js release conflict execSync package with shelljs

# Upcoming features

- Favicon generation for all devices
- Production mode with uglify support
