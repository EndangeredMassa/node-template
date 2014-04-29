"use strict";

require('coffee-script/register');

var gulp = require('./tasks');
var taskListing = require('gulp-task-listing');
gulp.task('default', taskListing);

