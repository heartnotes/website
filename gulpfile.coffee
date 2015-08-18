path = require('path')

fs = require 'fs'
gulp = require('gulp')
gutil = require 'gulp-util'
args = require('yargs').argv


options = 
  minifiedBuild: !!args.minified
  dontExitOnError: false


if options.minifiedBuild
  console.log 'MINIFIED mode'
else
  console.log 'Non-MINIFIED mode'


# paths

paths =
  npm: path.join(__dirname, 'node_modules')
  src:
    stylus: path.join(__dirname, 'src', 'stylus')
    img: path.join(__dirname, 'src', 'img')
    jade: path.join(__dirname, 'src', 'jade')
    fonts: path.join(__dirname, 'src', 'fonts')
  build: 
    html: path.join(__dirname, 'build') 
    css: path.join(__dirname, 'build', 'css') 
    img: path.join(__dirname, 'build', 'img') 
    fonts: path.join(__dirname, 'build', 'fonts') 
  files: {}
  watch: {}


# Stylus
paths.watch.stylus = path.join(paths.src.stylus, '**', '**', '*.styl')

# Img 
paths.files.img = path.join(paths.src.img, '**', '*.*')
paths.watch.img = paths.files.img

# Jade
paths.files.jade = path.join(paths.src.jade, 'index.jade')
paths.watch.jade = path.join(paths.src.jade, '**', '**', '*.jade')


# 
# initialisation
# 

# load all gulp tasks
tasksFolder = path.join(__dirname, 'gulp')
taskFiles = fs.readdirSync tasksFolder

for tf in taskFiles
  if '.coffee' isnt path.extname(tf)
    continue

  fn = require(path.join(tasksFolder, tf))
  taskInfo = fn(paths, options)

  handler = undefined
  deps = []

  if taskInfo.deps
    deps = taskInfo.deps
    handler = taskInfo.task
  else
    handler = taskInfo

  gulp.task path.basename(tf, '.coffee'), deps, handler


# default task
gulp.task 'default', ['dev']
