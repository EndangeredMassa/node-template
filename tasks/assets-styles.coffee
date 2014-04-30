Url = require 'url'

gulp = require 'gulp'
digest = require './gulp-digest'
rename = require 'gulp-rename'
stylus = require 'gulp-stylus'
Stylus = require 'stylus'

rawFn = (fn) -> fn.raw = true; fn

module.exports = (options, digest) ->
  giftwrapUrl = rawFn (url) ->
    url = url.nodes[0].string
    parsedUrl = Url.parse url
    fixedUrl = if parsedUrl.protocol
      "url(#{url})"
    else
      "url(#{digest.digestUrl url})"

    return new Stylus.nodes.Literal fixedUrl

  define =
    url: giftwrapUrl

  after: [ 'assets-images' ]
  run: ->
    gulp.src(options.paths.styles)
      .pipe(stylus {define})
      .pipe(digest())
      .pipe(gulp.dest './public')
      .pipe(digest.manifest())
      .pipe(gulp.dest '.')

