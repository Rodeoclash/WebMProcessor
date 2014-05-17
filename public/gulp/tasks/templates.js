var gulp       = require('gulp');
var templateCache = require("gulp-angular-templatecache");

gulp.task('templates', function() {
	var dest = './build';

	return gulp.src('./src/modules/**/*.html')
        .pipe(templateCache('templates.js', {
        	standalone: true
        }))
        .pipe(gulp.dest(dest))
});
