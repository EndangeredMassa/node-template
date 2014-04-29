'use strict';

var crypto = require('crypto');
var fs = require('fs');
var path = require('path');
var gutil = require('gulp-util');
var through = require('through2');
var concat = require('concat-stream');
var merge = require('lodash').merge;

function shasum(str) {
  return crypto.createHash('sha1').update(str).digest('hex');
}

function loadManifestSafe(manifestFile) {
  try {
    var manifest = JSON.parse(fs.readFileSync(manifestFile));
    if (manifest && typeof manifest === 'object') {
      return manifest;
    } else {
      return {};
    }
  } catch (e) {
    return {};
  }
};

module.exports = function(opts) {
  if (!opts) opts = {};
  var noop = opts && !opts.fingerprint;
  var manifestFile = opts.manifestFile || 'digest.json';
  var env = opts.env || process.env.NODE_ENV || 'development';
  var assetPath = opts.assetPath || '';
  var digestPrefix = opts.digestPrefix || '';

  var manifestCache = {};

  var plugin = function() {
    return through.obj(function (file, enc, cb) {
      if (file.isNull()) {
        this.push(file);
        return cb();
      }

      // save the old path for later
      file.revOrigPath = file.path;
      file.revOrigBase = file.base;

      var onHasContent = (function(contents) {
        var hash = shasum(contents);
        var ext = path.extname(file.path);
        var filename = path.basename(file.path, ext) + '-' + hash + ext;
        file.path = path.join(path.dirname(file.path), filename);
        file.contents = contents;
        this.push(file);
        cb();
      }).bind(this);

      if (!noop) {
        if (file.isStream()) {
          file.contents.pipe(concat(function(buffer) {
            onHasContent(buffer);
          }));
        } else {
          onHasContent(file.contents);
        }
      } else {
        this.push(file);
        cb();
      }
    });
  };

  plugin.getManifestSafe = function() {
    if (manifestCache[manifestFile]) {
      return manifestCache[manifestFile];
    } else {
      var manifest = loadManifestSafe(manifestFile);
      return (manifestCache[manifestFile] = manifest);
    }
  };

  plugin.digestUrl = function(url) {
    var manifest = plugin.getManifestSafe();
    var lookup = manifest[env] || {};
    var fullPath = path.join(digestPrefix, assetPath, url);
    var fromDigest = lookup[fullPath] || fullPath;
    return fromDigest.substr(digestPrefix.length);
  };

  plugin.manifest = function() {
    var manifest  = {};
    var fileMap = manifest[env] = {};
    var firstFile = null;

    return through.obj(function (file, enc, cb) {
      // ignore all non-rev'd files
      if (file.path && file.revOrigPath) {
        firstFile = firstFile || file;

        var origFile = file.revOrigPath.replace(file.revOrigBase, '');
        var fileWithDigest = file.path.replace(firstFile.base + '/', '');
        fileMap[origFile] = fileWithDigest;
      }

      cb();
    }, function (cb) {
      if (firstFile) {
        // Load old manifest and try to merge
        var oldManifest = plugin.getManifestSafe(manifestFile);
        var mergedManifest = merge(oldManifest, manifest);
        this.push(new gutil.File({
          cwd: firstFile.cwd,
          base: firstFile.base,
          path: path.join(firstFile.base, manifestFile),
          contents: new Buffer(JSON.stringify(mergedManifest, null, 2) + '\n')
        }));
      }

      cb();
    });
  };

  return plugin;
}
