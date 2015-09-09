describe "platforms", ->
	describe "javascript", ->
		types = undefined
		beforeEach ->
			types = require "./types"
		describe "imports", ->
			it "parameterCache", ->
				expect(types.parameterCache).toBe require "./parameterCache"
			it "resultGenerator", ->
				expect(types.resultGenerator).toBe require "./resultGenerator"
		describe "instance", ->
			platform = undefined
			beforeEach ->
				platform = types()
			describe "compile", ->
				parameterCache = resultGenerator = undefined
				beforeEach ->
					parameterCache = types.parameterCache
					resultGenerator = types.resultGenerator 
				afterEach ->
					types.parameterCache = parameterCache
					types.resultGenerator = resultGenerator
				it "generates and returns native code without working", ->
					cache = undefined
					
					types.parameterCache = (input) ->
						cache = [
								{}
							,
								{}
							,
								{}
							,
								{}
							,
								{}
						]
					
					types.resultGenerator = (platform, _cache, output) ->
						expect(platform).toEqual "Test Platform"
						expect(_cache).toBe cache 
						expect(output).toEqual "Test Output"
						cache.push {}
						cache.push {}
						cache.push {}
						cache.push {}
						cache.push {}																								
						"""
							Test Return Line A
							Test Return Line B
						"""
					
					result = platform.compile "Test Platform", "Test Input", "Test Output"
					
					expect(result).toEqual 	"""
						Test Return Line A
						Test Return Line B
											"""
				it "generates and returns native code with working", ->
					cache = undefined
					
					types.parameterCache = (input) ->
						cache = [
								{}
							,
								{}
							,
								working: "Test Pre-Existing Working A"
							,
								working: "Test Pre-Existing Working B"
							,
								{}
						]
					
					types.resultGenerator = (platform, _cache, output) ->
						expect(platform).toEqual "Test Platform"
						expect(_cache).toBe cache 
						expect(output).toEqual "Test Output"
						cache.push
							working: "Test Working A"
						cache.push
							working: "Test Working B"
						cache.push {}
						cache.push
							working: "Test Working C"
						cache.push {}																								
						"""
							Test Return Line A
							Test Return Line B
						"""
					
					result = platform.compile "Test Platform", "Test Input", "Test Output"
					
					expect(result).toEqual 	"""
						Test Pre-Existing Working A
						Test Pre-Existing Working B
						Test Working A
						Test Working B
						Test Working C
						Test Return Line A
						Test Return Line B
											"""