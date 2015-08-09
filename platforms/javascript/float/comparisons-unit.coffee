platform = require "./../types"
findFunction = require "./../../../toolchain/findFunction"

describe "platforms", ->
	describe "javascript", ->
		describe "primitives", ->
			describe "float", ->
				describe "equal", ->
					it "collapses constants to false", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "float"
										value: 5.6
								b:
									score: 7
									primitive:
										type: "float"
										value: 5.4										
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
										type: "float"
										value: 5.4
								b:
									score: 7
									primitive:
										type: "float"
										value: 5.4										
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
										type: "float"
										value: 5.4
								b:
									score: 7
									parameter:
										type: "float"
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
													type: "float"
													value: 5.4
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
										value: 5.4
								a:
									score: 7
									parameter:
										type: "float"
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
													type: "float"
													value: 5.4
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
														output: "float"
											b:
												score: 7
												parameter:
													type: "float"
				describe "less", ->
					it "collapses constants to false when greater", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "float"
										value: 5.4
								b:
									score: 7
									primitive:
										type: "float"
										value: 5.3										
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
										type: "float"
										value: 5.4
								b:
									score: 7
									primitive:
										type: "float"
										value: 5.4										
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
										type: "float"
										value: 5.4
								b:
									score: 7
									primitive:
										type: "float"
										value: 5.7										
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
										type: "float"
										value: 5.4
								b:
									score: 7
									parameter:
										type: "float"
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
													type: "float"
													value: 5.4
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
										value: 5.4
								a:
									score: 7
									parameter:
										type: "float"
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
													type: "float"
													value: 5.4
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
														output: "float"
											b:
												score: 7
												parameter:
													type: "float"
				describe "greater", ->
					it "collapses constants to false when less", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "float"
										value: 5.4
								b:
									score: 7
									primitive:
										type: "float"
										value: 5.7										
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
										type: "float"
										value: 5.4
								b:
									score: 7
									primitive:
										type: "float"
										value: 5.4										
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
										type: "float"
										value: 5.4
								b:
									score: 7
									primitive:
										type: "float"
										value: 4.3										
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
										type: "float"
										value: 5.4
								b:
									score: 7
									parameter:
										type: "float"
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
													type: "float"
													value: 5.4
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
										value: 5.4
								a:
									score: 7
									parameter:
										type: "float"
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
													type: "float"
													value: 5.4
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
														output: "float"
											b:
												score: 7
												parameter:
													type: "float"																																							
				describe "lessOrEqual", ->
					it "collapses constants to false", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "float"
										value: 5.4
								b:
									score: 7
									primitive:
										type: "float"
										value: 5.3										
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
										type: "float"
										value: 5.4
								b:
									score: 7
									primitive:
										type: "float"
										value: 5.4										
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
										type: "float"
										value: 5.4
								b:
									score: 7
									primitive:
										type: "float"
										value: 5.7										
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
										type: "float"
										value: 5.4
								b:
									score: 7
									parameter:
										type: "float"
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
													type: "float"
													value: 5.4
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
										value: 5.4
								a:
									score: 7
									parameter:
										type: "float"
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
													type: "float"
													value: 5.4
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
														output: "float"
											b:
												score: 7
												parameter:
													type: "float"
				describe "greaterOrEqual", ->
					it "collapses constants to false", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "float"
										value: 5.4
								b:
									score: 7
									primitive:
										type: "float"
										value: 5.7										
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
										type: "float"
										value: 5.4
								b:
									score: 7
									primitive:
										type: "float"
										value: 5.4										
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
										type: "float"
										value: 5.4
								b:
									score: 7
									primitive:
										type: "float"
										value: 5.3										
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
										type: "float"
										value: 5.4
								b:
									score: 7
									parameter:
										type: "float"
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
													type: "float"
													value: 5.4
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
										value: 5.4
								a:
									score: 7
									parameter:
										type: "float"
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
													type: "float"
													value: 5.4
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
														output: "float"
											b:
												score: 7
												parameter:
													type: "float"																																																				