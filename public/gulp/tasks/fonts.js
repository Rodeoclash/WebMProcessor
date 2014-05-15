var changed    = require('gulp-changed');
var gulp       = require('gulp');
var imagemin   = require('gulp-imagemin');
var livereload = require('gulp-livereload');

module.exports = function() {
	var dest = './build/fonts';

	return gulp.src('./src/fonts/**')
		.pipe(changed(dest)) // Ignore unchanged files
		.pipe(gulp.dest(dest));
};
