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

    // Coffee
    coffee: {
      compile: {
        files: {
          'js/app.js': 'js/app.coffee', // 1:1 compile
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
      coffee: {
        files: [
          'js/*'
        ],
        tasks: ['coffee'],
      },
    },

  });

  // Load tasks
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-autoprefixer');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-coffee');

  // Run tasks
  grunt.registerTask('default', ['sass', 'coffee', 'autoprefixer', 'watch']);


};
