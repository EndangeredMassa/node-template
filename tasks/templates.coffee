'use strict'

gulp = require 'gulp'
rename = require 'gulp-rename'
wrap = require 'gulp-wrap'

commonJSTemplate = """module.exports = "<%- contents %>";"""

module.exports = (options, digest) ->
  run: ->
    gulp.src(options.paths.templates)
      .pipe(wrap(commonJSTemplate))
      .pipe(rename {extname: 'js'})
      .pipe(digest())
      .pipe(gulp.dest '.')
      .pipe(digest.manifest())
      .pipe(gulp.dest '.')

