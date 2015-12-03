Octavius project
=======
This is a simple Node.js project that use Gulp for precompile all assets:

- Jade
- SCSS with [Autoprefixer](https://github.com/postcss/autoprefixer-core)
- CoffeeScript
- Generated iconsfont 
- Full Bower integration
- Organize folder structure (copying fonts, sounds etc)
- Production mode with minified assets
- Express server for standalone static sites

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
### Check Octavius version
`octavius -v` or `octavius --version`

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

### Production mode
You can run Octavius in **production mode** with this simple environment variable:

```PRODUCTION=true```

### Express server
Octavius can run server on specified port with this environment variable:

```PORT=8888```

Now you can see your website without BrowserSync with this address:

```http://localhost:8888/```

It is very useful for Cloud Services, for example, [Heroku](http://heroku.com). Just add **package.json** with this content in your project's root directory:

```
{
  "name": "Project Name",
  "version": "1.0.0",
  "description": "Project description",
  "scripts": {
    "start": "octavius"
  },
  "dependencies": {
    "octavius": "^1.1.4"
  },
  "engines": {
    "node": "5.0.0"
  }
}

```
and push your project to heroku master branch.