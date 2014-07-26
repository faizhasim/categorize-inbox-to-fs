gulp = require 'gulp'
coffee = require 'gulp-coffee'
gutil = require 'gulp-util'
newer = require 'gulp-newer'
watch = require 'gulp-watch'
mocha = require 'gulp-mocha'
argv = (require 'yargs').argv
gulpif = require 'gulp-if'


path =
  src: argv.src
  out: argv.out
  test: 'test/'


doesntContainsSrc = ->
  if not argv.src
    gutil.log gutil.colors.red 'Please specify --src=path/to/scanned/doc/*.pdf'
  return not argv.src


doesntContainsOut = ->
  if not argv.out
    gutil.log 'Please specify --out=path/to/out/dir/'
  return not argv.out


gulp.task 'compile', ->
  gulp.src 'src/**/*.coffee'
    .pipe newer 'lib/'
    .pipe (coffee bare: true).on 'error', gutil.log
    .pipe gulp.dest 'lib/'


gulp.task 'extract', ->
  return if doesntContainsSrc()

  if argv.runonce
    console.log 'running once'
  ((require './src/extract').extract path.src)


gulp.task 'watch', ->
  return if doesntContainsSrc()
  return if doesntContainsOut()

  watch glob: path.src + '**/*.coffee', (files) ->
    gulp.start 'compile'


gulp.task 'test', ->
  (gulp.src path.test + '**/*.coffee', read: false)
    .pipe mocha reporter: 'spec'


gulp.task 'default', ['test', 'compile']