describe "platforms", ->
	describe "javascript", ->
		describe "int", ->
			describe "comparisons", ->
				comparisons = undefined
				beforeEach ->
					comparisons = require "./comparisons"
				describe "imports", ->
					it "makeOrderedBinary", ->
						expect(comparisons.makeOrderedBinary).toBe require "./../../helpers/makeOrderedBinary"						
					it "makeUnorderedBinary", ->
						expect(comparisons.makeUnorderedBinary).toBe require "./../../helpers/makeUnorderedBinary"						
				describe "defines", ->
					functions = unorderedBinaries = orderedBinaries = undefined
					beforeEach ->
						makeOrderedBinary = comparisons.makeOrderedBinary
						makeUnorderedBinary = comparisons.makeUnorderedBinary
						comparisons.makeOrderedBinary = jasmine.createSpy()
						comparisons.makeUnorderedBinary = jasmine.createSpy()
						orderedBinaries = {}
						comparisons.makeOrderedBinary.and.callFake (name) ->
							toReturn = makeOrderedBinary.apply this, arguments
							orderedBinaries[name] = 
								args: (argument for argument in arguments)
								result: toReturn
							return toReturn
						unorderedBinaries = {}							
						comparisons.makeUnorderedBinary.and.callFake (name) ->
							toReturn = makeUnorderedBinary.apply this, arguments
							unorderedBinaries[name] = 
								args: (argument for argument in arguments)
								result: toReturn
							return toReturn							
						functions = comparisons()
						comparisons.makeOrderedBinary = makeOrderedBinary
						comparisons.makeUnorderedBinary = makeUnorderedBinary						
					describe "equal", ->
						it "is returned", ->
							equal = (func for func in functions when func.name is "equal")
							expect(equal.length).toEqual 1
							expect(equal[0]).toBe unorderedBinaries.equal.result
							expect unorderedBinaries.equal.args
								.toEqual ["equal", "int", "bool", (jasmine.any Function), (jasmine.any Function)]
						
						describe "supports constant inputs", ->
							it "less", ->
								expect(unorderedBinaries.equal.args[3] 7, 8).toBeFalsy() 
							it "equal", ->
								expect(unorderedBinaries.equal.args[3] 8, 8).toBeTruthy()
							it "greater", ->
								expect(unorderedBinaries.equal.args[3] 9, 8).toBeFalsy()															
							
						it "supports native code generation", ->				
							getCode = (value) ->
								switch value
									when "Test Input A" then "Test Code A"
									when "Test Input B" then "Test Code B"
									else expect(false).toBeTruthy()
							input = 
								properties:
									a: "Test Input A"
									b: "Test Input B"	
							expect unorderedBinaries.equal.args[4] getCode, input
								.toEqual "(Test Code A) == (Test Code B)"
								
					describe "greater", ->
						it "is returned", ->
							greater = (func for func in functions when func.name is "greater")
							expect(greater.length).toEqual 1
							expect(greater[0]).toBe orderedBinaries.greater.result
							expect orderedBinaries.greater.args
								.toEqual ["greater", "int", "bool", (jasmine.any Function), (jasmine.any Function)]
						
						describe "supports constant inputs", ->
							it "less", ->
								expect(orderedBinaries.greater.args[3] 7, 8).toBeFalsy() 
							it "equal", ->
								expect(orderedBinaries.greater.args[3] 8, 8).toBeFalsy()
							it "greater", ->
								expect(orderedBinaries.greater.args[3] 9, 8).toBeTruthy()															
							
						it "supports native code generation", ->				
							getCode = (value) ->
								switch value
									when "Test Input A" then "Test Code A"
									when "Test Input B" then "Test Code B"
									else expect(false).toBeTruthy()
							input = 
								properties:
									a: "Test Input A"
									b: "Test Input B"	
							expect orderedBinaries.greater.args[4] getCode, input
								.toEqual "(Test Code A) > (Test Code B)"								
								
					describe "less", ->
						it "is returned", ->
							less = (func for func in functions when func.name is "less")
							expect(less.length).toEqual 1
							expect(less[0]).toBe orderedBinaries.less.result
							expect orderedBinaries.less.args
								.toEqual ["less", "int", "bool", (jasmine.any Function), (jasmine.any Function)]
						
						describe "supports constant inputs", ->
							it "less", ->
								expect(orderedBinaries.less.args[3] 7, 8).toBeTruthy() 
							it "equal", ->
								expect(orderedBinaries.less.args[3] 8, 8).toBeFalsy()
							it "greater", ->
								expect(orderedBinaries.less.args[3] 9, 8).toBeFalsy()															
							
						it "supports native code generation", ->				
							getCode = (value) ->
								switch value
									when "Test Input A" then "Test Code A"
									when "Test Input B" then "Test Code B"
									else expect(false).toBeTruthy()
							input = 
								properties:
									a: "Test Input A"
									b: "Test Input B"	
							expect orderedBinaries.less.args[4] getCode, input
								.toEqual "(Test Code A) < (Test Code B)"								
								
					describe "greaterEqual", ->
						it "is returned", ->
							greaterEqual = (func for func in functions when func.name is "greaterEqual")
							expect(greaterEqual.length).toEqual 1
							expect(greaterEqual[0]).toBe orderedBinaries.greaterEqual.result
							expect orderedBinaries.greaterEqual.args
								.toEqual ["greaterEqual", "int", "bool", (jasmine.any Function), (jasmine.any Function)]
						
						describe "supports constant inputs", ->
							it "less", ->
								expect(orderedBinaries.greaterEqual.args[3] 7, 8).toBeFalsy() 
							it "equal", ->
								expect(orderedBinaries.greaterEqual.args[3] 8, 8).toBeTruthy()
							it "greater", ->
								expect(orderedBinaries.greaterEqual.args[3] 9, 8).toBeTruthy()															
							
						it "supports native code generation", ->				
							getCode = (value) ->
								switch value
									when "Test Input A" then "Test Code A"
									when "Test Input B" then "Test Code B"
									else expect(false).toBeTruthy()
							input = 
								properties:
									a: "Test Input A"
									b: "Test Input B"	
							expect orderedBinaries.greaterEqual.args[4] getCode, input
								.toEqual "(Test Code A) >= (Test Code B)"								
								
					describe "lessEqual", ->
						it "is returned", ->
							lessEqual = (func for func in functions when func.name is "lessEqual")
							expect(lessEqual.length).toEqual 1
							expect(lessEqual[0]).toBe orderedBinaries.lessEqual.result
							expect orderedBinaries.lessEqual.args
								.toEqual ["lessEqual", "int", "bool", (jasmine.any Function), (jasmine.any Function)]
						
						describe "supports constant inputs", ->
							it "less", ->
								expect(orderedBinaries.lessEqual.args[3] 7, 8).toBeTruthy() 
							it "equal", ->
								expect(orderedBinaries.lessEqual.args[3] 8, 8).toBeTruthy()
							it "greater", ->
								expect(orderedBinaries.lessEqual.args[3] 9, 8).toBeFalsy()															
							
						it "supports native code generation", ->				
							getCode = (value) ->
								switch value
									when "Test Input A" then "Test Code A"
									when "Test Input B" then "Test Code B"
									else expect(false).toBeTruthy()
							input = 
								properties:
									a: "Test Input A"
									b: "Test Input B"	
							expect orderedBinaries.lessEqual.args[4] getCode, input
								.toEqual "(Test Code A) <= (Test Code B)"																