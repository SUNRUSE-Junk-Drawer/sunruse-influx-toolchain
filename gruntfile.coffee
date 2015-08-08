module.exports = (grunt) ->
    grunt.loadNpmTasks pkg for pkg in [
            "grunt-contrib-watch"
            "grunt-contrib-coffee"
            "grunt-contrib-clean"
            "grunt-contrib-copy"
            "grunt-jasmine-nodejs"
        ]
        
    grunt.registerTask "build", ["clean:build", "coffee"]
    grunt.registerTask "test", ["jasmine_nodejs:unit"]
    grunt.registerTask "deploy", ["clean:deploy", "copy:deploy"]
        
    grunt.initConfig
        jasmine_nodejs:
            options:
                specNameSuffix: ".js"
            unit: 
                specs: ["build/**/*.js", "**/*-unit.js"]
        clean:
            build: "build"
            deploy: "deploy"
        copy:
            deploy:
                files: [
                    expand: true
                    cwd: "build"
                    src: ["**/*.js", "!**/*-unit.js"]
                    dest: "deploy"
                ]
        coffee:
            config:
                files: [
                    expand: true
                    cwd: "toolchain"
                    src: ["**/*.coffee"]
                    dest: "build"
                    ext: ".js"
                ]
        watch:
            options:
                atBegin: true
            files: ["gruntfile.coffee", "toolchain/**/*"]
            tasks: ["build", "test", "deploy"]