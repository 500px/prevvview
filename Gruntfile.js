module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({

    // JSON
    pkg: grunt.file.readJSON('package.json'),

    // Sass
    sass: {
      dist: {
        options: {
          sourcemap: 'none'
        },
        files: {
          'stylesheet/css/stylesheet.css' : 'stylesheet/_sass/stylesheet.sass'
        }
      }
    },

    // Autoprefixer
    autoprefixer: {
      no_dest: {
        src: 'stylesheet/css/stylesheet.css'
      },
    },

    // Watch
    watch: {
      css: {
        files: [
          'stylesheet/**/*'
        ],
        tasks: ['sass', 'autoprefixer'],
        options: {
          spawn: false,
        },
      },
    },

  });

  // Load tasks
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-autoprefixer');
  grunt.loadNpmTasks('grunt-contrib-sass');

  // Run tasks
  grunt.registerTask('default', ['sass', 'autoprefixer', 'watch']);


};
