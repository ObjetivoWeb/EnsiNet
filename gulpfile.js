var gulp        = require('gulp');
var browserSync = require('browser-sync');
var cp          = require('child_process');

var jekyll   = process.platform === 'win32' ? 'jekyll.bat' : 'jekyll';
var messages = {
    jekyllBuild: '<span style="color: grey">Running:</span> $ jekyll build'
};
var semestre = '2017-1';

gulp.task('update-unidades', function (done) {
    cp.exec('RMDIR "_unidades/'+semestre+'" /S /Q');
    return cp.spawn(jekyll, ['build', '-c_c_unidades.yml'], {stdio: 'inherit'})
        .on('close', done);
});

gulp.task('update-projetos', function (done) {
    cp.exec('RMDIR "_projetos/'+semestre+'" /S /Q');
    return cp.spawn(jekyll, ['build', '-c_c_projetos.yml'], {stdio: 'inherit'})
        .on('close', done);
});

gulp.task('update-data', ['update-unidades', 'update-projetos']);

/**
 * Build the Jekyll Site
 */
gulp.task('jekyll-build', function (done) {
    browserSync.notify(messages.jekyllBuild);
    return cp.spawn(jekyll, ['build'], {stdio: 'inherit'})
        .on('close', done);
});

/**
 * Rebuild Jekyll & do page reload
 */
gulp.task('jekyll-rebuild', ['jekyll-build'], function () {
    browserSync.reload();
});

/**
 * Wait for jekyll-build, then launch the Server
 */
gulp.task('browser-sync', ['jekyll-build'], function() {
    browserSync({
        server: {
            baseDir: '_site',
            routes: {
                "/EnsiNet": "_site"
            }
        }
    });
});

/**
 * Watch html/md files, run jekyll & reload BrowserSync
 * if you add folder for pages, collection or datas, add them to this list
 */
gulp.task('watch', function () {
    gulp.watch(['./*', '_data/**/*', '_layouts/*', '_includes/**/*', '_sass/*', 'css/*', 'js/*', 'img/**/*'], ['jekyll-rebuild']);
});

/**
 * Default task, running just `gulp` will compile the sass,
 * compile the jekyll site, launch BrowserSync & watch files.
 */
gulp.task('default', ['browser-sync', 'watch']);
