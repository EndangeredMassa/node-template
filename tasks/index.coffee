'use strict'

gulp = require 'gulp'
Digest = require './gulp-digest'

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

digest = Digest opts

[
  'images'
  'styles'
  'scripts'
  'watch'
].forEach (taskName) ->
  task = require("./#{taskName}")(opts, digest)
  gulp.task taskName, (task.after || []), task.run

gulp.task 'assets', [ 'images', 'styles', 'scripts' ]

module.exports = gulp

