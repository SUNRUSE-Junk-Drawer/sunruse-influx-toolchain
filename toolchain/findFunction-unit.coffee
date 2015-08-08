require "jasmine-collection-matchers"

describe "compileExpression", ->
	findFunction = tokenized = input = undefined
	functionAResult = functionBResult = functionCResult = functionDResult = functionEResult = undefined
	nativeAResult = nativeBResult = nativeCResult = nativeDResult = nativeEResult = undefined
	beforeEach ->
		functionAResult = functionBResult = functionCResult = functionDResult = functionEResult = undefined
		nativeAResult = nativeBResult = nativeCResult = nativeDResult = nativeEResult = undefined		
		
		findFunction = require "./findFunction"
		
		input = {}
		
		spyOn findFunction, "compileExpression"
			.and.returnValue null
		
		findFunction.compileExpression.and.callFake (_tokenized, _input, _expression, _funct) ->
			expect(_tokenized).toBe tokenized
			expect(_input).toBe input		
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
					declarations:
						tempVarA: "Test TempVar"
						output: "Test Function A Output"
						tempVarB: "Test TempVar"
				,
					name: "functionA"
					declarations:					
						tempVarA: "Test TempVar"
						output: "Test Function B Output"
						tempVarB: "Test TempVar"					
				,
					name: "functionB"
					declarations:					
						tempVarA: "Test TempVar"
						output: "Test Function C Output"
						tempVarB: "Test TempVar"					
				,
					name: "nonNativeFunction"
					declarations:					
						tempVarA: "Test TempVar"
						output: "Test Function D Output"
						tempVarB: "Test TempVar"					
				,
					name: "nonNativeFunction"	
					declarations:					
						tempVarA: "Test TempVar"
						output: "Test Function E Output"
						tempVarB: "Test TempVar"									
			]
			nativeFunctions: [
					name: "functionA"
					compile: (value) ->
						expect(value).toBe input
						return nativeAResult
				,
					name: "functionA"
					compile: (value) ->
						expect(value).toBe input
						return nativeBResult
				,
					name: "functionB"
					compile: (value) ->
						expect(value).toBe input
						return nativeCResult
				,
					name: "nativeFunction"
					compile: (value) ->
						expect(value).toBe input
						return nativeDResult
				,
					name: "nativeFunction"
					compile: (value) ->
						expect(value).toBe input
						return nativeEResult
			]
			
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