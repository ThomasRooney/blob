# Load all required libraries.
gulp       = require 'gulp'
sass       = require 'gulp-sass'
cssmin     = require 'gulp-cssmin'
jade       = require 'gulp-jade'
minifyHTML = require 'gulp-minify-html'
svgmin     = require 'gulp-svgmin'
coffee     = require 'gulp-coffee'
browserify = require 'gulp-browserify'
concat     = require 'gulp-concat'
livereload = require('gulp-livereload')


# Create your CSS from Sass, Autoprexif it to target 99%
#  of web browsers, minifies it.
gulp.task 'css', ->
  gulp.src 'client-src/css/index.sass'
    .pipe sass()
    .pipe gulp.dest 'public/css'

# Create you HTML from Jade, Adds an additional step of
#  minification for filters (like markdown) that are not
#  minified by Jade.
gulp.task 'html', ->
  gulp.src 'client-src/index.jade'
    .pipe jade()
    .pipe minifyHTML()
    .pipe gulp.dest 'public'

# Minify your SVG.
gulp.task 'svg', ->
  gulp.src 'client-src/svg/*.svg'
    .pipe svgmin()
    .pipe gulp.dest 'public/img'

# Copy the fonts using streams.
gulp.task 'copy', ->
  gulp.src 'client-src/fonts/*'
    .pipe gulp.dest 'public/fonts'

gulp.task 'coffee', ->
  gulp.src 'client-src/js/index.coffee', {read: false}
    .pipe(browserify({ transform: ['coffeeify'], extensions: ['.coffee'] }))
    .pipe(concat('app.js'))
    .pipe(gulp.dest('public/js'));

gulp.task 'watch', ->
  livereload.listen()
  gulp.watch('client-src/**/*', ['default']).on('change', livereload.changed)



# Default task call every tasks created so far.
gulp.task 'default', ['css', 'html', 'svg', 'copy', 'coffee']
