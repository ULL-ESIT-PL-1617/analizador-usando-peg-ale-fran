var gulp = require('gulp');
var ghpages = require('gulp-gh-pages');

gulp.task('default', function () {
  return gulp.src('./coverage/lcov-report/**/*').pipe(ghpages({"message" : 'ghpages deployed'}));
});
