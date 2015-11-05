// Note the new way of requesting CoffeeScript since 1.7.x
require('coffee-script/register');
var Octavius;

Octavius = require('./octavius/octavius');

gulp.task('default', function() {
    return Octavius.start();
});

module.exports = gulp;