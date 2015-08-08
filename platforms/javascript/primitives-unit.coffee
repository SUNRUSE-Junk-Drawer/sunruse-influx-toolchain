platform = require "./types"

describe "platforms", ->
	describe "javascript", ->
		describe "primitives", ->
			describe "int", ->
				describe "parse", ->
					it "returns undefined given no digits", ->
						expect platform.primitives.int.parse "auwdhkawd"
							.toBeUndefined()
					it "returns an int given a positive int", ->
						expect platform.primitives.int.parse "456"
							.toEqual 456						
					it "returns an int given zero", ->
						expect platform.primitives.int.parse "0"
							.toEqual 0						
					it "returns an int given a negative int", ->
						expect platform.primitives.int.parse "-8897"
							.toEqual -8897						
					it "returns undefined given letters at the start", ->
						expect platform.primitives.int.parse "dawd456"
							.toBeUndefined()
					it "returns undefined given letters at the end", ->
						expect platform.primitives.int.parse "456wdawdij"
							.toBeUndefined()
					it "returns undefined given letters in the middle", ->
						expect platform.primitives.int.parse "43efaef456"
							.toBeUndefined()
					it "returns falsy given a zero float", ->
						expect platform.primitives.int.parse "0.0"
							.toBeUndefined()												
					it "returns falsy given a positive float", ->
						expect platform.primitives.int.parse "24.65"
							.toBeUndefined()						
					it "returns falsy given a negative float", ->
						expect platform.primitives.int.parse "-24.65"
							.toBeUndefined()												
			describe "float", ->
				describe "parse", ->
					it "returns undefined given no digits", ->
						expect platform.primitives.float.parse "auwdhkawd"
							.toBeUndefined()
					it "returns undefined given a positive int", ->
						expect platform.primitives.float.parse "456"
							.toBeUndefined()						
					it "returns undefined given zero", ->
						expect platform.primitives.float.parse "0"
							.toBeUndefined()
					it "returns undefined given a negative int", ->
						expect platform.primitives.float.parse "-8897"
							.toBeUndefined()
					it "returns undefined given letters at the start", ->
						expect platform.primitives.float.parse "dawd456"
							.toBeUndefined()
					it "returns undefined given letters at the end", ->
						expect platform.primitives.float.parse "456wdawdij"
							.toBeUndefined()
					it "returns undefined given letters in the middle", ->
						expect platform.primitives.float.parse "43efaef456"
							.toBeUndefined()
					it "returns a float given a zero float", ->
						expect platform.primitives.float.parse "0.0"
							.toEqual 0.0												
					it "returns a float given a positive float", ->
						expect platform.primitives.float.parse "24.65"
							.toEqual 24.65						
					it "returns a float given a negative float", ->
						expect platform.primitives.float.parse "-24.65"
							.toEqual -24.65																			
			describe "bool", ->
				describe "parse", ->
					it "returns undefined given unexpected input", ->
						expect platform.primitives.bool.parse "auwdhkawd"
							.toBeUndefined()
					it "returns true given 'true'", ->
						expect platform.primitives.bool.parse "true"
							.toBe(true)						
					it "returns false given 'false'", ->
						expect platform.primitives.bool.parse "false"
							.toBe(false)														