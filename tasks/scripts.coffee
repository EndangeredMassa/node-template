gulp = require 'gulp'
browserify = require 'browserify'
source = require 'vinyl-source-stream'
shortify = require 'shortify'

fatalError = (err) ->
  console.log 'Failed to compile bundle'
  throw err

Scripts = (options, digest) ->
  run: ->
    Scripts.makeDefaultBundler(options, digest, browserify, fatalError)
      .rebundle()

projectRoot = "#{__dirname}/../src"

Scripts.makeDefaultBundler = (options, digest, browserifyImpl, onError) ->
  bundler = browserifyImpl({
    entries: [ './src/bootstrap/index.coffee' ]
    extensions: [ '.coffee', '.html' ]
  })

  coffeeify = require 'coffeeify'

  bundler.rebundle = ->
    bundler
      .transform( coffeeify )
      .transform( shortify('~': projectRoot) )
      .bundle(options.browserify)
      .on('error', onError)
      .pipe(source 'public/bundle.js')
      .pipe(digest())
      .pipe(gulp.dest '.')
      .pipe(digest.manifest())
      .pipe(gulp.dest '.')

  bundler

module.exports = Scripts

