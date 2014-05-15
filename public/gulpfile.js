var gulp = require('./gulp')([
	'browserify',
	'compass',
	'images',
	'fonts',
	'templates',
	'open',
	'watch',
	'serve'
]);

gulp.task('build', ['browserify', 'compass', 'images', 'templates', 'fonts']);
gulp.task('default', ['build', 'watch', 'serve', 'open']);
