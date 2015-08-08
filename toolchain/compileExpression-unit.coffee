require "jasmine-collection-matchers"

describe "compileExpression", ->
	compileExpression = tokenized = funct = expression = compiledExpressionA = compiledExpressionB = undefined
	beforeEach ->
		compileExpression = require "./compileExpression"
		
		expression = {}		
		tokenized = "Test Tokenized"
		funct = "Test Funct"
		
		spyOn(compileExpression, "getValue").and.callFake (_tokenized, _input, _token, _funct) ->
			expect(_tokenized).toBe tokenized
			expect(_funct).toBe funct
			switch _token
				when "Test Resolvable Value"
					expect(_input).toEqual "Test Input"
					return "Test Value Object A"
					
		spyOn(compileExpression, "findFunction").and.callFake (_tokenized, _input, _name) ->
			expect(_tokenized).toBe tokenized
			switch _name
				when "Test Resolvable Function A"
					expect(_input).toEqual "Test Value Object A"
					return "Test Value Object B"
					
				when "Test Resolvable Function B"
					expect(_input).toEqual "Test Value Object B"
					return "Test Value Object C"					
			
		spyOn(compileExpression, "compileExpression").and.callFake (_tokenized, _input, _expression, _funct) ->
			expect(_tokenized).toBe tokenized
			expect(_input).toBe "Test Input"
			expect(_funct).toBe funct
			switch _expression
				when expression.properties.propertyA
					return unused = 
						score: 4
						internalValue: "retained"
				when expression.properties.propertyB
					return unused = 
						score: 3
						otherInternalValue: "alsoRetained"						
			
	describe "given a chain", ->
		beforeEach ->
			expression.chain = ["Test Resolvable Value", "Test Resolvable Function A", "Test Resolvable Function B"]
		
		it "returns falsy when the value cannot be resolved", ->
			expression.chain[0] = "Test Unresolvable Value"
			
			expect compileExpression tokenized, "Test Input", expression, funct
				.toBeFalsy()
		it "returns falsy when a function cannot be resolved", ->
			expression.chain[1] = "Test Unresolvable Function"
			
			expect compileExpression tokenized, "Test Input", expression, funct
				.toBeFalsy()			
		it "returns the output value when the value and all functions can be resolved", ->
			expect compileExpression tokenized, "Test Input", expression, funct
				.toEqual "Test Value Object C"			
			
	describe "given properties", ->
		beforeEach ->
			expression.properties = 
				propertyA: "Test Property A"
				propertyB: "Test Property B"
		
		it "returns falsy when a property cannot be resolved", ->
			expression.properties.propertyA = "Test Unresolvable Property"
			expect compileExpression tokenized, "Test Input", expression, funct
				.toEqual
					score: 7
					properties:
						propertyA:
							score: 4
							internalValue: "retained"
						propertyB:
							score: 3
							otherInternalValue: "alsoRetained"			
			
		it "returns a new value object when all properties can be resolved", ->
			expect compileExpression tokenized, "Test Input", expression, funct
				.toEqual
					score: 7
					properties:
						propertyA:
							score: 4
							internalValue: "retained"
						propertyB:
							score: 3
							otherInternalValue: "alsoRetained"