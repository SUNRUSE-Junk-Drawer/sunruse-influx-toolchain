platform = require "./../types"
findFunction = require "./../../../toolchain/findFunction"

describe "platforms", ->
	describe "javascript", ->
		describe "primitives", ->
			describe "int", ->
				describe "equal", ->
					it "collapses constants to false", ->
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
						expect findFunction platform, input, "equal"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: false
					it "collapses constants to true", ->
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
										value: 90										
						expect findFunction platform, input, "equal"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: true									
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
						expect findFunction platform, input, "equal"
							.toEqual
								score: 11
								native:
									function: 
										name: "equal"
										compile: jasmine.any(Function)
										output: "bool"
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
						expect findFunction platform, input, "equal"
							.toEqual
								score: 11
								native:
									function: 
										name: "equal"
										compile: jasmine.any(Function)
										output: "bool"
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
						expect findFunction platform, input, "equal"
							.toEqual
								score: 11
								native:
									function: 
										name: "equal"
										compile: jasmine.any(Function)
										output: "bool"
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
				describe "less", ->
					it "collapses constants to false when greater", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "int"
										value: 8
								b:
									score: 7
									primitive:
										type: "int"
										value: 7										
						expect findFunction platform, input, "less"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: false
					it "collapses constants to false when equal", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "int"
										value: 8
								b:
									score: 7
									primitive:
										type: "int"
										value: 8										
						expect findFunction platform, input, "less"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: false									
					it "collapses constants to true", ->
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
										value: 91										
						expect findFunction platform, input, "less"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: true									
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
						expect findFunction platform, input, "less"
							.toEqual
								score: 11
								native:
									function: 
										name: "less"
										compile: jasmine.any(Function)
										output: "bool"
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
						expect findFunction platform, input, "less"
							.toEqual
								score: 11
								native:
									function: 
										name: "less"
										compile: jasmine.any(Function)
										output: "bool"
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
						expect findFunction platform, input, "less"
							.toEqual
								score: 11
								native:
									function: 
										name: "less"
										compile: jasmine.any(Function)
										output: "bool"
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
				describe "greater", ->
					it "collapses constants to false when less", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "int"
										value: 4
								b:
									score: 7
									primitive:
										type: "int"
										value: 5										
						expect findFunction platform, input, "greater"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: false
					it "collapses constants to false when equal", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "int"
										value: 4
								b:
									score: 7
									primitive:
										type: "int"
										value: 4										
						expect findFunction platform, input, "greater"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: false									
					it "collapses constants to true", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "int"
										value: 5
								b:
									score: 7
									primitive:
										type: "int"
										value: 4										
						expect findFunction platform, input, "greater"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: true									
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
						expect findFunction platform, input, "greater"
							.toEqual
								score: 11
								native:
									function: 
										name: "greater"
										compile: jasmine.any(Function)
										output: "bool"
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
						expect findFunction platform, input, "greater"
							.toEqual
								score: 11
								native:
									function: 
										name: "greater"
										compile: jasmine.any(Function)
										output: "bool"
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
						expect findFunction platform, input, "greater"
							.toEqual
								score: 11
								native:
									function: 
										name: "greater"
										compile: jasmine.any(Function)
										output: "bool"
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
				describe "lessOrEqual", ->
					it "collapses constants to false", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "int"
										value: 8
								b:
									score: 7
									primitive:
										type: "int"
										value: 7										
						expect findFunction platform, input, "lessOrEqual"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: false
					it "collapses constants to true when equal", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "int"
										value: 8
								b:
									score: 7
									primitive:
										type: "int"
										value: 8										
						expect findFunction platform, input, "lessOrEqual"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: true									
					it "collapses constants to true when less", ->
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
										value: 91										
						expect findFunction platform, input, "lessOrEqual"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: true									
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
						expect findFunction platform, input, "lessOrEqual"
							.toEqual
								score: 11
								native:
									function: 
										name: "lessOrEqual"
										compile: jasmine.any(Function)
										output: "bool"
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
						expect findFunction platform, input, "lessOrEqual"
							.toEqual
								score: 11
								native:
									function: 
										name: "lessOrEqual"
										compile: jasmine.any(Function)
										output: "bool"
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
						expect findFunction platform, input, "lessOrEqual"
							.toEqual
								score: 11
								native:
									function: 
										name: "lessOrEqual"
										compile: jasmine.any(Function)
										output: "bool"
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
				describe "greaterOrEqual", ->
					it "collapses constants to false", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "int"
										value: 4
								b:
									score: 7
									primitive:
										type: "int"
										value: 5										
						expect findFunction platform, input, "greaterOrEqual"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: false
					it "collapses constants to true when equal", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "int"
										value: 4
								b:
									score: 7
									primitive:
										type: "int"
										value: 4										
						expect findFunction platform, input, "greaterOrEqual"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: true									
					it "collapses constants to true when greater", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "int"
										value: 5
								b:
									score: 7
									primitive:
										type: "int"
										value: 4										
						expect findFunction platform, input, "greaterOrEqual"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: true									
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
						expect findFunction platform, input, "greaterOrEqual"
							.toEqual
								score: 11
								native:
									function: 
										name: "greaterOrEqual"
										compile: jasmine.any(Function)
										output: "bool"
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
						expect findFunction platform, input, "greaterOrEqual"
							.toEqual
								score: 11
								native:
									function: 
										name: "greaterOrEqual"
										compile: jasmine.any(Function)
										output: "bool"
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
						expect findFunction platform, input, "greaterOrEqual"
							.toEqual
								score: 11
								native:
									function: 
										name: "greaterOrEqual"
										compile: jasmine.any(Function)
										output: "bool"
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