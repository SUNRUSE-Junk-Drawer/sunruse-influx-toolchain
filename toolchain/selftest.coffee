# This runs every assertion in the included standard library.
fs = require "fs"
tokenizer = require "./tokenizer"
runAssertions = require "./runAssertions"
platform = require "./../platforms/javascript/types"

describe "library self-test", ->
	paths =
		folder: "libraries"
		directories: []
		files: []
		
	allFiles = {}
	
	callback = (path, obj) ->
		stat = fs.lstatSync path
		if stat.isDirectory()
			lastEl = path.split "/"
			lastEl = lastEl[lastEl.length - 1]
			newobj = 
				folder: lastEl
				directories: []
				files: []
			obj.directories.push newobj
			for file in fs.readdirSync path
				subPath = path + "/" + file
				callback subPath, newobj
		else if stat.isFile()
			obj.files.push path
			allFiles[path] = fs.readFileSync path, 
				encoding: "utf8"
						
	callback "./libraries", paths
	
	tokenized = tokenizer allFiles
	
	it "tokenizes", ->
		expect(tokenized).toBeTruthy()
		
	platform.functions = tokenized
		
	assertions = runAssertions platform
		
	describe "assertions", ->	
		recurse = (obj) ->
			describe obj.folder, ->
				if obj.files.length
					describe "files", ->
						for file in obj.files
							lastEl = file.split "/"
							lastEl = lastEl[lastEl.length - 1]
							describe lastEl, ->
								for assertion in assertions when assertion.assertion.line.filename is file
									do (assertion) ->
										it "line " + assertion.assertion.line.line, ->
											expect(assertion.resultType).toEqual "successful", if assertion?.output?.primitive then assertion.output.primitive.type + ": " + JSON.stringify assertion.output.primitive.value
				if obj.directories.length
					describe "subdirectories", ->
						for file in obj.directories
							recurse file
		recurse paths