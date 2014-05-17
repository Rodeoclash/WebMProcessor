var gulp = require('gulp');

gulp.task('build', ['browserify', 'scss', 'images', 'templates', 'fonts']);
