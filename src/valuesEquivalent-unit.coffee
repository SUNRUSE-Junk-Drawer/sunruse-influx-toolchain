require "jasmine-collection-matchers"

describe "valuesEquivalent", ->
	platform = a = b = valuesEquivalent = undefined
	beforeEach ->
		valuesEquivalent = require "./valuesEquivalent"
		platform =
			primitives:
				testPrimitiveA:
					equal: ->
						expect(false).toBeTruthy()
				testPrimitiveB:
					equal: (a, b) ->
						if a is "Test Primitive Value A" and b is "Test Primitive Value B" then true
				testPrimitiveC:
					equal: ->
						expect(false).toBeTruthy()												
		
	describe "given a properties object", ->
		beforeEach ->
			a = 
				properties:
					a: "Test Property AA"
					b: "Test Property AB"
		describe "and another properties object", ->
			beforeEach ->
				b = 
					properties:
						a: "Test Property BA"
						b: "Test Property BB"				
			it "returns falsy when properties exist in a but not b", ->
				a.properties.c = "Test Property AC"
				expect valuesEquivalent platform, a, b
					.toBeFalsy()
			it "returns falsy when properties exist in b but not a", ->
				b.properties.c ="Test Property BC"
				expect valuesEquivalent platform, a, b
					.toBeFalsy()
			it "returns falsy when properties fail to match", ->
				spyOn valuesEquivalent, "valuesEquivalent"
					.and.callFake (_platform, a, b) ->
						expect(_platform).toBe platform
						switch a
							when "Test Property AA"
								expect(b).toEqual "Test Property BA"
								return true
							when "Test Property AB"
								expect(b).toEqual "Test Property BB"
								return false								
				expect valuesEquivalent platform, a, b
					.toBeFalsy()
			it "returns truthy when all properties exist in both and match", ->
				spyOn valuesEquivalent, "valuesEquivalent"
					.and.callFake (_platform, a, b) ->
						expect(_platform).toBe platform
						switch a
							when "Test Property AA"
								expect(b).toEqual "Test Property BA"
								return true
							when "Test Property AB"
								expect(b).toEqual "Test Property BB"
								return true								
				expect valuesEquivalent platform, a, b
					.toBeTruthy()
		it "returns falsy given a parameter", ->
			b = 
				parameter: {}
			expect valuesEquivalent platform, a, b
				.toBeFalsy()
		it "returns falsy given a primitive constant", ->
			b = 
				primitive: {}
			expect valuesEquivalent platform, a, b
				.toBeFalsy()			
		it "returns falsy given a native function call", ->
			b = 
				native: {}
			expect valuesEquivalent platform, a, b
				.toBeFalsy()				
	describe "given a parameter", ->
		beforeEach ->
			a = 
				parameter: {}
		it "returns falsy given a properties object", ->
			b = 
				properties: {}
			expect valuesEquivalent platform, a, b
				.toBeFalsy()				
		describe "and another parameter", ->
			it "returns falsy when the parameters are distinct by reference", ->
				expect valuesEquivalent platform, a, {}
					.toBeFalsy()					
			it "returns truthy when the parameters are the exact same reference", ->
				expect valuesEquivalent platform, a, a
					.toBeTruthy()	
		it "returns falsy given a primitive constant", ->
			b = 
				primitive: {}
			expect valuesEquivalent platform, a, b
				.toBeFalsy()				
		it "returns falsy given a native function call", ->
			b = 
				native: {}
			expect valuesEquivalent platform, a, b
				.toBeFalsy()							
	describe "given a primitive constant", ->
		beforeEach ->
			a = 
				primitive:
					type: "testPrimitiveB"
					value: "Test Primitive Value A"
		it "returns falsy given a properties object", ->
			b = 
				properties: {}
			expect valuesEquivalent platform, a, b
				.toBeFalsy()							
		it "returns falsy given a parameter", ->
			b = 
				parameter: {}
			expect valuesEquivalent platform, a, b
				.toBeFalsy()							
		describe "given another primitive constant", ->
			it "returns falsy when the types do not match", ->
				b = 
					primitive:
						type: "testPrimitiveA"
						value: "Test Primitive Value B"
				expect valuesEquivalent platform, a, b
					.toBeFalsy()								
			it "returns falsy when the primitive types match and its \"equivalent\" function returns falsy", ->
				b = 
					primitive:
						type: "testPrimitiveB"
						value: "Test Primitive Value C"
				expect valuesEquivalent platform, a, b
					.toBeFalsy()						
			it "returns truthy when the primitive types match and its \"equivalent\" function returns truthy", ->
				b = 
					primitive:
						type: "testPrimitiveB"
						value: "Test Primitive Value B"
				expect valuesEquivalent platform, a, b
					.toBeTruthy()				
		it "returns falsy given a native function call", ->
			b = 
				native: {}
			expect valuesEquivalent platform, a, b
				.toBeFalsy()										
	describe "given a native function call", ->
		beforeEach ->
			a = 
				native:
					input: "Test Function Input A"
					function:
						inputsEqual: (_platform, a, b) ->
							expect(_platform).toBe platform
							if a is "Test Function Input A" and b is "Test Function Input B" then return true
		it "returns falsy given a properties object", ->
			b = 
				properties: {}
			expect valuesEquivalent platform, a, b
				.toBeFalsy()		
		it "returns falsy given a parameter", ->
			b = 
				parameter: {}
			expect valuesEquivalent platform, a, b
				.toBeFalsy()					
		it "returns falsy given a primitive constant", ->
			b = 
				primitive: {}
			expect valuesEquivalent platform, a, b
				.toBeFalsy()					
		describe "when given another native function call", ->
			beforeEach ->
				b = 
					native:
						input: "Test Function Input B" 
						function: a.native.function				
			it "returns falsy when the functions do not match", ->
				b.native.function = {}
				expect valuesEquivalent platform, a, b
					.toBeFalsy()
			it "returns falsy when the functions match and its \"inputsEqual\" function returns falsy", ->
				b.native.input = "Test Function Input C"
				expect valuesEquivalent platform, a, b
					.toBeFalsy()				
			it "returns falsy when the functions match and its \"inputsEqual\" function returns truthy", ->
				expect valuesEquivalent platform, a, b
					.toBeTruthy()								