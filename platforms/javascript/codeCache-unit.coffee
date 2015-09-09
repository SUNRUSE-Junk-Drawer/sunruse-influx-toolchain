describe "platforms", ->
	describe "javascript", ->
		describe "codeCache", ->
			codeCache = undefined
			beforeEach ->
				codeCache = require "./codeCache"
			describe "imports", ->
				it "valuesEquivalent", ->
					expect(codeCache.valuesEquivalent).toBe require "./../../toolchain/valuesEquivalent"
			describe "on calling", ->
				result = valuesEquivalent = existingA = existingB = existingC = cache = undefined
				beforeEach ->
					existingA = 
						code: "Test Code A"
						value: "Existing A"
					existingB = 
						code: "Test Code B"
						value: "Existing B"
					existingC = 
						code: "Test Code C"
						value: "Existing C"												
					cache = [existingA, existingB, existingC]
					valuesEquivalent = codeCache.valuesEquivalent
					codeCache.valuesEquivalent = jasmine.createSpy()
					codeCache.valuesEquivalent.and.callFake (platform, a, b) ->
						expect(platform).toBe "Test Platform"
						if a is "Existing B" and b is "Test Matchable" then return true
						if b is "Existing B" and a is "Test Matchable" then return true
				afterEach ->
					codeCache.valuesEquivalent = valuesEquivalent
				doesNotModify = ->
					it "does not modify the given cache", ->
						expect(cache.length).toEqual 3
						expect(cache[0]).toBe existingA
						expect(cache[1]).toBe existingB
						expect(cache[2]).toBe existingC
				describe "when calling with a primitive constant", ->
					describe "int", ->
						describe "zero", ->
							beforeEach ->
								result = codeCache "Test Platform", cache, 
										primitive:
											type: "int",
											value: 0
							it "returns the value as a string", ->
								expect(result).toEqual "0"
							doesNotModify()
						describe "negative", ->
							beforeEach ->
								result = codeCache "Test Platform", cache, 
										primitive:
											type: "int",
											value: -34
							it "returns the value as a string", ->
								expect(result).toEqual "-34"
							doesNotModify()							
						describe "positive", ->
							beforeEach ->
								result = codeCache "Test Platform", cache, 
										primitive:
											type: "int",
											value: 72
							it "returns the value as a string", ->
								expect(result).toEqual "72"
							doesNotModify()
					describe "float", ->
						describe "zero", ->
							it "returns the value as a string", ->
								expect codeCache "Test Platform", cache, 
										primitive:
											type: "float",
											value: 0.0
									.toEqual "0.0"
							doesNotModify()
						describe "negative", ->
							beforeEach ->
								result = codeCache "Test Platform", cache, 
									primitive:
										type: "float",
										value: -3.42
							it "returns the value as a string", ->
								expect(result).toEqual "-3.42"
							doesNotModify()							
						describe "positive", ->
							beforeEach ->
								result = codeCache "Test Platform", cache, 
									primitive:
										type: "float",
										value: 7.45
							it "returns the value as a string", ->
								expect(result).toEqual "7.45"
							doesNotModify()						
					describe "bool", ->
						describe "false", ->
							beforeEach ->
								result = codeCache "Test Platform", cache, 
									primitive:
										type: "bool",
										value: false								
							it "returns the value as a string", ->
								expect(result).toEqual "false"
							doesNotModify()
						describe "negative", ->
							beforeEach ->
								result = codeCache "Test Platform", cache, 
									primitive:
										type: "bool",
										value: true
							it "returns the value as a string", ->
								expect(result).toEqual "true"
							doesNotModify()							
				describe "when calling with a previously generated value object", ->
					beforeEach ->
						result = codeCache "Test Platform", cache, "Test Matchable"
					it "returns the previously generated value object's code", ->
						expect(result).toEqual "Test Code B"
					doesNotModify()			
				describe "when calling with a previously ungenerated native function", ->
					existingD = existingE = firstTime = undefined
					beforeEach ->
						# In reality, the recursive calls made by generating the native function's code
						# could add more steps.  We need to take these into account when naming our temporary
						# variable.
						existingD = 
							value:
								native: {}
						existingE = 
							value: {}
						firstTime = true
					describe "when no code was previously generated", ->
						input = undefined
						beforeEach ->
							input = 							
								native:
									function:
										generateCode: (platform, cached, value) ->
											expect(platform).toEqual "Test Platform"
											expect(cached).toBe cache
											expect(value).toEqual "Test Input"
											"Test Generated Code"
									input: "Test Input"
							result = codeCache "Test Platform", cache, input
						it "returns the generated code", ->
							expect(result).toEqual "temp_0"
						it "adds a reference to the generated code to the cached code", ->
							expect(cache.length).toEqual 4
							expect(cache[0]).toBe existingA
							expect(cache[1]).toBe existingB
							expect(cache[2]).toBe existingC
							expect(cache[3].working).toEqual "var temp_0 = Test Generated Code;"
							expect(cache[3].value).toBe input
							expect(cache[3].code).toEqual "temp_0"
					describe "when code was previously generated", ->
						input = undefined
						beforeEach ->
							existingA.value =
								native: {}
							existingB.value =
								native: {}								
							input = 							
								native:
									function:
										generateCode: (platform, cached, value) ->
											expect(platform).toEqual "Test Platform"
											expect(cached).toBe cache
											expect(value).toEqual "Test Input"
											"Test Generated Code"
									input: "Test Input"
							result = codeCache "Test Platform", cache, input
						it "returns the generated code", ->
							expect(result).toEqual "temp_2"
						it "adds a reference to the generated code to the cached code", ->
							expect(cache.length).toEqual 4
							expect(cache[0]).toBe existingA
							expect(cache[1]).toBe existingB
							expect(cache[2]).toBe existingC
							expect(cache[3].working).toEqual "var temp_2 = Test Generated Code;"
							expect(cache[3].value).toBe input
							expect(cache[3].code).toEqual "temp_2"
					describe "when no code was previously generated but some is recursively", ->
						input = undefined
						beforeEach ->
							input = 							
								native:
									function:
										generateCode: (platform, cached, value) ->
											expect(platform).toEqual "Test Platform"
											expect(cached).toBe cache
											expect(value).toEqual "Test Input"
											if firstTime
												cache.push existingD
												cache.push existingE
												firstTime = false
											"Test Generated Code"
									input: "Test Input"
							result = codeCache "Test Platform", cache, input
						it "returns the generated code", ->
							expect(result).toEqual "temp_1"
						it "adds a reference to the generated code to the cached code", ->
							expect(cache.length).toEqual 6
							expect(cache[0]).toBe existingA
							expect(cache[1]).toBe existingB
							expect(cache[2]).toBe existingC
							expect(cache[3]).toBe existingD
							expect(cache[4]).toBe existingE
							expect(cache[5].working).toEqual "var temp_1 = Test Generated Code;"
							expect(cache[5].value).toBe input
							expect(cache[5].code).toEqual "temp_1"
					describe "when code was previously generated", ->
						input = undefined
						beforeEach ->
							existingA.value =
								native: {}
							existingB.value =
								native: {}								
							input = 							
								native:
									function:
										generateCode: (platform, cached, value) ->
											expect(platform).toEqual "Test Platform"
											expect(cached).toBe cache
											expect(value).toEqual "Test Input"
											if firstTime
												cache.push existingD
												cache.push existingE
												firstTime = false											
											"Test Generated Code"
									input: "Test Input"
							result = codeCache "Test Platform", cache, input
						it "returns the generated code", ->
							expect(result).toEqual "temp_3"
						it "adds a reference to the generated code to the cached code", ->
							expect(cache.length).toEqual 6
							expect(cache[0]).toBe existingA
							expect(cache[1]).toBe existingB
							expect(cache[2]).toBe existingC
							expect(cache[3]).toBe existingD
							expect(cache[4]).toBe existingE
							expect(cache[5].working).toEqual "var temp_3 = Test Generated Code;"
							expect(cache[5].value).toBe input
							expect(cache[5].code).toEqual "temp_3"