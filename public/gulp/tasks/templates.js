var gulp = require('gulp');
var livereload = require('gulp-livereload');
var notify = require("gulp-notify");
var templateCache = require("gulp-angular-templatecache");

module.exports = function() {
	var dest = './build';

	return gulp.src('./src/modules/**/*.html')
        .pipe(templateCache('templates.js', {
        	standalone: true
        }))
        .pipe(gulp.dest(dest))
		.on('error', notify.onError({
			message: "<%= error.message %>",
			title: "Templates Error"
		}))
        .pipe(livereload());
};