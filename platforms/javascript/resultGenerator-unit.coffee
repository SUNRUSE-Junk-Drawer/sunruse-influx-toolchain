describe "platforms", ->
	describe "javascript", ->
		describe "resultGenerator", ->
			resultGenerator = undefined
			beforeEach ->
				resultGenerator = require "./resultGenerator"
			describe "imports", ->
				it "codeCache", ->
					expect(resultGenerator.codeCache).toBe require "./codeCache"
			describe "on calling", ->
				it "returns an anonymous object given properties", ->
					codeCache = resultGenerator.codeCache
					resultGenerator.codeCache = (cache, input) ->
						expect(cache).toEqual "Test Cache"
						switch input
							when "Test Property AA" then return "Test Code AA"
							when "Test Property ABA" then return "Test Code ABA"
							when "Test Property B" then return "Test Code B"
							else expect(false).toBeTruthy()
					
					output = 
						properties:
							propertyA:
								properties:
									propertyAA: "Test Property AA"
									propertyAB: 
										properties:
											propertyABA: "Test Property ABA"
							propertyB: "Test Property B"
							
					result = resultGenerator "Test Cache", output
					resultGenerator.codeCache = codeCache
									
					expect(result).toEqual 	"""
						return {
							"propertyA": {
								"propertyAA": Test Code AA,
								"propertyAB": {
									"propertyABA": Test Code ABA
								}
							},
							"propertyB": Test Code B
						};
											"""
				it "returns the generated code given non-properties", ->
					codeCache = resultGenerator.codeCache
					resultGenerator.codeCache = (cache, input) ->
						expect(cache).toEqual "Test Cache"
						expect(input).toBe output
						"Test Code"
					
					output = {}
							
					result = resultGenerator "Test Cache", output
					resultGenerator.codeCache = codeCache
									
					expect(result).toEqual 	"""
						return Test Code;
											"""					