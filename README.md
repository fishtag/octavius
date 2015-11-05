Octavius project
=======
This is a simple Node.js project that use Gulp for precompile all assets:

- Jade
- SCSS with [Autoprefixer](https://github.com/postcss/autoprefixer-core)
- CoffeeScript
- Organize folder structure (copying fonts, sounds etc)

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

### Install latest tested Node.js release
`nvm install 0.12.7`

*Note: later you can use this construction for choose correct node.js version*
`nvm use 0.12.7`

### Install required NPM packages
`npm install --save-dev octavius`

### Install Ruby version manager
`brew install rbenv ruby-build`

### Install latest tested Ruby version
`rbenv install 2.1.5`

### Install required Ruby gems via bundler
`gem install bundler && bundle`

### Create index.js file with this content
```
Octavius = require('octavius');
Octavius.start()
```
 
## Work with Octavius
### Start Octavius
`node index.js`

### Extend and override Octavius tasks
Octavius supports custom tasks. All you need is create `octavius` folder in your application and add `tasks` folder inside it. After that you can create your own tasks which extends core Octavius Task Class (or any existed Task).
Here is example of simple sounds copy task:

```
CopyTask = require "#{__base}/core/tasks/copy"

class SoundsTask extends CopyTask
  _paths:
    destination: 'sounds'

module.exports = SoundsTask
```

After restart Octavious your custom task will be added into Tasks stack.

### Bower components installation
All bower components automatically concatenates into one file libraries.js. Gulp get main file of each component by its 'main' attribute in bower.json. So if you want automatically attach new component to your project you shoud do it with this command:

`bower install backbone --save`

*Important! Octavius does not find your component without dependency in bower.json. Flag **--save** means that the information about the component will be included in the main bower.json file.*