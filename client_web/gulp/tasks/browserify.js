var browserify = require('browserify');
var gulp = require('gulp');
var livereload = require('gulp-livereload');
var notify = require("gulp-notify");
var source = require('vinyl-source-stream');

module.exports = function() {
	return browserify({
			entries: ['./src/javascript.coffee'],
			extensions: ['.coffee']
		})
		//.require('backbone/node_modules/underscore', { expose: 'underscore' })
		.bundle({debug: true})
		.on('error', notify.onError({
			message: "<%= error.message %>",
			title: "JavaScript Error"
		}))
		.pipe(source('javascript.js'))
		.pipe(gulp.dest('./build/'))
		.pipe(livereload());
};