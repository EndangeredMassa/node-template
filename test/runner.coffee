testium = require 'testium'
mkdirp = require 'mkdirp'

browser = process.env.BROWSER || 'phantomjs'
screenshotDirectory = "#{__dirname}/failed_screenshots"
mkdirp.sync screenshotDirectory

getTests = ->
  paths = process.env.TESTS
  if paths?
    paths.split(',')
  else
    "#{__dirname}/integration"

testOptions =
  tests: getTests()
  applicationPort: 7000
  screenshotDirectory: screenshotDirectory
  browser: browser
  appDirectory: "#{__dirname}/.."
  http:
    timeout: 60000
    connectTimeout: 20000
  mochaOptions:
    reporter: 'spec'
    timeout: 10000
    slow: 4000

testium.run testOptions, (error, exitCode) ->
  console.error error if error?
  process.exit(exitCode)

