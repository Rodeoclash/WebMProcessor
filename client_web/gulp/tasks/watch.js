var gulp       = require('gulp');
var livereload = require('gulp-livereload');

module.exports = function(){
	gulp.watch(['src/modules/**/*.coffee', 'src/javascript.coffee'], ['browserify']);
	gulp.watch(['src/modules/**/*.scss', 'src/stylesheet.scss'], ['compass']);
	gulp.watch('src/images/**', ['images']);
	livereload();
};