module.exports =
	nativeFunctions:
		(require "./int/arithmetic")()
			.concat (require "./int/comparisons")()
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
	compile: (tokenized, input, output) ->
		cache = module.exports.parameterCache input
		result = module.exports.resultGenerator tokenized, cache, output
		working = (cached.working for cached in cache when cached.working).join "\n"
		if working then working += "\n"
		result = working + result
		result
		
module.exports.parameterCache = require "./parameterCache"
module.exports.resultGenerator = require "./resultGenerator"