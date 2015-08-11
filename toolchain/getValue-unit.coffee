require "jasmine-collection-matchers"

describe "getValue", ->
	getValue = tokenized = funct = logs = undefined
	beforeEach ->
		logs = ["Test Log A", "Test Log B"]
		getValue = require "./getValue"
		tokenized = 
			primitives:
				testPrimitiveA: 
					parse: (token) ->
						if token is "Test Literal A"
							false						
				testPrimitiveB: 
					parse: (token) ->
						if token is "Test Literal B"
							"Test Primitive"						
				testPrimitiveC: 
					parse: (token) ->
						if token is "Test Literal C"
							0						
				testPrimitiveD:
					parse: (token) ->
						if token is "Test Literal D"
							null						
				testPrimitiveE:
					parse: (token) ->
						if token is "Test Literal E"
							""										
				testPrimitiveF:
					parse: (token) ->
						if token is "Test Literal F"
							NaN						
				
		funct =
			declarations:
				testDeclarationA: "Test Declaration A"
				testDeclarationB: "Test Declaration B"
				testDeclarationC: "Test Declaration C"
			
		spyOn(getValue, "compileExpression").and.callFake (_tokenized, _value, _expression, _funct, _logs, logPrefix) ->
			expect(_tokenized).toBe tokenized
			expect(_value).toBe "Test Input"
			expect(_expression).toEqual "Test Declaration B"
			expect(_funct).toBe funct
			if _logs
				expect(_logs).toBe logs
				expect(logPrefix).toEqual "Test Log Prefix\t"
				_logs.push "Test Compiling Expression"
			return "Test Compiled Expression"			

	describe "without logging", ->
		it "returns a value object when a primitive literal returning truthy is given", ->
			expect getValue tokenized, "Test Input", "Test Literal B", funct
				.toEqual
					score: 0
					primitive:
						type: "testPrimitiveB"
						value: "Test Primitive"
		it "returns a value object when a primitive literal returning false is given", ->
			expect getValue tokenized, "Test Input", "Test Literal A", funct
				.toEqual
					score: 0
					primitive:
						type: "testPrimitiveA"
						value: false			
		it "returns a value object when a primitive literal returning zero is given", ->
			expect getValue tokenized, "Test Input", "Test Literal C", funct
				.toEqual
					score: 0
					primitive:
						type: "testPrimitiveC"
						value: 0					
		it "returns a value object when a primitive literal returning null is given", ->
			expect getValue tokenized, "Test Input", "Test Literal D", funct
				.toEqual
					score: 0
					primitive:
						type: "testPrimitiveD"
						value: null					
		it "returns a value object when a primitive literal returning empty string is given", ->
			expect getValue tokenized, "Test Input", "Test Literal E", funct
				.toEqual
					score: 0
					primitive:
						type: "testPrimitiveE"
						value: ""					
		it "returns a value object when a primitive literal returning NaN is given", ->
			expect getValue tokenized, "Test Input", "Test Literal F", funct
				.toEqual
					score: 0
					primitive:
						type: "testPrimitiveF"
						value: NaN										
		it "returns the input when 'input' is given", ->
			expect getValue tokenized, "Test Input", "input", funct
				.toEqual "Test Input"
		it "calls compileExpression when the name of a declaration in the same function is given", ->
			expect getValue tokenized, "Test Input", "testDeclarationB", funct
				.toEqual "Test Compiled Expression"		
		it "returns falsy when no value can be resolved", ->
			expect getValue tokenized, "Test Input", "nonsense", funct
				.toBeFalsy()		
				
	describe "with logging", ->
		it "returns a value object when a primitive literal returning truthy is given", ->
			expect getValue tokenized, "Test Input", "Test Literal B", funct, logs, "Test Log Prefix"
				.toEqual
					score: 0
					primitive:
						type: "testPrimitiveB"
						value: "Test Primitive"
			expect(logs).toEqual ["Test Log A", "Test Log B", "Test Log PrefixInitial value is the literal \"Test Literal B\" of primitive type \"testPrimitiveB\"."]
		it "returns a value object when a primitive literal returning false is given", ->
			expect getValue tokenized, "Test Input", "Test Literal A", funct, logs, "Test Log Prefix"
				.toEqual
					score: 0
					primitive:
						type: "testPrimitiveA"
						value: false			
			expect(logs).toEqual ["Test Log A", "Test Log B", "Test Log PrefixInitial value is the literal \"Test Literal A\" of primitive type \"testPrimitiveA\"."]
		it "returns a value object when a primitive literal returning zero is given", ->
			expect getValue tokenized, "Test Input", "Test Literal C", funct, logs, "Test Log Prefix"
				.toEqual
					score: 0
					primitive:
						type: "testPrimitiveC"
						value: 0					
			expect(logs).toEqual ["Test Log A", "Test Log B", "Test Log PrefixInitial value is the literal \"Test Literal C\" of primitive type \"testPrimitiveC\"."]
		it "returns a value object when a primitive literal returning null is given", ->
			expect getValue tokenized, "Test Input", "Test Literal D", funct, logs, "Test Log Prefix"
				.toEqual
					score: 0
					primitive:
						type: "testPrimitiveD"
						value: null					
			expect(logs).toEqual ["Test Log A", "Test Log B", "Test Log PrefixInitial value is the literal \"Test Literal D\" of primitive type \"testPrimitiveD\"."]
		it "returns a value object when a primitive literal returning empty string is given", ->
			expect getValue tokenized, "Test Input", "Test Literal E", funct, logs, "Test Log Prefix"
				.toEqual
					score: 0
					primitive:
						type: "testPrimitiveE"
						value: ""					
			expect(logs).toEqual ["Test Log A", "Test Log B", "Test Log PrefixInitial value is the literal \"Test Literal E\" of primitive type \"testPrimitiveE\"."]
		it "returns a value object when a primitive literal returning NaN is given", ->
			expect getValue tokenized, "Test Input", "Test Literal F", funct, logs, "Test Log Prefix"
				.toEqual
					score: 0
					primitive:
						type: "testPrimitiveF"
						value: NaN										
			expect(logs).toEqual ["Test Log A", "Test Log B", "Test Log PrefixInitial value is the literal \"Test Literal F\" of primitive type \"testPrimitiveF\"."]
		it "returns the input when 'input' is given", ->
			expect getValue tokenized, "Test Input", "input", funct, logs, "Test Log Prefix"
				.toEqual "Test Input"
			expect(logs).toEqual ["Test Log A", "Test Log B", "Test Log PrefixInitial value is the input."]
		it "calls compileExpression when the name of a declaration in the same function is given", ->
			expect getValue tokenized, "Test Input", "testDeclarationB", funct, logs, "Test Log Prefix"
				.toEqual "Test Compiled Expression"		
			expect(logs).toEqual ["Test Log A", "Test Log B", "Test Log PrefixAttempting to compile declaration \"testDeclarationB\"...", "Test Compiling Expression"]
		it "returns falsy when no value can be resolved", ->
			expect getValue tokenized, "Test Input", "nonsense", funct, logs, "Test Log Prefix"
				.toBeFalsy()								
			expect(logs).toEqual ["Test Log A", "Test Log B", "Test Log PrefixFailed to resolve initial value \"nonsense\"."]