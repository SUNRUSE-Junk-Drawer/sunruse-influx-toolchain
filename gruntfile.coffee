module.exports = (grunt) ->
    grunt.loadNpmTasks pkg for pkg in [
            "grunt-contrib-watch"
            "grunt-contrib-coffee"
            "grunt-contrib-clean"
            "grunt-contrib-copy"
            "grunt-jasmine-nodejs"
        ]
        
    grunt.registerTask "build", ["clean:build", "coffee"]
    grunt.registerTask "test", ["jasmine_nodejs:unit", "jasmine_nodejs:integration"]
    grunt.registerTask "deploy", ["clean:deploy", "copy:deploy"]
        
    grunt.initConfig
        jasmine_nodejs:
            options:
                specNameSuffix: ".js"
            unit: 
                specs: ["**/*-unit.js"]
            integration: 
                specs: ["**/*-integration.js"]
        clean:
            build: "build"
            deploy: "deploy"
        copy:
            deploy:
                files: [
                    expand: true
                    cwd: "build"
                    src: ["**/*.js", "!**/*-unit.js", "!**/*-integration.js"]
                    dest: "deploy"
                ]
        coffee:
            config:
                files: [
                        expand: true
                        src: ["toolchain/**/*.coffee", "platforms/**/*.coffee", "cli/**/*.coffee"]
                        dest: "build"
                        ext: ".js"
                ]
        watch:
            options:
                atBegin: true
            files: ["gruntfile.coffee", "toolchain/**/*", "platforms/**/*", "cli/**/*", "libraries/**/*", "examples/**/*"]
            tasks: ["build", "test", "deploy"]