describe "platforms", -> 
	describe "helpers", ->
		describe "makeSwitch", ->
			makeSwitch = undefined
			beforeEach ->
				makeSwitch = require "./makeSwitch"
			describe "imports", ->
				it "valueIsPrimitive", ->
					expect(makeSwitch.valueIsPrimitive).toBe require "./../../toolchain/valueIsPrimitive"
				it "valuesEquivalent", ->
					expect(makeSwitch.valuesEquivalent).toBe require "./../../toolchain/valuesEquivalent"
			describe "instance", ->
				valueA = valueB = valueOn = valueIsPrimitive = valuesEquivalent = instance = undefined
				beforeEach ->
					valueIsPrimitive = makeSwitch.valueIsPrimitive
					valueA = "Test Input A"
					valueB = "Test Input B"
					valueOn = "Test Value On"
					makeSwitch.valueIsPrimitive = (value, name) ->
						switch value
							when valueA
								expect(name).toEqual "Test Primitive Type"
								return true
							when valueB
								expect(name).toEqual "Test Primitive Type"
								return true
							when valueOn
								expect(name).toEqual "bool"
								return true
					instance = makeSwitch "Test Primitive Type", "Test Generate Code"
				afterEach -> 
					makeSwitch.valueIsPrimitive = valueIsPrimitive
				it "sets a name of \"switch\"", ->
					expect(instance.name).toEqual "switch"
				it "sets the return type", ->
					expect(instance.output).toEqual "Test Primitive Type"
				it "copies \"generateCode\"", ->
					expect(instance.generateCode).toEqual "Test Generate Code"
				describe "compile", ->
					describe "without properties", ->
						it "returns falsy", ->
							expect instance.compile {}
								.toBeFalsy()
					describe "with properties", ->
						describe "without a", ->
							it "returns falsy", ->
								expect instance.compile
										properties:
											b: {}
											c: {}
											on: {}
									.toBeFalsy()
						describe "without b", ->
							it "returns falsy", ->
								expect instance.compile
										properties:
											a: {}
											c: {}
											on: {}
									.toBeFalsy()
						describe "without on", ->
							it "returns falsy", ->
								expect instance.compile
										properties:
											a: {}
											c: {}
											b: {}
									.toBeFalsy()
						describe "with the required properties", ->
							describe "when a is not of the correct primitive type", ->
								it "returns falsy", ->
									expect instance.compile
											properties:
												a: "Test Incorrect Input A"
												c: "Test Input C"
												b: "Test Input B"
												on: "Test Input On"
										.toBeFalsy()
							describe "when b is not of the correct primitive type", ->
								it "returns falsy", ->
									expect instance.compile
											properties:
												a: "Test Input A"
												c: "Test Input C"
												b: "Test Incorrect Input B"
												on: "Test Input On"
										.toBeFalsy()
							describe "when bool is not of the correct primitive type", ->
								it "returns falsy", ->
									expect instance.compile
											properties:
												a: "Test Incorrect Input A"
												c: "Test Input C"
												b: "Test Input B"
												on: "Test Input On"
										.toBeFalsy()
							describe "when all properties are of the correct type", ->
								describe "when \"on\" is constant", ->
									describe "when \"on\" is false", ->
										it "returns \"a\"", ->
											result = instance.compile
													properties:
														a: valueA =
															score: 4
															contents: {}
														b: valueB = 
															score: 7
															contents: {}
														on: valueOn = 
															score: 10
															primitive:
																value: false
														c: 
															score: 150
															value: "Ignored" 
											expect(result).toEqual
												score: 22
												contents: jasmine.any Object
											expect(result.contents).toBe valueA.contents												
									describe "when \"on\" is true", ->
										it "returns \"b\"", ->
											result = instance.compile
													properties:
														a: valueA =
															score: 4
															contents: {}
														b: valueB = 
															score: 7
															contents: {}
														on: valueOn = 
															score: 10
															primitive:
																value: true
														c: 
															score: 150
															value: "Ignored" 
											expect(result).toEqual
												score: 22
												contents: jasmine.any Object
											expect(result.contents).toBe valueB.contents
								describe "when \"on\" is non-constant", ->
									it "returns a native function", ->
										input = 											
											properties:
												a: valueA = 
													score: 3
												b: valueB = 
													score: 4
												on: valueOn = 
													score: 10
												c: 
													score: 25
										result = instance.compile input
										expect(result).toEqual
												score: 18
												native:
													function: jasmine.any Object
													input: 
														score: 17
														properties:
															a: jasmine.any Object
															b: jasmine.any Object
															on: jasmine.any Object
										expect(result.native.function).toBe instance
										expect(result.native.input.properties.a).toBe input.properties.a
										expect(result.native.input.properties.b).toBe input.properties.b
										expect(result.native.input.properties.on).toBe input.properties.on
				describe "inputsEqual", ->
					xit "returns truthy when \"a\", \"b\" and \"on\" match", ->
					xit "returns falsy when \"a\" does not match", ->
					xit "returns falsy when \"b\" does not match", ->
					xit "returns falsy when \"on\" does not match", ->					