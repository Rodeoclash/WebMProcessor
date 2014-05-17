var gulp       = require('gulp');
var livereload = require('gulp-livereload');

gulp.task('watch', function() {
	var server = livereload();

	var reload = function(file) {
		server.changed(file.path);
	};

	gulp.watch(['src/modules/**/*.coffee', 'src/javascript.coffee'], ['browserify']);
	gulp.watch(['src/modules/**/*.scss', 'src/stylesheet.scss'], ['compass']);
	gulp.watch(['src/modules/**/*.html'], ['templates']);
	gulp.watch(['src/images/**'], ['images']);
	gulp.watch(['build/**']).on('change', reload);
});
