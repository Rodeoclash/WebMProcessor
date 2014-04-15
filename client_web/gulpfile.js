var gulp = require('./gulp')([
	'browserify',
	'compass',
	'images',
	'templates',
	'open',
	'watch',
	'serve'
]);

gulp.task('build', ['browserify', 'compass', 'images', 'templates']);
gulp.task('default', ['build', 'watch', 'serve', 'open']);
