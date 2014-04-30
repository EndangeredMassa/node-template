gulp = require 'gulp'
rename = require 'gulp-rename'

Path = require 'path'
makeImageName = (input) ->
  {dirname, basename, extname} = input

  if dirname != '.'
    [moduleName] = dirname.split '/'
    basename = "#{moduleName}-#{basename}"

  { dirname: 'public/images', basename, extname }

module.exports = (options, digest) ->
  run: ->
    gulp.src(options.paths.images)
      .pipe(rename makeImageName)
      .pipe(digest())
      .pipe(gulp.dest '.')
      .pipe(digest.manifest())
      .pipe(gulp.dest '.')

