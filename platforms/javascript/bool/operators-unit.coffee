describe "platforms", ->
	describe "javascript", ->
		describe "bool", ->
			describe "operators", ->
				operators = undefined
				beforeEach ->
					operators = require "./operators"
				describe "imports", ->
					it "makeUnary", ->
						expect(operators.makeUnary).toBe require "./../../helpers/makeUnary"
					it "makeOrderedBinary", ->
						expect(operators.makeOrderedBinary).toBe require "./../../helpers/makeOrderedBinary"						
					it "makeUnorderedBinary", ->
						expect(operators.makeUnorderedBinary).toBe require "./../../helpers/makeUnorderedBinary"
					it "codeCache", ->
						expect(operators.codeCache).toBe require "./../codeCache"
				describe "defines", ->
					codeCache = functions = unaries = unorderedBinaries = orderedBinaries = undefined
					beforeEach ->
						makeUnary = operators.makeUnary
						makeOrderedBinary = operators.makeOrderedBinary
						makeUnorderedBinary = operators.makeUnorderedBinary
						codeCache = operators.codeCache
						operators.makeUnary = jasmine.createSpy()
						operators.makeOrderedBinary = jasmine.createSpy()
						operators.makeUnorderedBinary = jasmine.createSpy()
						unaries = {}
						operators.makeUnary.and.callFake (name) ->
							toReturn = makeUnary.apply this, arguments
							unaries[name] =
								args: (argument for argument in arguments) 
								result: toReturn
							return toReturn
						orderedBinaries = {}
						operators.makeOrderedBinary.and.callFake (name) ->
							toReturn = makeOrderedBinary.apply this, arguments
							orderedBinaries[name] = 
								args: (argument for argument in arguments)
								result: toReturn
							return toReturn
						unorderedBinaries = {}							
						operators.makeUnorderedBinary.and.callFake (name) ->
							toReturn = makeUnorderedBinary.apply this, arguments
							unorderedBinaries[name] = 
								args: (argument for argument in arguments)
								result: toReturn
							return toReturn							
						functions = operators()
						operators.makeUnary = makeUnary
						operators.makeOrderedBinary = makeOrderedBinary
						operators.makeUnorderedBinary = makeUnorderedBinary						
						
						operators.codeCache = (platform, cache, value) ->
							expect(platform).toEqual "Test Platform"
							expect(cache).toEqual "Test Cache"
							switch value
								when "Test Input" then return "Test Code"
								when "Test Input A" then return "Test Code A"
								when "Test Input B" then return "Test Code B"
								else expect(false).toBeTruthy()
					afterEach ->
						operators.codeCache = codeCache
					describe "and", ->
						it "is returned", ->
							_and = (func for func in functions when func.name is "and")
							expect(_and.length).toEqual 1
							expect(_and[0]).toBe unorderedBinaries.and.result
							expect unorderedBinaries.and.args
								.toEqual ["and", "bool", "bool", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs for false, false", ->
							expect(unorderedBinaries.and.args[3] false, false).toBe false  
							
						it "supports constant inputs for false, true", ->
							expect(unorderedBinaries.and.args[3] false, true).toBe false  
							
						it "supports constant inputs for true, false", ->
							expect(unorderedBinaries.and.args[3] true, false).toBe false  
							
						it "supports constant inputs for true, true", ->
							expect(unorderedBinaries.and.args[3] true, true).toBe true  																					
							
						it "supports native code generation", ->				
							input = 
								properties:
									a: "Test Input A"
									b: "Test Input B"	
							expect unorderedBinaries.and.args[4] "Test Platform", "Test Cache", input
								.toEqual "(Test Code A) && (Test Code B)"
					describe "or", ->
						it "is returned", ->
							_or = (func for func in functions when func.name is "or")
							expect(_or.length).toEqual 1
							expect(_or[0]).toBe unorderedBinaries.or.result
							expect unorderedBinaries.or.args
								.toEqual ["or", "bool", "bool", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs for false, false", ->
							expect(unorderedBinaries.or.args[3] false, false).toBe false  
							
						it "supports constant inputs for true, false", ->
							expect(unorderedBinaries.or.args[3] true, false).toBe true
							
						it "supports constant inputs for false, true", ->
							expect(unorderedBinaries.or.args[3] false, true).toBe true  
							
						it "supports constant inputs for true, true", ->
							expect(unorderedBinaries.or.args[3] true, true).toBe true  														  
							
						it "supports native code generation", ->				
							input = 
								properties:
									a: "Test Input A"
									b: "Test Input B"	
							expect unorderedBinaries.or.args[4] "Test Platform", "Test Cache", input
								.toEqual "(Test Code A) || (Test Code B)"
					describe "equal", ->
						it "is returned", ->
							equal = (func for func in functions when func.name is "equal")
							expect(equal.length).toEqual 1
							expect(equal[0]).toBe unorderedBinaries.equal.result
							expect unorderedBinaries.equal.args
								.toEqual ["equal", "bool", "bool", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs for false, false", ->
							expect(unorderedBinaries.equal.args[3] false, false).toBe true  
							
						it "supports constant inputs for true, false", ->
							expect(unorderedBinaries.equal.args[3] true, false).toBe false
							
						it "supports constant inputs for false, true", ->
							expect(unorderedBinaries.equal.args[3] false, true).toBe false  
							
						it "supports constant inputs for true, true", ->
							expect(unorderedBinaries.equal.args[3] true, true).toBe true  														  
							
						it "supports native code generation", ->				
							input = 
								properties:
									a: "Test Input A"
									b: "Test Input B"	
							expect unorderedBinaries.equal.args[4] "Test Platform", "Test Cache", input
								.toEqual "(Test Code A) == (Test Code B)"
					describe "not", ->
						it "is returned", ->
							_not = (func for func in functions when func.name is "not")
							expect(_not.length).toEqual 1
							expect(_not[0]).toBe unaries.not.result
							expect unaries.not.args
								.toEqual ["not", "bool", "bool", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs of false", ->
							expect(unaries.not.args[3] false).toBe true
						
						it "supports constant inputs of true", ->
							expect(unaries.not.args[3] true).toBe false
						
						it "supports native code generation", ->
							expect unaries.not.args[4] "Test Platform", "Test Cache", "Test Input"
								.toEqual "!(Test Code)"																		