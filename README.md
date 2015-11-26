Octavius project
=======
This is a simple Node.js project that use Gulp for precompile all assets:

- Jade
- SCSS with [Autoprefixer](https://github.com/postcss/autoprefixer-core)
- CoffeeScript
- Generated iconsfont 
- Full Bower integration
- Organize folder structure (copying fonts, sounds etc)

## Main features

- **Easy installation** and ready to work after 3 commands
- **CoffeeScript based** Gulpfile 
- **Useful Gulpfiles structure** with tasks, utils etc
- Full **bower support** (Automatic concat and optimize bower components from bower.js)
- **BrowserSync** support with *.xip.io external link (no need Chrome extension)
 
## Requirements
- *nix like OS (Mac OS is recommended)
- **Homebrew** (Mac OS) or your operating system **package manager**
- **node.js** as main engine
- **npm** as node.js package manager

----

## Installation (Mac OS)
### Node.js
`brew install node`

### Node Package Manager (NPM)
*Note: strongly unrecommended to install NPM via Homebrew, because there may be problems with access permissions*

`curl -L https://npmjs.com/install.sh | sh`

### Install required NPM packages
`npm install -g octavius`
 
## Work with Octavius
### Start Octavius
`octavius`

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

After restart Octavius your custom task will be added into Tasks stack.

### Bower components installation
All bower components automatically concatenates into one file libraries.js. Gulp get main file of each component by its 'main' attribute in bower.json. So if you want automatically attach new component to your project you shoud do it with this command:

`bower install backbone --save`

*Important! Octavius does not find your component without dependency in bower.json. Flag **--save** means that the information about the component will be included in the main bower.json file.*