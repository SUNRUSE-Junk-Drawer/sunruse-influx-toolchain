require "jasmine-collection-matchers"

describe "toolchain", ->
	describe "runAssertions", ->
		runAssertions = undefined
		beforeEach ->
			runAssertions = require "./runAssertions"
		describe "imports", ->
			it "compileExpression", ->
				expect(runAssertions.compileExpression).toBe require "./compileExpression"
		describe "on calling", ->
			compileExpression = platform = undefined
			beforeEach ->
				platform = 
					functions: [
							name: "ignore function a",
							declarations: 
								a: "ignore function a a"
								output: "ignore function a output"
								b: "ignore function a b"
						,
							name: "assert",
							declarations: 
								a: "assert a a"
								output: "assert a output"
								b: "assert a b"
						,
							name: "assert",
							declarations: 
								a: "assert b a"
								output: "assert b output"
								b: "assert b b"
						,
							name: "assert",
							declarations: 
								a: "assert c a"
								output: "assert c output"
								b: "assert c b"
						,
							name: "assert",
							declarations: 
								a: "assert d a"
								output: "assert d output"
								b: "assert d b"
						,
							name: "assert",
							declarations: 
								a: "assert e a"
								output: "assert e output"
								b: "assert e b"
						,
							name: "ignore function b",
							declarations: 
								a: "ignore function b a"
								output: "ignore function b output"
								b: "ignore function b b"
					]
					primitives:
						primitiveA:
							assertionPass: "assertion pass a"
							equal: (a, b) ->
								expect(a is "assertion pass a" or b is "assertion pass a").toBeTruthy()
								expect(a is "assert d result" or b is "assert d result").toBeTruthy()
								return false
						primitiveB:
							equal: (a, b) ->
								expect(false).toBeTruthy()
						primitiveC:
							assertionPass: "assertion pass c"
							equal: (a, b) ->
								expect(a is "assertion pass c" or b is "assertion pass c").toBeTruthy()
								expect(a is "assert e result" or b is "assert e result").toBeTruthy()
								return true
				
				compileExpression = runAssertions.compileExpression
				runAssertions.compileExpression = (_platform, input, expression, funct, log, logPrefix, cache) ->
					expect(cache).toEqual {}
					expect(_platform).toBe platform
					expect(input).toEqual
						score: 0
						properties: {}
					switch funct
						when platform.functions[1]
							expect(expression).toEqual "assert a output"
							return null
						when platform.functions[2]
							expect(expression).toEqual "assert b output"
							return unused =
								parameter:
									type: "primitiveC"
						when platform.functions[3]
							expect(expression).toEqual "assert c output"
							return unused =
								primitive:
									type: "primitiveB"
									value: "assert c result"
						when platform.functions[4]
							expect(expression).toEqual "assert d output"
							return unused =
								primitive:
									type: "primitiveA"
									value: "assert d result"
						when platform.functions[5]
							expect(expression).toEqual "assert e output"
							return unused =
								primitive:
									type: "primitiveC"
									value: "assert e result"
						else
							expect(false).toBeTruthy()
					
			afterEach ->
				runAssertions.compileExpression = compileExpression
					
			it "returns the test results", ->
				expected = [
						resultType: "failedToCompile"
						assertion: platform.functions[1]
					,
						resultType: "didNotReturnPrimitiveConstant"
						assertion: platform.functions[2]
						output:
							parameter:
								type: "primitiveC"
					,
						resultType: "primitiveTypeNotAssertable"
						assertion: platform.functions[3]
						output:
							primitive:
								type: "primitiveB"
								value: "assert c result"
					,
						resultType: "primitiveValueIncorrect"
						assertion: platform.functions[4]
						output:
							primitive:
								type: "primitiveA"
								value: "assert d result"
					,
						resultType: "successful"
						assertion: platform.functions[5]
						output:
							primitive:
								type: "primitiveC"
								value: "assert e result"
				]
				
				actual = runAssertions platform
				
				expect(actual).toHaveSameItems expected