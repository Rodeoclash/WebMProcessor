var gulp       = require('gulp');
var sass       = require('gulp-ruby-sass');
var prefix     = require('gulp-autoprefixer');
var handleErrors = require('../util/handleErrors');

gulp.task('scss', function() {
  return gulp.src('./src/*.scss')
     .pipe(sass())
     .on('error', handleErrors)
     .pipe(prefix("last 1 version", "> 1%", "ie 8", "ie 7"))
     .pipe(gulp.dest('./build'));
});