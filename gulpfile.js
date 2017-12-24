'use strict';

var gulp = require('gulp');
var sass = require('gulp-sass');
var elm = require('gulp-elm');
var server = require('pushstate-server');

var ELM_SRC = './src/**/*.elm';
var ELM_BUNDLE = 'main.js';
var SASS_SRC = './src/**/*.scss';
var SASS_MAIN = './src/style.scss';
var HTML_SRC = './static/index.html';
var OUTPUT = './build/';

gulp.task('styles', function() {
  gulp
    .src(SASS_MAIN)
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest(OUTPUT));
});

gulp.task('copy-index-html', function() {
  gulp.src(HTML_SRC).pipe(gulp.dest(OUTPUT));
});

gulp.task('elm-init', elm.init);

gulp.task('elm-bundle', ['elm-init'], function() {
  return gulp
    .src(ELM_SRC)
    .pipe(elm.bundle(ELM_BUNDLE))
    .pipe(gulp.dest(OUTPUT));
});

gulp.task('start-server', function() {
  server.start({
    port: 3000,
    directory: OUTPUT
  });
});

gulp.task('start', function() {
  gulp.start('styles');
  gulp.start('copy-index-html');
  gulp.start('start-server');
  gulp.start('elm-bundle');
  gulp.watch(SASS_MAIN, ['styles']);
  gulp.watch(SASS_SRC, ['styles']);
  gulp.watch(HTML_SRC, ['copy-index-html']);
  gulp.watch(ELM_SRC, ['elm-bundle']);
});
