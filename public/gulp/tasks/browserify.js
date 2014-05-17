var browserify   = require('browserify');
var gulp         = require('gulp');
var handleErrors = require('../util/handleErrors');
var source       = require('vinyl-source-stream');

gulp.task('browserify', function(){
	return browserify({
			entries: ['./src/javascript.coffee'],
			extensions: ['.coffee']
		})
		.bundle({debug: true})
		.on('error', handleErrors)
		.pipe(source('javascript.js'))
		.pipe(gulp.dest('./build/'));
});
