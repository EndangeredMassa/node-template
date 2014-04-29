gulp = require 'gulp'
clean = require 'gulp-clean'


module.exports = (options, digest) ->
  run: ->
    gulp.src('digest.json', {read: false}).pipe(clean())
    gulp.src('test/tmp', {read: false}).pipe(clean())
    gulp.src('public', {read: false}).pipe(clean())

