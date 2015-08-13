describe "platforms", ->
	describe "javascript", ->
		describe "parameterCache", ->
			parameterCache = undefined
			beforeEach ->
				parameterCache = require "./parameterCache"
			it "returns empty when an empty properties object is given", ->
				input = 
					properties: {}
				expect parameterCache input
					.toEqual []
			it "returns empty when a primitive constant is given", ->
				input = 
					primitive:
						type: "int"
						value: 43
				expect parameterCache input
					.toEqual []				
			it "returns the parameter when a single parameter is given", ->
				input = 
					parameter:
						type: "int"
				result = parameterCache input
				expect(result.length).toEqual 1
				expect(result[0].code).toEqual "input"
				expect(result[0].value).toBe input
			it "returns every parameter when a populated properties object is given", ->
				input = 
					properties:
						propertyA:
							properties:
								propertyAA:
									primitive: {}
								propertyAB:
									parameter: {}
						propertyB:
							parameter: {}
						propertyC:
							parameter: {}
						propertyD:
							primitive: {}
				result = parameterCache input
				expect(result.length).toEqual 3
				expect(result[0].code).toEqual "input.propertyA.propertyAB"
				expect(result[0].value).toBe input.properties.propertyA.properties.propertyAB
				expect(result[1].code).toEqual "input.propertyB"
				expect(result[1].value).toBe input.properties.propertyB
				expect(result[2].code).toEqual "input.propertyC"
				expect(result[2].value).toBe input.properties.propertyC								