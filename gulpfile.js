var sourcemaps = require('gulp-sourcemaps');
var gulp = require('gulp');
var es = require('event-stream');
var gutil = require('gulp-util');


// Automatic plugins import
var plugins = require("gulp-load-plugins")({
    pattern: ['gulp-*', 'gulp.*'],
    replaceString: /\bgulp[\-.]/
});

// Base paths for all your work folders
var basePaths = {
    app: 'app/',
    public: 'public/',
    src: 'app/assets/',
    dest: 'public/assets/',
    bower: 'bower_components/'
};

// Each node of this array is pair of Source and Destination folders.
// It needs for each GULP Task that works with files
var paths = {
    // Images task
    images: {
        src: basePaths.src + 'images/**/*.*',
        dest: basePaths.dest + 'images/'
    },
    // Fonts task
    fonts: {
        src: basePaths.src + 'fonts/**/*.*',
        dest: basePaths.dest + 'fonts/'
    },
    // Sounds task
    sounds: {
        src: basePaths.src + 'sounds/**/*.*',
        dest: basePaths.dest + 'sounds/'
    },
    // Coffee folder
    coffee: {
        src: basePaths.src + 'coffee/',
        dest: basePaths.dest + 'js/'
    },
    // Slim task
    slim: {
        src: basePaths.src + 'slim/',
        tmp: basePaths.src + 'html/',
        dest: basePaths.public
    },
    // Javascript merge task
    scripts: {
        src: basePaths.src + 'js/',
        dest: basePaths.dest + 'js/',
        libs: basePaths.dest + 'js/libs/'
    },
    // Scss task
    styles: {
        src: basePaths.src + 'scss/',
        dest: basePaths.dest + 'css/'
    },
    // Sprite generation task
    sprite: {
        src: basePaths.src + 'images/icons/*'
    }
};

// This is a main application files
var appFiles = {
    styles: paths.styles.src + '**/*.scss',
    scripts: [
            paths.scripts.src + 'main.js'
    ]
};

// This is a links to vendor scripts
var vendorFiles = {
    styles: '',
    scripts: [
            basePaths.bower + 'jquery/dist/jquery.min.js',
            basePaths.bower + 'underscore/underscore.js'
    ]
};

// This is a sprite config
var spriteConfig = {
    imgName: 'icons.png',
    cssName: '_icons.scss',
    imgPath: paths.images.dest.replace('public', '') + 'icons.png' // Gets put in the css
};

/*
 Let the magic begin
 */

// Allows gulp --dev to be run for a more verbose output
var isProduction = true;
var sassStyle = 'compressed';
var sourceMap = false;

if(gutil.env.dev === true) {
    sassStyle = 'expanded';
    sourceMap = true;
    isProduction = false;
}

// Event that fires when any element of source code has been changed
var changeEvent = function(evt) {
    setTimeout(function(){notifyLivereload(evt);},1000);
    gutil.log('File', gutil.colors.cyan(evt.path.replace(new RegExp('/.*(?=/' + basePaths.src + ')/'), '')), 'was', gutil.colors.magenta(evt.type));
};

// Express module initialization for LiveReload functionality
var EXPRESS_PORT = 4000;
var EXPRESS_ROOT = __dirname;
var LIVERELOAD_PORT = 35729;

function startExpress() {
    var express = require('express');
    var app = express();
    app.use(require('connect-livereload')());
    app.use(express.static(EXPRESS_ROOT));
    app.listen(EXPRESS_PORT);
}

var lr;
function startLivereload() {

    lr = require('tiny-lr')();
    lr.listen(LIVERELOAD_PORT);
}

function notifyLivereload(event) {
    // `gulp.watch()` events provide an absolute path
    // so we need to make it relative to the server root
    var fileName = require('path').relative(EXPRESS_ROOT, event.path);

    lr.changed({
        body: {
            files: fileName
        }
    });
}

// Sass to Css conversion task
gulp.task('css', function(){
    var sassFiles = gulp.src(paths.styles.src + '/application.scss')
        .pipe(plugins.sass({
            style: sassStyle,
            sourcemap: sourceMap,
            precision: 2,
            errLogToConsole: true
        }))
        .on('error', function(err){
            new gutil.PluginError('CSS', err, {showStack: true});
        });

    return es.concat(gulp.src(vendorFiles.styles), sassFiles)
        .pipe(plugins.concat('style.min.css'))
        .pipe(isProduction ? plugins.combineMediaQueries({
            log: true
        }) : gutil.noop())
        .pipe(isProduction ? plugins.cssmin() : gutil.noop())
        .pipe(plugins.size())
        .pipe(gulp.dest(paths.styles.dest));
});

// Image copy and optimization task
gulp.task('images', function () {
    gulp.src(paths.images.src)
        .pipe(plugins.imagemin({
            progressive: true,
            svgoPlugins: [{removeViewBox: false}]
        }))
        .pipe(gulp.dest(paths.images.dest));
});

// Fonts copy task
gulp.task('fonts', function () {
    gulp.src(paths.fonts.src)
        .pipe(gulp.dest(paths.fonts.dest));
});

// Sounds copy task
gulp.task('sounds', function () {
    gulp.src(paths.sounds.src)
        .pipe(gulp.dest(paths.sounds.dest));
});

// Javascript generation and merge task
gulp.task('scripts', function(){
    gulp.src(paths.coffee.src + "**/*.coffee")
        .pipe(sourcemaps.init())
        .pipe(plugins.coffee())
        .pipe(sourcemaps.write())
        .pipe(gulp.dest(paths.scripts.dest));

    gulp.src( appFiles.scripts )
        .pipe( plugins.include() )
        .pipe( gulp.dest( 'js' ) )
        .pipe( plugins.rename({ suffix: '.min' }) )
        .pipe( plugins.jsmin() )
        .pipe( gulp.dest(paths.scripts.dest) );

    gulp.src( vendorFiles.scripts )
        .pipe( plugins.include() )
        .pipe( gulp.dest(paths.scripts.libs));

});

// Temp folders clean task
gulp.task('clean', function() {
    return gulp.src(paths.slim.tmp + '/**/*.*')
        .pipe(plugins.clean());
});

// Render slim files to tmp html files
gulp.task('slimRender', function(){
    return gulp.src(paths.slim.src + '**/*.slim')
        .pipe(plugins.slim({
            pretty: true
        }))
        .pipe(gulp.dest(paths.slim.tmp));
});

// Use include functionality on tmp html files and merge it into index.html
gulp.task('htmlInclude', ['slimRender'], function(){
    return gulp.src(paths.slim.tmp + '*.html')
        .pipe(plugins.fileInclude({
            prefix: '##',
            basepath: '@file'
        }))
        .pipe(gulp.dest(paths.slim.dest));
});

// Sprite Generator
gulp.task('sprite', function () {
    var spriteData = gulp.src(paths.sprite.src).pipe(plugins.spritesmith({
        imgName: spriteConfig.imgName,
        cssName: spriteConfig.cssName,
        imgPath: spriteConfig.imgPath,
        cssVarMap: function (sprite) {
            sprite.name = 'icon-' + sprite.name;
        }
    }));
    spriteData.img.pipe(gulp.dest(paths.images.dest));
    spriteData.css.pipe(gulp.dest(paths.styles.src));
});

// Main watch task
gulp.task('watch', ['images', 'fonts', 'sounds', 'sprite', 'css', 'scripts', 'htmlInclude'], function(){
    startExpress();
    startLivereload();

    gulp.watch(appFiles.styles, ['css']).on('change', function(evt) {
        changeEvent(evt);
    });

    gulp.watch(paths.coffee.src + '**/*.coffee', ['scripts']).on('change', function(evt) {
        changeEvent(evt);
    });

    gulp.watch(paths.slim.src + '**/*.slim', ['htmlInclude']).on('change', function(evt) {
        changeEvent(evt);
    });

    gulp.watch(paths.sprite.src, ['sprite']).on('change', function(evt) {
        changeEvent(evt);
    });

    gulp.watch(paths.images.src, ['images']).on('change', function(evt) {
        changeEvent(evt);
    });

    gulp.watch(paths.fonts.src, ['fonts']).on('change', function(evt) {
        changeEvent(evt);
    });

    gulp.watch(paths.sounds.src, ['sounds']).on('change', function(evt) {
        changeEvent(evt);
    });
});

// Start watch task as default task
gulp.task('default', ['watch']);
