require "jasmine-collection-matchers"

describe "compileExpression", ->
	findFunction = tokenized = input = undefined
	functionAResult = functionBResult = functionCResult = functionDResult = functionEResult = undefined
	nativeAResult = nativeBResult = nativeCResult = nativeDResult = nativeEResult = undefined
	logs = undefined
	beforeEach ->
		logs = undefined
		
		functionAResult = functionBResult = functionCResult = functionDResult = functionEResult = undefined
		nativeAResult = nativeBResult = nativeCResult = nativeDResult = nativeEResult = undefined		
		
		findFunction = require "./findFunction"
		
		input = {}
		
		spyOn findFunction, "compileExpression"
			.and.returnValue null
		
		findFunction.compileExpression.and.callFake (_tokenized, _input, _expression, _funct, _logs, prefix) ->
			expect(_tokenized).toBe tokenized
			expect(_input).toBe input
			if logs	isnt undefined
				expect(_logs).toBe logs
			
			if _logs
				_logs.push prefix + " for " + tokenized.functions.indexOf _funct
			
			switch _funct
				when tokenized.functions[0]
					expect(_expression).toEqual "Test Function A Output"
					return functionAResult
				when tokenized.functions[1]
					expect(_expression).toEqual "Test Function B Output"
					return functionBResult	
				when tokenized.functions[2]
					expect(_expression).toEqual "Test Function C Output"
					return functionCResult			
				when tokenized.functions[3]
					expect(_expression).toEqual "Test Function D Output"
					return functionDResult
				when tokenized.functions[4]
					expect(_expression).toEqual "Test Function E Output"
					return functionEResult
				when tokenized.functions[5]
					expect(_expression).toEqual "Test Function F Output"
					return functionFResult			
		
		tokenized = 
			functions: [
					name: "functionA"
					line:
						filename: "Test Filename A"
						line: 2736
					declarations:
						tempVarA: "Test TempVar"
						output: "Test Function A Output"
						tempVarB: "Test TempVar"
				,
					name: "functionA"
					line:
						filename: "Test Filename B"
						line: 23587235	
					declarations:					
						tempVarA: "Test TempVar"
						output: "Test Function B Output"
						tempVarB: "Test TempVar"					
				,
					name: "functionB"
					line:
						filename: "Test Filename C"
						line: 55356					
					declarations:					
						tempVarA: "Test TempVar"
						output: "Test Function C Output"
						tempVarB: "Test TempVar"					
				,
					name: "nonNativeFunction"
					line:
						filename: "Test Filename D"
						line: 6673					
					declarations:					
						tempVarA: "Test TempVar"
						output: "Test Function D Output"
						tempVarB: "Test TempVar"					
				,
					name: "nonNativeFunction"	
					line:
						filename: "Test Filename E"
						line: 3315					
					declarations:					
						tempVarA: "Test TempVar"
						output: "Test Function E Output"
						tempVarB: "Test TempVar"									
			]
			nativeFunctions: [
					name: "functionA"
					compile: (value, _logs, prefix) ->
						expect(value).toBe input
						if logs	isnt undefined
							expect(_logs).toBe logs
						
						if _logs
							_logs.push prefix + " for native function A"						
						return nativeAResult
					output: "Test Output A"
				,
					name: "functionA"
					compile: (value, _logs, prefix) ->
						expect(value).toBe input
						if logs	isnt undefined
							expect(_logs).toBe logs
						
						if _logs
							_logs.push prefix + " for native function B"						
						return nativeBResult
					output: "Test Output B"
				,
					name: "functionB"
					compile: (value, _logs, prefix) ->
						expect(value).toBe input
						if logs	isnt undefined
							expect(_logs).toBe logs
						
						if _logs
							_logs.push prefix + " for native function C"						
						return nativeCResult
					output: "Test Output C"
				,
					name: "nativeFunction"
					compile: (value, _logs, prefix) ->
						expect(value).toBe input
						if logs	isnt undefined
							expect(_logs).toBe logs
						
						if _logs
							_logs.push prefix + " for native function D"						
						return nativeDResult
					output: "Test Output D"
				,
					name: "nativeFunction"
					compile: (value, _logs, prefix) ->
						expect(value).toBe input
						if logs	isnt undefined
							expect(_logs).toBe logs
						
						if _logs
							_logs.push prefix + " for native function E"						
						return nativeEResult
					output: "Test Output E"
			]
			
	describe "when not logging", ->
		sharedTests = ->
			it "returns falsy when no functions match by name", ->
				functionEResult = 
					score: 70													
				nativeEResult = 
					score: 70			
				expect findFunction tokenized, input, "unresolvable"
					.toBeFalsy()
			it "returns falsy when none of the functions matching by name compile", ->
				functionEResult = 
					score: 70													
				nativeEResult = 
					score: 70			
				expect findFunction tokenized, input, "functionA"
					.toBeFalsy()		
			it "returns the matching function when only one native function matching by name compiles", ->
				nativeBResult = 
					score: 30	
				functionEResult = 
					score: 70													
				nativeEResult = 
					score: 70						
				expect findFunction tokenized, input, "functionA"
					.toBe nativeBResult			
			it "returns the matching function when only one non-native function matching by name compiles", ->
				functionAResult = 
					score: 30	
				functionEResult = 
					score: 70													
				nativeEResult = 
					score: 70						
				expect findFunction tokenized, input, "functionA"
					.toBe functionAResult					
			it "returns the best scoring function when multiple native functions matching by name compile", ->										
				nativeAResult = 
					score: 70						
				nativeBResult = 
					score: 30
				expect findFunction tokenized, input, "functionA"
					.toBe nativeAResult					
			it "returns the best scoring function when multiple non-native functions matching by name compile", ->
				functionAResult = 
					score: 30						
				functionBResult = 
					score: 70
				expect findFunction tokenized, input, "functionA"
					.toBe functionBResult							
			it "returns the best scoring function when both native and non-native functions matching by name compile (non-native wins)", ->
				nativeAResult = 
					score: 70						
				nativeBResult = 
					score: 30
				functionAResult = 
					score: 90						
				functionBResult = 
					score: 10		
				expect findFunction tokenized, input, "functionA"
					.toBe functionAResult								
			it "returns the best scoring function when both native and non-native functions matching by name compile (native wins)", ->
				nativeAResult = 
					score: 25						
				nativeBResult = 
					score: 90
				functionAResult = 
					score: 20						
				functionBResult = 
					score: 10		
				expect findFunction tokenized, input, "functionA"
					.toBe nativeBResult							
				
		describe "when calling without properties", sharedTests			
				
		describe "when calling with properties", ->
			beforeEach ->
				input.properties = 
					testPropertyA: "Test Property A"
					testPropertyB: "Test Property B"
					testPropertyC: "Test Property C"
			it "returns the property when a property of the input matches by name", ->
				expect findFunction tokenized, input, "testPropertyB"
					.toEqual "Test Property B" 
			sharedTests()
			
	describe "when logging", ->
		beforeEach ->
			logs = ["Existing Log A", "Existing Log B"]
		
		sharedTests = ->
			it "returns falsy when no functions match by name", ->
				functionEResult = 
					score: 70													
				nativeEResult = 
					score: 70			
				expect findFunction tokenized, input, "unresolvable", logs, "Test Prefix"
					.toBeFalsy()
				expect(logs).toEqual ["Existing Log A", "Existing Log B", "Test PrefixAttempting to find a match for function \"unresolvable\"...", "Test Prefix\tNo matches were found."]
					
			it "returns falsy when none of the functions matching by name compile", ->
				functionEResult = 
					score: 70													
				nativeEResult = 
					score: 70			
				expect findFunction tokenized, input, "functionA", logs, "Test Prefix"
					.toBeFalsy()		
				expect(logs).toEqual ["Existing Log A", "Existing Log B", "Test PrefixAttempting to find a match for function \"functionA\"...", "Test Prefix\tTrying implementation in file \"Test Filename A\" on line 2736...", "Test Prefix\t\t for 0", "Test Prefix\t\tThis implementation did not compile.", "Test Prefix\tTrying implementation in file \"Test Filename B\" on line 23587235...", "Test Prefix\t\t for 1", "Test Prefix\t\tThis implementation did not compile.", "Test Prefix\tTrying native implementation returning primitive type \"Test Output A\"...", "Test Prefix\t\t for native function A", "Test Prefix\t\tThis implementation did not compile.", "Test Prefix\tTrying native implementation returning primitive type \"Test Output B\"...", "Test Prefix\t\t for native function B", "Test Prefix\t\tThis implementation did not compile.", "Test Prefix\tNo matches were found."]
					
			it "returns the matching function when only one native function matching by name compiles", ->
				nativeBResult = 
					score: 30	
				functionEResult = 
					score: 70													
				nativeEResult = 
					score: 70						
				expect findFunction tokenized, input, "functionA", logs, "Test Prefix"
					.toBe nativeBResult			
				expect(logs).toEqual ["Existing Log A", "Existing Log B", "Test PrefixAttempting to find a match for function \"functionA\"...", "Test Prefix\tTrying implementation in file \"Test Filename A\" on line 2736...", "Test Prefix\t\t for 0", "Test Prefix\t\tThis implementation did not compile.", "Test Prefix\tTrying implementation in file \"Test Filename B\" on line 23587235...", "Test Prefix\t\t for 1", "Test Prefix\t\tThis implementation did not compile.", "Test Prefix\tTrying native implementation returning primitive type \"Test Output A\"...", "Test Prefix\t\t for native function A", "Test Prefix\t\tThis implementation did not compile.", "Test Prefix\tTrying native implementation returning primitive type \"Test Output B\"...", "Test Prefix\t\t for native function B", "Test Prefix\t\tSuccessfully compiled with a score of 30.", "Test Prefix\tSelected the native implementation returning primitive type \"Test Output B\" which scored 30."]
			it "returns the matching function when only one non-native function matching by name compiles", ->
				functionAResult = 
					score: 30	
				functionEResult = 
					score: 70													
				nativeEResult = 
					score: 70						
				expect findFunction tokenized, input, "functionA", logs, "Test Prefix"
					.toBe functionAResult					
				expect(logs).toEqual ["Existing Log A", "Existing Log B", "Test PrefixAttempting to find a match for function \"functionA\"...", "Test Prefix\tTrying implementation in file \"Test Filename A\" on line 2736...", "Test Prefix\t\t for 0", "Test Prefix\t\tSuccessfully compiled with a score of 30.", "Test Prefix\tTrying implementation in file \"Test Filename B\" on line 23587235...", "Test Prefix\t\t for 1", "Test Prefix\t\tThis implementation did not compile.", "Test Prefix\tTrying native implementation returning primitive type \"Test Output A\"...", "Test Prefix\t\t for native function A", "Test Prefix\t\tThis implementation did not compile.", "Test Prefix\tTrying native implementation returning primitive type \"Test Output B\"...", "Test Prefix\t\t for native function B", "Test Prefix\t\tThis implementation did not compile.", "Test Prefix\tSelected the implementation in file \"Test Filename A\" on line 2736 which scored 30."]
			it "returns the best scoring function when multiple native functions matching by name compile", ->										
				nativeAResult = 
					score: 70						
				nativeBResult = 
					score: 30
				expect findFunction tokenized, input, "functionA", logs, "Test Prefix"
					.toBe nativeAResult			
				expect(logs).toEqual ["Existing Log A", "Existing Log B", "Test PrefixAttempting to find a match for function \"functionA\"...", "Test Prefix\tTrying implementation in file \"Test Filename A\" on line 2736...", "Test Prefix\t\t for 0", "Test Prefix\t\tThis implementation did not compile.", "Test Prefix\tTrying implementation in file \"Test Filename B\" on line 23587235...", "Test Prefix\t\t for 1", "Test Prefix\t\tThis implementation did not compile.", "Test Prefix\tTrying native implementation returning primitive type \"Test Output A\"...", "Test Prefix\t\t for native function A", "Test Prefix\t\tSuccessfully compiled with a score of 70.", "Test Prefix\tTrying native implementation returning primitive type \"Test Output B\"...", "Test Prefix\t\t for native function B", "Test Prefix\t\tSuccessfully compiled with a score of 30.", "Test Prefix\tSelected the native implementation returning primitive type \"Test Output A\" which scored 70."]		
			it "returns the best scoring function when multiple non-native functions matching by name compile", ->
				functionAResult = 
					score: 30						
				functionBResult = 
					score: 70
				expect findFunction tokenized, input, "functionA", logs, "Test Prefix"
					.toBe functionBResult		
				expect(logs).toEqual ["Existing Log A", "Existing Log B", "Test PrefixAttempting to find a match for function \"functionA\"...", "Test Prefix\tTrying implementation in file \"Test Filename A\" on line 2736...", "Test Prefix\t\t for 0", "Test Prefix\t\tSuccessfully compiled with a score of 30.", "Test Prefix\tTrying implementation in file \"Test Filename B\" on line 23587235...", "Test Prefix\t\t for 1", "Test Prefix\t\tSuccessfully compiled with a score of 70.", "Test Prefix\tTrying native implementation returning primitive type \"Test Output A\"...", "Test Prefix\t\t for native function A", "Test Prefix\t\tThis implementation did not compile.", "Test Prefix\tTrying native implementation returning primitive type \"Test Output B\"...", "Test Prefix\t\t for native function B", "Test Prefix\t\tThis implementation did not compile.", "Test Prefix\tSelected the implementation in file \"Test Filename B\" on line 23587235 which scored 70."]					
			it "returns the best scoring function when both native and non-native functions matching by name compile (non-native wins)", ->
				nativeAResult = 
					score: 70						
				nativeBResult = 
					score: 30
				functionAResult = 
					score: 90						
				functionBResult = 
					score: 10		
				expect findFunction tokenized, input, "functionA", logs, "Test Prefix"
					.toBe functionAResult		
				expect(logs).toEqual ["Existing Log A", "Existing Log B", "Test PrefixAttempting to find a match for function \"functionA\"...", "Test Prefix\tTrying implementation in file \"Test Filename A\" on line 2736...", "Test Prefix\t\t for 0", "Test Prefix\t\tSuccessfully compiled with a score of 90.", "Test Prefix\tTrying implementation in file \"Test Filename B\" on line 23587235...", "Test Prefix\t\t for 1", "Test Prefix\t\tSuccessfully compiled with a score of 10.", "Test Prefix\tTrying native implementation returning primitive type \"Test Output A\"...", "Test Prefix\t\t for native function A", "Test Prefix\t\tSuccessfully compiled with a score of 70.", "Test Prefix\tTrying native implementation returning primitive type \"Test Output B\"...", "Test Prefix\t\t for native function B", "Test Prefix\t\tSuccessfully compiled with a score of 30.", "Test Prefix\tSelected the implementation in file \"Test Filename A\" on line 2736 which scored 90."]						
			it "returns the best scoring function when both native and non-native functions matching by name compile (native wins)", ->
				nativeAResult = 
					score: 25						
				nativeBResult = 
					score: 90
				functionAResult = 
					score: 20						
				functionBResult = 
					score: 10		
				expect findFunction tokenized, input, "functionA", logs, "Test Prefix"
					.toBe nativeBResult			
				expect(logs).toEqual ["Existing Log A", "Existing Log B", "Test PrefixAttempting to find a match for function \"functionA\"...", "Test Prefix\tTrying implementation in file \"Test Filename A\" on line 2736...", "Test Prefix\t\t for 0", "Test Prefix\t\tSuccessfully compiled with a score of 20.", "Test Prefix\tTrying implementation in file \"Test Filename B\" on line 23587235...", "Test Prefix\t\t for 1", "Test Prefix\t\tSuccessfully compiled with a score of 10.", "Test Prefix\tTrying native implementation returning primitive type \"Test Output A\"...", "Test Prefix\t\t for native function A", "Test Prefix\t\tSuccessfully compiled with a score of 25.", "Test Prefix\tTrying native implementation returning primitive type \"Test Output B\"...", "Test Prefix\t\t for native function B", "Test Prefix\t\tSuccessfully compiled with a score of 90.", "Test Prefix\tSelected the native implementation returning primitive type \"Test Output B\" which scored 90."]				
				
		describe "when calling without properties", sharedTests			
				
		describe "when calling with properties", ->
			beforeEach ->
				input.properties = 
					testPropertyA: 
						score: 32323
					testPropertyB: 
						score: 531
					testPropertyC: 
						score: 710
			it "returns the property when a property of the input matches by name", ->
				expect findFunction tokenized, input, "testPropertyB", logs, "Test Prefix"
					.toBe input.properties.testPropertyB
				expect(logs).toEqual ["Existing Log A", "Existing Log B", "Test PrefixAttempting to find a match for function \"testPropertyB\"...", "Test Prefix\tUsing the property of the input with a score of 531."]
			sharedTests()			