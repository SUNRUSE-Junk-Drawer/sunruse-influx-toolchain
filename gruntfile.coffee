module.exports = (grunt) ->
    grunt.loadNpmTasks pkg for pkg in [
            "grunt-contrib-watch"
            "grunt-contrib-coffee"
            "grunt-contrib-clean"
            "grunt-contrib-copy"
            "grunt-jasmine-nodejs"
            "grunt-concurrent"
        ]
        
    grunt.registerTask "buildToolchain", ["clean:toolchainBuild", "coffee:toolchain"]
    grunt.registerTask "testToolchain", ["jasmine_nodejs:toolchain"]
    grunt.registerTask "deployToolchain", ["clean:toolchainDeploy", "copy:toolchain"]
    
    grunt.registerTask "buildPlatforms", ["clean:platformsBuild", "coffee:platforms"]
    grunt.registerTask "testPlatforms", ["jasmine_nodejs:platformsUnit", "jasmine_nodejs:platformsIntegration"]
    grunt.registerTask "deployPlatforms", ["clean:platformsDeploy", "copy:platforms"]
    
    grunt.registerTask "testLibraries", ["jasmine_nodejs:runAssertions"]
    
    grunt.registerTask "build", ["buildToolchain", "buildPlatforms"]
    grunt.registerTask "test", ["testToolchain", "testPlatforms", "testLibraries"]
    grunt.registerTask "deploy", ["deployToolchain", "deployPlatforms"]
        
    grunt.initConfig
        clean:
            toolchainBuild: "build/toolchain"
            toolchainDeploy: "deploy/toolchain"
            platformsBuild: "build/platforms"
            platformsDeploy: "deploy/platforms"
        jasmine_nodejs:
            options:
                specNameSuffix: ".js"
                reporters:
                    console:
                        verbosity: 0
            toolchain: 
                specs: ["build/toolchain/**/*-unit.js"]
            platformsUnit: 
                specs: ["build/platforms/**/*-unit.js"]
            platformsIntegration: 
                specs: ["build/platforms/**/*-integration.js"]
            runAssertions: 
                specs: ["build/toolchain/selftest.js"]
        copy:
            toolchain:
                files: [
                    expand: true
                    cwd: "build/toolchain"
                    src: ["**/*.js", "!**/*-unit.js"]
                    dest: "deploy/toolchain"
                ]
            platforms:
                files: [
                    expand: true
                    cwd: "build/platforms"
                    src: ["**/*.js", "!**/*-unit.js"]
                    dest: "deploy/platforms"
                ]
        coffee:
            toolchain:
                files: [
                        expand: true
                        src: ["toolchain/**/*.coffee"]
                        dest: "build"
                        ext: ".js"
                ]
            platforms:
                files: [
                        expand: true
                        src: ["platforms/**/*.coffee"]
                        dest: "build"
                        ext: ".js"
                ]
        watch:
            toolchain:
                options:
                    atBegin: true
                files: ["toolchain/**/*"]
                tasks: ["buildToolchain", "testToolchain", "deployToolchain"]
            platforms:
                files: ["deploy/toolchain/**/*", "platforms/**/*"]
                tasks: ["buildPlatforms", "testPlatforms", "deployPlatforms"]
            libraries:
                files: ["deploy/platforms/**/*", "libraries/**/*"]
                tasks: ["testLibraries"]
        concurrent:
            options:
                logConcurrentOutput: true
            tasks: ["watch:toolchain", "watch:platforms", "watch:libraries"]