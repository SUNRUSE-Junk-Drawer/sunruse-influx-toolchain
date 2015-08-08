platform = require "./../types"
findFunction = require "./../../../toolchain/findFunction"

describe "platforms", ->
	describe "javascript", ->
		describe "primitives", ->
			describe "int", ->
				describe "add", ->
					it "collapses constants", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "int"
										value: 12
								b:
									score: 7
									primitive:
										type: "int"
										value: 21										
						expect findFunction platform, input, "add"
							.toEqual
								score: 11
								primitive:
									type: "int"
									value: 33
					it "does not collapse when only the first is constant", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "int"
										value: 12
								b:
									score: 7
									parameter:
										type: "int"
						expect findFunction platform, input, "add"
							.toEqual
								score: 11
								native:
									function: 
										name: "add"
										compile: jasmine.any(Function)
										output: "int"
									input:
										properties:
											a:
												score: 3
												primitive:
													type: "int"
													value: 12
											b:
												score: 7
												parameter:
													type: "int"
					it "does not collapse when only the second is constant", ->
						input = 
							properties:
								b:
									score: 3
									primitive:
										type: "int"
										value: 12
								a:
									score: 7
									parameter:
										type: "int"
						expect findFunction platform, input, "add"
							.toEqual
								score: 11
								native:
									function: 
										name: "add"
										compile: jasmine.any(Function)
										output: "int"
									input:
										properties:
											b:
												score: 3
												primitive:
													type: "int"
													value: 12
											a:
												score: 7
												parameter:
													type: "int"													
					it "does not collapse when neither is constant", ->
						input = 
							properties:
								a:
									score: 3
									native:
										function:
											output: "int"
								b:
									score: 7
									parameter:
										type: "int"
						expect findFunction platform, input, "add"
							.toEqual
								score: 11
								native:
									function: 
										name: "add"
										compile: jasmine.any(Function)
										output: "int"
									input:
										properties:
											a:
												score: 3
												native:
													function:
														output: "int"
											b:
												score: 7
												parameter:
													type: "int"
				describe "subtract", ->
					it "collapses constants", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "int"
										value: 12
								b:
									score: 7
									primitive:
										type: "int"
										value: 21										
						expect findFunction platform, input, "subtract"
							.toEqual
								score: 11
								primitive:
									type: "int"
									value: -9
					it "does not collapse when only the first is constant", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "int"
										value: 12
								b:
									score: 7
									parameter:
										type: "int"
						expect findFunction platform, input, "subtract"
							.toEqual
								score: 11
								native:
									function: 
										name: "subtract"
										compile: jasmine.any(Function)
										output: "int"
									input:
										properties:
											a:
												score: 3
												primitive:
													type: "int"
													value: 12
											b:
												score: 7
												parameter:
													type: "int"
					it "does not collapse when only the second is constant", ->
						input = 
							properties:
								b:
									score: 3
									primitive:
										type: "int"
										value: 12
								a:
									score: 7
									parameter:
										type: "int"
						expect findFunction platform, input, "subtract"
							.toEqual
								score: 11
								native:
									function: 
										name: "subtract"
										compile: jasmine.any(Function)
										output: "int"
									input:
										properties:
											b:
												score: 3
												primitive:
													type: "int"
													value: 12
											a:
												score: 7
												parameter:
													type: "int"													
					it "does not collapse when neither is constant", ->
						input = 
							properties:
								a:
									score: 3
									native:
										function:
											output: "int"
								b:
									score: 7
									parameter:
										type: "int"
						expect findFunction platform, input, "subtract"
							.toEqual
								score: 11
								native:
									function: 
										name: "subtract"
										compile: jasmine.any(Function)
										output: "int"
									input:
										properties:
											a:
												score: 3
												native:
													function:
														output: "int"
											b:
												score: 7
												parameter:
													type: "int"													
				describe "multiply", ->
					it "collapses constants", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "int"
										value: 12
								b:
									score: 7
									primitive:
										type: "int"
										value: 21										
						expect findFunction platform, input, "multiply"
							.toEqual
								score: 11
								primitive:
									type: "int"
									value: 252
					it "does not collapse when only the first is constant", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "int"
										value: 12
								b:
									score: 7
									parameter:
										type: "int"
						expect findFunction platform, input, "multiply"
							.toEqual
								score: 11
								native:
									function: 
										name: "multiply"
										compile: jasmine.any(Function)
										output: "int"
									input:
										properties:
											a:
												score: 3
												primitive:
													type: "int"
													value: 12
											b:
												score: 7
												parameter:
													type: "int"
					it "does not collapse when only the second is constant", ->
						input = 
							properties:
								b:
									score: 3
									primitive:
										type: "int"
										value: 12
								a:
									score: 7
									parameter:
										type: "int"
						expect findFunction platform, input, "multiply"
							.toEqual
								score: 11
								native:
									function: 
										name: "multiply"
										compile: jasmine.any(Function)
										output: "int"
									input:
										properties:
											b:
												score: 3
												primitive:
													type: "int"
													value: 12
											a:
												score: 7
												parameter:
													type: "int"													
					it "does not collapse when neither is constant", ->
						input = 
							properties:
								a:
									score: 3
									native:
										function:
											output: "int"
								b:
									score: 7
									parameter:
										type: "int"
						expect findFunction platform, input, "multiply"
							.toEqual
								score: 11
								native:
									function: 
										name: "multiply"
										compile: jasmine.any(Function)
										output: "int"
									input:
										properties:
											a:
												score: 3
												native:
													function:
														output: "int"
											b:
												score: 7
												parameter:
													type: "int"																										
				describe "divide", ->
					it "collapses constants", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "int"
										value: 90
								b:
									score: 7
									primitive:
										type: "int"
										value: 7										
						expect findFunction platform, input, "divide"
							.toEqual
								score: 11
								primitive:
									type: "int"
									value: 12
					it "does not collapse when only the first is constant", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "int"
										value: 12
								b:
									score: 7
									parameter:
										type: "int"
						expect findFunction platform, input, "divide"
							.toEqual
								score: 11
								native:
									function: 
										name: "divide"
										compile: jasmine.any(Function)
										output: "int"
									input:
										properties:
											a:
												score: 3
												primitive:
													type: "int"
													value: 12
											b:
												score: 7
												parameter:
													type: "int"
					it "does not collapse when only the second is constant", ->
						input = 
							properties:
								b:
									score: 3
									primitive:
										type: "int"
										value: 12
								a:
									score: 7
									parameter:
										type: "int"
						expect findFunction platform, input, "divide"
							.toEqual
								score: 11
								native:
									function: 
										name: "divide"
										compile: jasmine.any(Function)
										output: "int"
									input:
										properties:
											b:
												score: 3
												primitive:
													type: "int"
													value: 12
											a:
												score: 7
												parameter:
													type: "int"													
					it "does not collapse when neither is constant", ->
						input = 
							properties:
								a:
									score: 3
									native:
										function:
											output: "int"
								b:
									score: 7
									parameter:
										type: "int"
						expect findFunction platform, input, "divide"
							.toEqual
								score: 11
								native:
									function: 
										name: "divide"
										compile: jasmine.any(Function)
										output: "int"
									input:
										properties:
											a:
												score: 3
												native:
													function:
														output: "int"
											b:
												score: 7
												parameter:
													type: "int"
				describe "negate", ->
					it "collapses constants", ->
						input = 
							score: 3
							primitive:
								type: "int"
								value: 12
						expect findFunction platform, input, "negate"
							.toEqual
								score: 4
								primitive:
									type: "int"
									value: -12
					it "does not collapse when the input is not a constant", ->
						input = 
							score: 7
							parameter:
								type: "int"
						expect findFunction platform, input, "negate"
							.toEqual
								score: 8
								native:
									function: 
										name: "negate"
										compile: jasmine.any(Function)
										output: "int"
									input:
										score: 7
										parameter:
											type: "int"