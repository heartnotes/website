gulp = require 'gulp'


module.exports = (paths, options = {}) ->
  return {
    deps: ['fonts', 'jade', 'stylus', 'img']
    task: ->
      options.dontExitOnError = true
      gulp.watch paths.watch.img, ['img']
      gulp.watch paths.watch.stylus, ['stylus']
      gulp.watch paths.watch.jade, ['jade']
  }

