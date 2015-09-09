require "jasmine-collection-matchers"

describe "valueIsPrimitive", ->
	valueIsPrimitive = undefined
	beforeEach ->
		valueIsPrimitive = require "./valueIsPrimitive"
		
	it "returns falsy when properties are given", ->
		value = 
			properties: {}
		expect valueIsPrimitive value, "testPrimitiveName"
			.toBeFalsy()
		
	it "returns falsy when a native function returns another primitive type", ->
		value = 
			native:
				function:
					output: "testUnmatchingPrimitiveName"
		expect valueIsPrimitive value, "testPrimitiveName"
			.toBeFalsy()

	it "returns truthy when a native function returns the same primitive type", ->
		value = 
			native:
				function:
					output: "testPrimitiveName"
		expect valueIsPrimitive value, "testPrimitiveName"
			.toBeTruthy()

	it "returns falsy when a constant contains another primitive type", ->
		value = 
			primitive:
				type: "testUnmatchingPrimitiveName"
		expect valueIsPrimitive value, "testPrimitiveName"
			.toBeFalsy()

	it "returns truthy when a constant contains the same primitive type", ->
		value = 
			primitive:
				type: "testPrimitiveName"
		expect valueIsPrimitive value, "testPrimitiveName"
			.toBeTruthy()
			
	it "returns falsy when a parameter contains another primitive type", ->
		value = 
			parameter:
				type: "testUnmatchingPrimitiveName"
		expect valueIsPrimitive value, "testPrimitiveName"
			.toBeFalsy()

	it "returns truthy when a parameter contains the same primitive type", ->
		value = 
			parameter:
				type: "testPrimitiveName"
		expect valueIsPrimitive value, "testPrimitiveName"
			.toBeTruthy()			