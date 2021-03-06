'use strict'

gulp = require 'gulp'
Digest = require './gulp-digest'
glob = require 'glob'

env = process.env.NODE_ENV || 'development'
opts =
  env: env
  fingerprint: env == 'production'
  manifestFile: 'digest.json'
  assetPath: '/assets'
  digestPrefix: 'public'
  browserify:
    debug: env != 'production'

IMAGE_EXT = '{png,jpg,gif,ico,svg}'
IMAGE_PATHS = [
  "public/images"
].map (dir) ->
  "#{dir}/*.#{IMAGE_EXT}"

opts.paths =
  images: IMAGE_PATHS
  styles: 'src/bootstrap/styles.styl'
  scripts: ['./src/bootstrap/index.coffee']
  scriptsOutput: 'public/bundle.js'

digest = Digest opts

[
  'assets-images'
  'assets-styles'
  'watch'
  'server'
  'test'
  'test-unit'
  'test-integration'
  'clean'
].forEach (taskName) ->
  task = require("./#{taskName}")(opts, digest)
  gulp.task taskName, (task.after || []), task.run

scripts = require('./assets-scripts')(opts, digest).run
gulp.task 'assets-scripts', scripts

testOptions =
  paths:
    scripts: glob.sync('./test/unit/**/*.coffee')
    scriptsOutput: './test/tmp/unit-bundle.js'
testScripts = require('./assets-scripts')(testOptions, digest).run
gulp.task 'test-scripts', testScripts

gulp.task 'assets', [ 'assets-images', 'assets-styles', 'assets-scripts' ]

module.exports = gulp

