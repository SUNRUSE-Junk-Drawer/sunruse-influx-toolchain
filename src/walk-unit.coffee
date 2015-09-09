require "jasmine-collection-matchers"

describe "walk", ->
	walk = walked = callback = value = undefined
	beforeEach ->
		walk = require "./walk"
		walked = []
		callback = (val) ->
			walked.push val
		value = {}
		
	it "iterates over properties", ->
		value.properties = 
			propertyA:
				properties:
					propertyAA: {}
					propertyAB: {}
			propertyB: {}
			propertyC: 
				native:
					input: {}
		
		walk value, callback
		expect(walked.length).toEqual 7
		expect(walked[0]).toBe value.properties.propertyA.properties.propertyAA
		expect(walked[1]).toBe value.properties.propertyA.properties.propertyAB
		expect(walked[2]).toBe value.properties.propertyA
		expect(walked[3]).toBe value.properties.propertyB
		expect(walked[4]).toBe value.properties.propertyC.native.input
		expect(walked[5]).toBe value.properties.propertyC
		expect(walked[6]).toBe value
		
	it "iterates over parameters", ->
		value.parameter = {}
		
		walk value, callback
		expect(walked.length).toEqual 1
		expect(walked[0]).toBe value
		
	it "iterates over primitive constants", ->
		value.primitive = {}
		
		walk value, callback
		expect(walked.length).toEqual 1
		expect(walked[0]).toBe value		
		
	it "iterates over native functions", ->
		value.native =
			input:
				primitive: {} 
		
		walk value, callback
		expect(walked.length).toEqual 2
		expect(walked[0]).toBe value.native.input
		expect(walked[1]).toBe value			