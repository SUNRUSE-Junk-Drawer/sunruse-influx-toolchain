module.exports =
	nativeFunctions:
		require "./int/arithmetic"
			.concat require "./int/comparisons"
			.concat require "./float/arithmetic"
			.concat require "./float/comparisons"
			.concat require "./bool/operators" 
	primitives: 
		int:
			parse: (literal) ->
				if literal.match /^-?\d+$/ then return parseInt literal
		float:
			parse: (literal) ->
				if literal.match /^-?\d+\.\d+$/ then return parseFloat literal
		bool:
			parse: (literal) ->
				switch literal
					when "true" then return true
					when "false" then return false
	functions: []