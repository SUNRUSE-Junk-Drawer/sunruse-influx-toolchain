describe "platforms", ->
	describe "javascript", ->
		it "can generate the SUNRUSE.influx logo", (done) ->
			files = {}
			fs = require "fs"
			fs.readFile "./examples/logo.influx", "utf8", (err, logo) ->
				expect(err).toBeFalsy()
				files.logo = logo
				fs.readFile "./libraries/pairs.influx", "utf8", (err, pairs) ->
					expect(err).toBeFalsy()
					files.pairs = pairs
					fs.readFile "./libraries/vector2d.influx", "utf8", (err, vector2d) ->
						expect(err).toBeFalsy()
						files.vector2d = vector2d
						fs.readFile "./libraries/geometry2d.influx", "utf8", (err, geometry2d) ->
							expect(err).toBeFalsy()
							files.geometry2d = geometry2d
							fs.readFile "./libraries/maths.influx", "utf8", (err, maths) ->
								expect(err).toBeFalsy()
								files.maths = maths
								tokenizer = require "./../../toolchain/tokenizer"
								tokenized = tokenizer files
								expect(tokenized).toBeTruthy()
								parameterBuilder = require "./../../cli/parameterBuilder"
								platform = (require "./types")()
								platform.functions = tokenized
								input = parameterBuilder platform, ["sample>a>float", "sample>b>float", "resolution>a>100.0", "resolution>b>40.0"]
								expect(input).toBeTruthy()
								findFunction = require "./../../toolchain/findFunction"
								output = findFunction platform, input, "main", null, null, {}
								expect(output).toBeTruthy()
								code = platform.compile platform, input, output
								compiled = new Function "input", code
								result = ""
								runtimeInput = 
									sample: {}
								symbols = [" ", "░", "▒", "▓", "█"]
								for y in [39..0]
									runtimeInput.sample.b = y
									newline = ""
									for x in [0..99]
										runtimeInput.sample.a = x
										result += symbols[compiled runtimeInput]
									result += "\n"
								console.log result
								done()