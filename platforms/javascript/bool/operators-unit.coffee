platform = require "./../types"
findFunction = require "./../../../toolchain/findFunction"

describe "platforms", ->
	describe "javascript", ->
		describe "primitives", ->
			describe "bool", ->
				describe "not", ->
					it "collapses constants for false", ->
						input = 
							score: 7
							primitive:
								type: "bool"
								value: false										
						expect findFunction platform, input, "not"
							.toEqual
								score: 8
								primitive:
									type: "bool"
									value: true
					it "collapses constants for true", ->
						input = 
							score: 7
							primitive:
								type: "bool"
								value: true										
						expect findFunction platform, input, "not"
							.toEqual
								score: 8
								primitive:
									type: "bool"
									value: false									
					it "does not collapse when the input is not constant", ->
						input = 
							score: 7
							parameter:
								type: "bool"
						expect findFunction platform, input, "not"
							.toEqual
								score: 8
								native:
									function: 
										name: "not"
										compile: jasmine.any(Function)
										output: "bool"
									input:
										score: 7
										parameter:
											type: "bool"					
				describe "and", ->
					it "collapses constants for false, false", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "bool"
										value: false
								b:
									score: 7
									primitive:
										type: "bool"
										value: false										
						expect findFunction platform, input, "and"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: false
					it "collapses constants for true, true", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "bool"
										value: true
								b:
									score: 7
									primitive:
										type: "bool"
										value: true										
						expect findFunction platform, input, "and"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: true									
					it "collapses constants for true, false", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "bool"
										value: true
								b:
									score: 7
									primitive:
										type: "bool"
										value: false										
						expect findFunction platform, input, "and"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: false
					it "collapses constants for false, true", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "bool"
										value: false
								b:
									score: 7
									primitive:
										type: "bool"
										value: true										
						expect findFunction platform, input, "and"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: false									
					it "does not collapse when only the first is constant", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "bool"
										value: true
								b:
									score: 7
									parameter:
										type: "bool"
						expect findFunction platform, input, "and"
							.toEqual
								score: 11
								native:
									function: 
										name: "and"
										compile: jasmine.any(Function)
										output: "bool"
									input:
										properties:
											a:
												score: 3
												primitive:
													type: "bool"
													value: true
											b:
												score: 7
												parameter:
													type: "bool"
					it "does not collapse when only the second is constant", ->
						input = 
							properties:
								b:
									score: 3
									primitive:
										type: "bool"
										value: false
								a:
									score: 7
									parameter:
										type: "bool"
						expect findFunction platform, input, "and"
							.toEqual
								score: 11
								native:
									function: 
										name: "and"
										compile: jasmine.any(Function)
										output: "bool"
									input:
										properties:
											b:
												score: 3
												primitive:
													type: "bool"
													value: false
											a:
												score: 7
												parameter:
													type: "bool"													
					it "does not collapse when neither is constant", ->
						input = 
							properties:
								a:
									score: 3
									native:
										function:
											output: "bool"
								b:
									score: 7
									parameter:
										type: "bool"
						expect findFunction platform, input, "and"
							.toEqual
								score: 11
								native:
									function: 
										name: "and"
										compile: jasmine.any(Function)
										output: "bool"
									input:
										properties:
											a:
												score: 3
												native:
													function:
														output: "bool"
											b:
												score: 7
												parameter:
													type: "bool"
				describe "or", ->
					it "collapses constants for false, false", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "bool"
										value: false
								b:
									score: 7
									primitive:
										type: "bool"
										value: false										
						expect findFunction platform, input, "or"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: false
					it "collapses constants for true, true", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "bool"
										value: true
								b:
									score: 7
									primitive:
										type: "bool"
										value: true										
						expect findFunction platform, input, "or"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: true									
					it "collapses constants for true, false", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "bool"
										value: true
								b:
									score: 7
									primitive:
										type: "bool"
										value: false										
						expect findFunction platform, input, "or"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: true
					it "collapses constants for false, true", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "bool"
										value: false
								b:
									score: 7
									primitive:
										type: "bool"
										value: true										
						expect findFunction platform, input, "or"
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
										type: "bool"
										value: true
								b:
									score: 7
									parameter:
										type: "bool"
						expect findFunction platform, input, "or"
							.toEqual
								score: 11
								native:
									function: 
										name: "or"
										compile: jasmine.any(Function)
										output: "bool"
									input:
										properties:
											a:
												score: 3
												primitive:
													type: "bool"
													value: true
											b:
												score: 7
												parameter:
													type: "bool"
					it "does not collapse when only the second is constant", ->
						input = 
							properties:
								b:
									score: 3
									primitive:
										type: "bool"
										value: false
								a:
									score: 7
									parameter:
										type: "bool"
						expect findFunction platform, input, "or"
							.toEqual
								score: 11
								native:
									function: 
										name: "or"
										compile: jasmine.any(Function)
										output: "bool"
									input:
										properties:
											b:
												score: 3
												primitive:
													type: "bool"
													value: false
											a:
												score: 7
												parameter:
													type: "bool"													
					it "does not collapse when neither is constant", ->
						input = 
							properties:
								a:
									score: 3
									native:
										function:
											output: "bool"
								b:
									score: 7
									parameter:
										type: "bool"
						expect findFunction platform, input, "or"
							.toEqual
								score: 11
								native:
									function: 
										name: "or"
										compile: jasmine.any(Function)
										output: "bool"
									input:
										properties:
											a:
												score: 3
												native:
													function:
														output: "bool"
											b:
												score: 7
												parameter:
													type: "bool"
				describe "xor", ->
					it "collapses constants for false, false", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "bool"
										value: false
								b:
									score: 7
									primitive:
										type: "bool"
										value: false										
						expect findFunction platform, input, "xor"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: false
					it "collapses constants for true, true", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "bool"
										value: true
								b:
									score: 7
									primitive:
										type: "bool"
										value: true										
						expect findFunction platform, input, "xor"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: false									
					it "collapses constants for true, false", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "bool"
										value: true
								b:
									score: 7
									primitive:
										type: "bool"
										value: false										
						expect findFunction platform, input, "xor"
							.toEqual
								score: 11
								primitive:
									type: "bool"
									value: true
					it "collapses constants for false, true", ->
						input = 
							properties:
								a:
									score: 3
									primitive:
										type: "bool"
										value: false
								b:
									score: 7
									primitive:
										type: "bool"
										value: true										
						expect findFunction platform, input, "xor"
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
										type: "bool"
										value: true
								b:
									score: 7
									parameter:
										type: "bool"
						expect findFunction platform, input, "xor"
							.toEqual
								score: 11
								native:
									function: 
										name: "xor"
										compile: jasmine.any(Function)
										output: "bool"
									input:
										properties:
											a:
												score: 3
												primitive:
													type: "bool"
													value: true
											b:
												score: 7
												parameter:
													type: "bool"
					it "does not collapse when only the second is constant", ->
						input = 
							properties:
								b:
									score: 3
									primitive:
										type: "bool"
										value: false
								a:
									score: 7
									parameter:
										type: "bool"
						expect findFunction platform, input, "xor"
							.toEqual
								score: 11
								native:
									function: 
										name: "xor"
										compile: jasmine.any(Function)
										output: "bool"
									input:
										properties:
											b:
												score: 3
												primitive:
													type: "bool"
													value: false
											a:
												score: 7
												parameter:
													type: "bool"													
					it "does not collapse when neither is constant", ->
						input = 
							properties:
								a:
									score: 3
									native:
										function:
											output: "bool"
								b:
									score: 7
									parameter:
										type: "bool"
						expect findFunction platform, input, "xor"
							.toEqual
								score: 11
								native:
									function: 
										name: "xor"
										compile: jasmine.any(Function)
										output: "bool"
									input:
										properties:
											a:
												score: 3
												native:
													function:
														output: "bool"
											b:
												score: 7
												parameter:
													type: "bool"