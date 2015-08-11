require "jasmine-collection-matchers"

describe "compileExpression", ->
	compileExpression = tokenized = funct = expression = compiledExpressionA = compiledExpressionB = logs = undefined
	beforeEach ->	
		compileExpression = require "./compileExpression"
		
		expression = {}		
		tokenized = "Test Tokenized"
		funct = "Test Funct"
		logs = undefined
		
		spyOn(compileExpression, "getValue").and.callFake (_tokenized, _input, _token, _funct, _logs, _logPrefix) ->
			expect(_tokenized).toBe tokenized
			expect(_funct).toBe funct
			if _logs
				expect(_logs).toBe logs
				expect(_logPrefix).toEqual "Test Log Prefix\t"
				_logs.push "Test getting value \"" + _token + "\" with \"" + _input + "\"."
			switch _token
				when "Test Resolvable Value"
					expect(_input).toEqual "Test Input"
					return "Test Value Object A"
					
		spyOn(compileExpression, "findFunction").and.callFake (_tokenized, _input, _name, _logs, _logPrefix) ->
			expect(_tokenized).toBe tokenized
			if _logs
				expect(_logs).toBe logs
				expect(_logPrefix).toEqual "Test Log Prefix\t"			
				_logs.push "Test finding function \"" + _name + "\" with \"" + _input + "\"."
			switch _name
				when "Test Resolvable Function A"
					expect(_input).toEqual "Test Value Object A"
					return "Test Value Object B"
					
				when "Test Resolvable Function B"
					expect(_input).toEqual "Test Value Object B"
					return "Test Value Object C"					
			
		spyOn(compileExpression, "compileExpression").and.callFake (_tokenized, _input, _expression, _funct, _logs, _logPrefix) ->
			expect(_tokenized).toBe tokenized
			expect(_input).toBe "Test Input"
			expect(_funct).toBe funct
			if _logs
				expect(_logs).toBe logs
				expect(_logPrefix).toEqual "Test Log Prefix\t"			
				_logs.push "Test compiling expression \"" + _expression + "\" with \"" + _input + "\"."
			switch _expression
				when "Test Property A"
					return unused = 
						score: 4
						internalValue: "retained"
				when "Test Property B"
					return unused = 
						score: 3
						otherInternalValue: "alsoRetained"						
	describe "without logging", ->
		describe "given a chain", ->
			beforeEach ->
				expression.chain = [
						token: "Test Resolvable Value",
					, 
						token: "Test Resolvable Function A",
					, 
						token: "Test Resolvable Function B"
				]
			
			it "returns falsy when the value cannot be resolved", ->
				expression.chain[0].token = "Test Unresolvable Value"
				
				expect compileExpression tokenized, "Test Input", expression, funct
					.toBeFalsy()
			it "returns falsy when a function cannot be resolved", ->
				expression.chain[1].token = "Test Unresolvable Function"
				
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
					.toBeFalsy()	
				
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
								
	describe "with logging", ->
		beforeEach ->
			logs = ["Test Existing Log A", "Test Existing Log B"]
		
		describe "given a chain", ->
			beforeEach ->
				expression.chain = [
						token: "Test Resolvable Value",
					, 
						token: "Test Resolvable Function A",
					, 
						token: "Test Resolvable Function B"
				]
			
			it "returns falsy when the value cannot be resolved", ->
				expression.chain[0].token = "Test Unresolvable Value"
				
				expect compileExpression tokenized, "Test Input", expression, funct, logs, "Test Log Prefix"
					.toBeFalsy()
					
				expect(logs).toEqual ["Test Existing Log A", "Test Existing Log B", "Test Log PrefixAttempting to compile chain \"Test Unresolvable Value Test Resolvable Function A Test Resolvable Function B\"...", "Test getting value \"Test Unresolvable Value\" with \"Test Input\"."]
			it "returns falsy when a function cannot be resolved", ->
				expression.chain[1].token = "Test Unresolvable Function"
				
				expect compileExpression tokenized, "Test Input", expression, funct, logs, "Test Log Prefix"
					.toBeFalsy()			
				expect(logs).toEqual ["Test Existing Log A", "Test Existing Log B", "Test Log PrefixAttempting to compile chain \"Test Resolvable Value Test Unresolvable Function Test Resolvable Function B\"...", "Test getting value \"Test Resolvable Value\" with \"Test Input\".", "Test finding function \"Test Unresolvable Function\" with \"Test Value Object A\"."]
			it "returns the output value when the value and all functions can be resolved", ->
				expect compileExpression tokenized, "Test Input", expression, funct, logs, "Test Log Prefix"
					.toEqual "Test Value Object C"			
				expect(logs).toEqual ["Test Existing Log A", "Test Existing Log B", "Test Log PrefixAttempting to compile chain \"Test Resolvable Value Test Resolvable Function A Test Resolvable Function B\"...", "Test getting value \"Test Resolvable Value\" with \"Test Input\".", "Test finding function \"Test Resolvable Function A\" with \"Test Value Object A\".", "Test finding function \"Test Resolvable Function B\" with \"Test Value Object B\".", "Test Log Prefix\tSuccessfully compiled chain."]
				
		describe "given properties", ->
			beforeEach ->
				expression.properties = 
					propertyA: "Test Property A"
					propertyB: "Test Property B"
			
			it "returns falsy when a property cannot be resolved", ->
				expression.properties.propertyA = "Test Unresolvable Property"
				expect compileExpression tokenized, "Test Input", expression, funct, logs, "Test Log Prefix"
					.toBeFalsy()	
				expect(logs).toEqual ["Test Existing Log A", "Test Existing Log B", "Test Log PrefixAttempting to compile properties propertyA, propertyB...", "Test Log PrefixAttempting to compile property \"propertyA\"...", "Test compiling expression \"Test Unresolvable Property\" with \"Test Input\"."]
				
			it "returns a new value object when all properties can be resolved", ->
				expect compileExpression tokenized, "Test Input", expression, funct, logs, "Test Log Prefix"
					.toEqual
						score: 7
						properties:
							propertyA:
								score: 4
								internalValue: "retained"
							propertyB:
								score: 3
								otherInternalValue: "alsoRetained"
				expect(logs).toEqual ["Test Existing Log A", "Test Existing Log B", "Test Log PrefixAttempting to compile properties propertyA, propertyB...", "Test Log PrefixAttempting to compile property \"propertyA\"...", "Test compiling expression \"Test Property A\" with \"Test Input\".", "Test Log PrefixAttempting to compile property \"propertyB\"...", "Test compiling expression \"Test Property B\" with \"Test Input\".", "Test Log Prefix\tSuccessfully compiled all properties with a total score of 7."]