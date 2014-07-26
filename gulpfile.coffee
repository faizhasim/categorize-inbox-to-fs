gulp = require 'gulp'
coffee = require 'gulp-coffee'
gutil = require 'gulp-util'
newer = require 'gulp-newer'
watch = require 'gulp-watch'
mocha = require 'gulp-mocha'

gulp.task 'compile', ->
  gulp.src 'src/**/*.coffee'
    .pipe newer 'lib/'
    .pipe (coffee bare: true).on 'error', gutil.log
    .pipe gulp.dest 'lib/'

gulp.task 'watch', ->
  watch glob: 'src/**/*.coffee', (files) ->
    gulp.start 'compile'

gulp.task 'test', ->
  (gulp.src 'test/**/*.coffee', read: false)
    .pipe mocha reporter: 'spec'

gulp.task 'default', ['test', 'compile']