platform = require "./../types"
findFunction = require "./../../../toolchain/findFunction"

describe "platforms", ->
	describe "javascript", ->
		describe "primitives", ->
			describe "float", ->
				describe "add", ->
					it "collapses constants", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "float"
										value: 1.2
								b:
									score: 7
									primitive:
										type: "float"
										value: 4.5										
						expect findFunction platform, input, "add"
							.toEqual
								score: 11
								primitive:
									type: "float"
									value: 5.7
					it "does not collapse when only the first is constant", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "float"
										value: 1.2
								b:
									score: 7
									parameter:
										type: "float"
						expect findFunction platform, input, "add"
							.toEqual
								score: 11
								native:
									function: 
										name: "add"
										compile: jasmine.any(Function)
										output: "float"
									input:
										properties:
											a:
												score: 3
												primitive:
													type: "float"
													value: 1.2
											b:
												score: 7
												parameter:
													type: "float"
					it "does not collapse when only the second is constant", ->
						input = 
							properties:
								b:
									score: 3
									primitive:
										type: "float"
										value: 1.2
								a:
									score: 7
									parameter:
										type: "float"
						expect findFunction platform, input, "add"
							.toEqual
								score: 11
								native:
									function: 
										name: "add"
										compile: jasmine.any(Function)
										output: "float"
									input:
										properties:
											b:
												score: 3
												primitive:
													type: "float"
													value: 1.2
											a:
												score: 7
												parameter:
													type: "float"													
					it "does not collapse when neither is constant", ->
						input = 
							properties:
								a:
									score: 3
									native:
										function:
											output: "float"
								b:
									score: 7
									parameter:
										type: "float"
						expect findFunction platform, input, "add"
							.toEqual
								score: 11
								native:
									function: 
										name: "add"
										compile: jasmine.any(Function)
										output: "float"
									input:
										properties:
											a:
												score: 3
												native:
													function:
														output: "float"
											b:
												score: 7
												parameter:
													type: "float"
				describe "subtract", ->
					it "collapses constants", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "float"
										value: 1.2
								b:
									score: 7
									primitive:
										type: "float"
										value: 4.5										
						expect findFunction platform, input, "subtract"
							.toEqual
								score: 11
								primitive:
									type: "float"
									value: -3.3
					it "does not collapse when only the first is constant", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "float"
										value: 1.2
								b:
									score: 7
									parameter:
										type: "float"
						expect findFunction platform, input, "subtract"
							.toEqual
								score: 11
								native:
									function: 
										name: "subtract"
										compile: jasmine.any(Function)
										output: "float"
									input:
										properties:
											a:
												score: 3
												primitive:
													type: "float"
													value: 1.2
											b:
												score: 7
												parameter:
													type: "float"
					it "does not collapse when only the second is constant", ->
						input = 
							properties:
								b:
									score: 3
									primitive:
										type: "float"
										value: 1.2
								a:
									score: 7
									parameter:
										type: "float"
						expect findFunction platform, input, "subtract"
							.toEqual
								score: 11
								native:
									function: 
										name: "subtract"
										compile: jasmine.any(Function)
										output: "float"
									input:
										properties:
											b:
												score: 3
												primitive:
													type: "float"
													value: 1.2
											a:
												score: 7
												parameter:
													type: "float"													
					it "does not collapse when neither is constant", ->
						input = 
							properties:
								a:
									score: 3
									native:
										function:
											output: "float"
								b:
									score: 7
									parameter:
										type: "float"
						expect findFunction platform, input, "subtract"
							.toEqual
								score: 11
								native:
									function: 
										name: "subtract"
										compile: jasmine.any(Function)
										output: "float"
									input:
										properties:
											a:
												score: 3
												native:
													function:
														output: "float"
											b:
												score: 7
												parameter:
													type: "float"													
				describe "multiply", ->
					it "collapses constants", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "float"
										value: 1.2
								b:
									score: 7
									primitive:
										type: "float"
										value: 4.5
						result = findFunction platform, input, "multiply"										
						expect result
							.toEqual
								score: 11
								primitive:
									type: "float"
									value: jasmine.any(Number)
						expect(result.primitive.value).toBeCloseTo 5.4
					it "does not collapse when only the first is constant", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "float"
										value: 1.2
								b:
									score: 7
									parameter:
										type: "float"
						expect findFunction platform, input, "multiply"
							.toEqual
								score: 11
								native:
									function: 
										name: "multiply"
										compile: jasmine.any(Function)
										output: "float"
									input:
										properties:
											a:
												score: 3
												primitive:
													type: "float"
													value: 1.2
											b:
												score: 7
												parameter:
													type: "float"
					it "does not collapse when only the second is constant", ->
						input = 
							properties:
								b:
									score: 3
									primitive:
										type: "float"
										value: 1.2
								a:
									score: 7
									parameter:
										type: "float"
						expect findFunction platform, input, "multiply"
							.toEqual
								score: 11
								native:
									function: 
										name: "multiply"
										compile: jasmine.any(Function)
										output: "float"
									input:
										properties:
											b:
												score: 3
												primitive:
													type: "float"
													value: 1.2
											a:
												score: 7
												parameter:
													type: "float"													
					it "does not collapse when neither is constant", ->
						input = 
							properties:
								a:
									score: 3
									native:
										function:
											output: "float"
								b:
									score: 7
									parameter:
										type: "float"
						expect findFunction platform, input, "multiply"
							.toEqual
								score: 11
								native:
									function: 
										name: "multiply"
										compile: jasmine.any(Function)
										output: "float"
									input:
										properties:
											a:
												score: 3
												native:
													function:
														output: "float"
											b:
												score: 7
												parameter:
													type: "float"																										
				describe "divide", ->
					it "collapses constants", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "float"
										value: 14.8
								b:
									score: 7
									primitive:
										type: "float"
										value: 2.5										
						expect findFunction platform, input, "divide"
							.toEqual
								score: 11
								primitive:
									type: "float"
									value: 5.92
					it "does not collapse when only the first is constant", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "float"
										value: 1.2
								b:
									score: 7
									parameter:
										type: "float"
						expect findFunction platform, input, "divide"
							.toEqual
								score: 11
								native:
									function: 
										name: "divide"
										compile: jasmine.any(Function)
										output: "float"
									input:
										properties:
											a:
												score: 3
												primitive:
													type: "float"
													value: 1.2
											b:
												score: 7
												parameter:
													type: "float"
					it "does not collapse when only the second is constant", ->
						input = 
							properties:
								b:
									score: 3
									primitive:
										type: "float"
										value: 1.2
								a:
									score: 7
									parameter:
										type: "float"
						expect findFunction platform, input, "divide"
							.toEqual
								score: 11
								native:
									function: 
										name: "divide"
										compile: jasmine.any(Function)
										output: "float"
									input:
										properties:
											b:
												score: 3
												primitive:
													type: "float"
													value: 1.2
											a:
												score: 7
												parameter:
													type: "float"													
					it "does not collapse when neither is constant", ->
						input = 
							properties:
								a:
									score: 3
									native:
										function:
											output: "float"
								b:
									score: 7
									parameter:
										type: "float"
						expect findFunction platform, input, "divide"
							.toEqual
								score: 11
								native:
									function: 
										name: "divide"
										compile: jasmine.any(Function)
										output: "float"
									input:
										properties:
											a:
												score: 3
												native:
													function:
														output: "float"
											b:
												score: 7
												parameter:
													type: "float"
				describe "negate", ->
					it "collapses constants", ->
						input = 
							score: 3
							primitive:
								type: "float"
								value: 1.2
						expect findFunction platform, input, "negate"
							.toEqual
								score: 4
								primitive:
									type: "float"
									value: -1.2
					it "does not collapse when the input is not a constant", ->
						input = 
							score: 7
							parameter:
								type: "float"
						expect findFunction platform, input, "negate"
							.toEqual
								score: 8
								native:
									function: 
										name: "negate"
										compile: jasmine.any(Function)
										output: "float"
									input:
										score: 7
										parameter:
											type: "float"