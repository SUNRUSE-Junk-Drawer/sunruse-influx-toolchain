require "jasmine-collection-matchers"

describe "tokenizer", ->
	tokenizer = input = undefined
	beforeEach ->
		tokenizer = require "./tokenizer"
		input = 
			test_file_a: 
				"""
					
					directOutput
						output testValue				
					propertyOutput
						output
							testPropertyA testValueA 
							
							testPropertyB testValueB testFunctionBA testFunctionBB
							testPropertyC
								testNestedPropertyA testValueCA
								 	
								testNestedPropertyB testValueCB testFunctionCBA testFunctionCBB
								testNestedPropertyC
									testDoubleNestedValueA testDoubleNestedValueCCA

									testDoubleNestedValueB testDoubleNestedValueCCB testFunctionCCBA testFunctionCCBB
				"""								 
			test_file_b:
				"""
					withTemporaryVariables   					
						tempVarA tempValA

						tempVarB tempValB tempFuncBA tempFuncBB
						tempVarC
							tempPropCA tempValCA
							tempPropCB tempValCB tempFuncCBA tempFuncCBB
							tempPropCC
								tempSubPropA tempSubValCCA
								
								tempSubPropB tempSubValCCB tempFuncCCBA tempFuncCCBB
						output tempVarC
				"""	
	
	it "generates a set of functions from the given data", ->
		result = tokenizer input
		
		expected = [
				name: "directOutput"
				line:
					filename: "test_file_a"
					line: 1,
					columns:
						from: 0
						to: 12				
				declarations:
					output:
						line:
							filename: "test_file_a"
							line: 2
							columns:
								from: 1
								to: 7					
						chain: [
							token: "testValue"
							line:
								filename: "test_file_a"
								line: 2
								columns: 
									from: 8
									to: 17
						]
			,
				name: "propertyOutput"
				line:
					filename: "test_file_a"
					line: 3
					columns:
						from: 0
						to: 14					
				declarations:
					output:
						line:
							filename: "test_file_a"
							line: 4
							columns:
								from: 1
								to: 7
						properties:
							testPropertyA:
								line:
									filename: "test_file_a"
									line: 5
									columns:
										from: 2
										to: 15								
								chain: [
									token: "testValueA"
									line:
										filename: "test_file_a"
										line: 5
										columns:
											from: 16
											to:	26
								]		
							testPropertyB:
								line:
									filename: "test_file_a"
									line: 7
									columns: 
										from: 2
										to: 15
								chain: [
										token: "testValueB"
										line:
											filename: "test_file_a"
											line: 7
											columns: 
												from: 16
												to: 26
									,
										token: "testFunctionBA"
										line:
											filename: "test_file_a"
											line: 7
											columns: 
												from: 27
												to: 41
									,
										token: "testFunctionBB"
										line:
											filename: "test_file_a"
											line: 7
											columns: 
												from: 42
												to: 56
								]
							testPropertyC:
								line:
									filename: "test_file_a"
									line: 8
									columns: 
										from: 2
										to: 15
								properties:
									testNestedPropertyA:
										line:
											filename: "test_file_a"
											line: 9
											columns: 
												from: 3
												to: 22
										chain: [
											token: "testValueCA"
											line:
												filename: "test_file_a"
												line: 9
												columns:
													from: 23
													to: 34
										]
									testNestedPropertyB:
										line:
											filename: "test_file_a"
											line: 11
											columns: 
												from: 3
												to: 22
										chain: [
												token: "testValueCB"
												line:
													filename: "test_file_a"
													line: 11
													columns:
														from: 23
														to: 34
											,
												token: "testFunctionCBA"
												line:
													filename: "test_file_a"
													line: 11
													columns:
														from: 35
														to: 50											
											,
												token: "testFunctionCBB"
												line:
													filename: "test_file_a"
													line: 11
													columns:
														from: 51
														to: 66											
										]
									testNestedPropertyC:
										line:
											filename: "test_file_a"
											line: 12
											columns: 
												from: 3
												to: 22
										properties:
											testDoubleNestedValueA:
												line:
													filename: "test_file_a"
													line: 13
													columns:
														from: 4
														to: 26
												chain: [
													token: "testDoubleNestedValueCCA"
													line:
														filename: "test_file_a"
														line: 13
														columns: 
															from: 27
															to: 51
												]
											testDoubleNestedValueB:
												line:
													filename: "test_file_a"
													line: 15
													columns:
														from: 4
														to: 26
												chain: [
														token: "testDoubleNestedValueCCB"
														line:
															filename: "test_file_a"
															line: 15
															columns: 
																from: 27
																to: 51
													,
														token: "testFunctionCCBA"
														line:
															filename: "test_file_a"
															line: 15
															columns: 
																from: 52
																to: 68
													,
														token: "testFunctionCCBB"
														line:
															filename: "test_file_a"
															line: 15
															columns: 
																from: 69
																to: 85													
												]												
			,
				name: "withTemporaryVariables"
				line:
					filename: "test_file_b"
					line: 0
					columns:
						from: 0
						to: 22
				declarations:
					tempVarA:
						line:
							filename: "test_file_b"
							line: 1
							columns:
								from: 1
								to: 9
						chain: [
							token: "tempValA"
							line:
								filename: "test_file_b"
								line: 1
								columns:
									from: 10
									to: 18
						]
					tempVarB:
						line:
							filename: "test_file_b"
							line: 3
							columns:
								from: 1
								to: 9
						chain: [
								token: "tempValB"
								line:
									filename: "test_file_b"
									line: 3
									columns:
										from: 10
										to: 18
							,
								token: "tempFuncBA"
								line:
									filename: "test_file_b"
									line: 3
									columns:
										from: 19
										to: 29
							,
								token: "tempFuncBB"
								line:
									filename: "test_file_b"
									line: 3
									columns:
										from: 30
										to: 40							
						]						
					tempVarC:
						line:
							filename: "test_file_b"
							line: 4
							columns:
								from: 1
								to: 9
						properties:
							tempPropCA:
								line:
									filename: "test_file_b"
									line: 5
									columns:
										from: 2
										to: 12
								chain: [
									token: "tempValCA"
									line:
										filename: "test_file_b"
										line: 5
										columns:
											from: 13
											to: 22
								]
							tempPropCB:
								line:
									filename: "test_file_b"
									line: 6
									columns:
										from: 2
										to: 12
								chain: [
										token: "tempValCB"
										line:
											filename: "test_file_b"
											line: 6
											columns:
												from: 13
												to: 22
									,
										token: "tempFuncCBA"
										line:
											filename: "test_file_b"
											line: 6
											columns:
												from: 23
												to: 34									
									,
										token: "tempFuncCBB"
										line:
											filename: "test_file_b"
											line: 6
											columns:
												from: 35
												to: 46																						
								]								
							tempPropCC:
								line:
									filename: "test_file_b"
									line: 7
									columns:
										from: 2
										to: 12								
								properties:
									tempSubPropA:
										line:
											filename: "test_file_b"
											line: 8
											columns:
												from: 3
												to: 15
										chain: [
											token: "tempSubValCCA"
											line:
												filename: "test_file_b"
												line: 8
												columns:
													from: 16
													to: 29
										]
									tempSubPropB:
										line:
											filename: "test_file_b"
											line: 10
											columns:
												from: 3
												to: 15
										chain: [
												token: "tempSubValCCB"
												line:
													filename: "test_file_b"
													line: 10
													columns:
														from: 16
														to: 29
											,
												token: "tempFuncCCBA"
												line:
													filename: "test_file_b"
													line: 10
													columns:
														from: 30
														to: 42
											,
												token: "tempFuncCCBB"
												line:
													filename: "test_file_b"
													line: 10
													columns:
														from: 43
														to: 55																																				
										]
					output:
						line:
							filename: "test_file_b"
							line: 11
							columns:
								from: 1
								to: 7
						chain: [
							token: "tempVarC"
							line:
								filename: "test_file_b"
								line: 11
								columns:
									from: 8
									to: 16
						]
		]
		
		expect(result).toHaveSameItems expected		
		
	it "throws an exception when unindenting to a previously unused level", ->
		input.test_file_c = 
			"""
				badFunction
					declarationA
							propertyAA 3
							propertyAB
								propertyABA 8
						declarationB 7
					declarationC 88
			"""
		
		expect ->
			tokenizer input
		.toThrow
			reason: "unindentedToUnexpectedLevel"		
			line:
				filename: "test_file_c"
				line: 5
				columns:
					from: 2
					to: 16
		
	it "throws an exception when two declarations in a function share the same name", ->
		input.test_file_c = 
			"""
				badFunction
					declarationA 55
					declarationB 44
					declarationB 88
					declarationD 87
			"""
		
		expect ->
			tokenizer input
		.toThrow
			reason: "declarationNamesNotUnique"		
			line:
				filename: "test_file_c"
				line: 3
				columns:
					from: 1
					to: 13
		
	it "throws an exception when a function declares nothing", ->
		input.test_file_c = 
			"""
				badFunction
			"""
		
		expect ->
			tokenizer input
		.toThrow
			reason: "functionHasNoOutput"		
			line:
				filename: "test_file_c"
				line: 0
				columns:
					from: 0
					to: 11		
		
	it "throws an exception when a function declares temporary variables but no output", ->
		input.test_file_c = 
			"""
				badFunction
					tempVar 123
			"""
		
		expect ->
			tokenizer input
		.toThrow
			reason: "functionHasNoOutput"		
			line:
				filename: "test_file_c"
				line: 0
				columns:
					from: 0
					to: 11				
		
	it "throws an exception when a temporary variable defines a duplicate object property", ->
		input.test_file_c = 
			"""
				badFunction
					tempVar
						dupeA 23245
						dupeB 2372937
						dupeB 764
						dupeC 236813
					output 123
			"""
		
		expect ->
			tokenizer input
		.toThrow
			reason: "propertyNamesNotUnique"		
			line:
				filename: "test_file_c"
				line: 4
				columns:
					from: 2
					to: 7					
		
	it "throws an exception when a temporary variable defines a duplicate nested object property", ->
		input.test_file_c = 
			"""
				badFunction
					tempVar
						tempA 23245
						tempB
							dupeA 23245
							dupeB 2372937
							dupeB 764
							dupeC 236813
					output 123
			"""
		
		expect ->
			tokenizer input
		.toThrow
			reason: "propertyNamesNotUnique"		
			line:
				filename: "test_file_c"
				line: 6
				columns:
					from: 3
					to: 8						
		
	it "throws an exception when an output defines a duplicate object property", ->
		input.test_file_c = 
			"""
				badFunction
					tempVar 23235
					output
						nestedPropertyA 1
						nestedPropertyB 2
						nestedPropertyB 3
						nestedPropertyC 4
			"""
		
		expect ->
			tokenizer input
		.toThrow
			reason: "propertyNamesNotUnique"		
			line:
				filename: "test_file_c"
				line: 5
				columns:
					from: 2
					to: 17
		
	it "throws an exception when an output defines a duplicate nested object property", ->		
		input.test_file_c = 
			"""
				badFunction
					tempVar 23235
					output
						nestedPropertyA 1
						nestedPropertyB 
							subNestedPropertyA 476
							subNestedPropertyB 873
							subNestedPropertyB 235
							subNestedPropertyC 640
						nestedPropertyC 4
			"""
		
		expect ->
			tokenizer input
		.toThrow
			reason: "propertyNamesNotUnique"		
			line:
				filename: "test_file_c"
				line: 7
				columns:
					from: 3
					to: 21
	
	it "throws an exception when unexpected tokens follow a function name", ->
		input.test_file_c = 
			"""
				badFunction with following tokens
					tempVar 23235
					output 2376823
			"""
		
		expect ->
			tokenizer input
		.toThrow
			reason: "unexpectedTokensFollowingFunctionName"		
			line:
				filename: "test_file_c"
				line: 0
				columns:
					from: 0
					to: 33		
		
	it "throws an exception when a temporary variable defines both properties and a following value chain", ->
		input.test_file_c = 
			"""
				badFunction
					tempVar 23235
						subVar 3235
					output 2376823
			"""
		
		expect ->
			tokenizer input
		.toThrow
			reason: "unexpectedIndentation"		
			line:
				filename: "test_file_c"
				line: 2
				columns:
					from: 2
					to: 13			
		
	it "throws an exception when an output defines both properties and a following value chain", ->
		input.test_file_c = 
			"""
				badFunction
					tempVar 23235
					output 2376823
						subVar 2326
			"""
		
		expect ->
			tokenizer input
		.toThrow
			reason: "unexpectedIndentation"		
			line:
				filename: "test_file_c"
				line: 3
				columns:
					from: 2
					to: 13				
		
	it "throws an exception when a nested property defines both properties and a following value chain", ->
		input.test_file_c = 
			"""
				badFunction
					tempVar
						a 93847924
							3648768234
					output 2376823
			"""
		
		expect ->
			tokenizer input
		.toThrow
			reason: "unexpectedIndentation"		
			line:
				filename: "test_file_c"
				line: 3
				columns:
					from: 3
					to: 13					
		
	it "throws an exception when a nested property defines neither properties nor a following value chain", ->
		input.test_file_c = 
			"""
				badFunction
					tempVar
						a 2389
						b
					output 12379
			"""
		
		expect ->
			tokenizer input
		.toThrow
			reason: "expectedExpression"		
			line:
				filename: "test_file_c"
				line: 3
				columns:
					from: 2
					to: 3		
	
	it "throws an exception when an temporary variable defines neither properties nor a following value chain", ->
		input.test_file_c =  
			"""
				badFunction
					tempVar
					output 23792387
			"""
		
		expect ->
			tokenizer input
		.toThrow
			reason: "expectedExpression"		
			line:
				filename: "test_file_c"
				line: 1
				columns:
					from: 1
					to: 8			
		
	it "throws an exception when an output defines neither properties nor a following value chain", ->
		input.test_file_c = 
			"""
				badFunction
					tempVar 23235
					output
			"""
		
		expect ->
			tokenizer input
		.toThrow
			reason: "expectedExpression"		
			line:
				filename: "test_file_c"
				line: 2
				columns:
					from: 1
					to: 7		
		
	it "throws an exception when contents are declared for a function without any name", ->
		input.test_file_c = 
			"""
				\ttempVar 23235
				\toutput 2376823
			"""
		
		expect ->
			tokenizer input
		.toThrow
			reason: "unexpectedIndentation"		
			line:
				filename: "test_file_c"
				line: 0
				columns:
					from: 1
					to: 14