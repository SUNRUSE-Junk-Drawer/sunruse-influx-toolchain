# Given:
#	The tokenized functions.
#	The value object to take as an input.
#	The name of the function to resolve.
# Returns:
#	If the value has properties and the function name matches one of those 
#	properties:
#		score: 1
#		value: The property named in the value object.
#	If no matching function compiled, falsy.
#	If functions matched, the value object returned by the highest scoring function,
#	whether native or otherwise.
module.exports = (tokenized, input, name) ->
	if input.properties and input.properties[name]
		input.properties[name]
	else
		best = []
		bestScore = null
		handleValue = (value) ->
			if value
				if not bestScore or value.score > bestScore
					bestScore = value.score
					best = [value]
				else if value.score is bestScore
					best.push value
					
		for id of tokenized.functions
			if tokenized.functions[id].name isnt name then continue
			handleValue module.exports.compileExpression tokenized, input, tokenized.functions[id].declarations.output, tokenized.functions[id]					
					
		for id of tokenized.nativeFunctions
			if tokenized.nativeFunctions[id].name isnt name then continue
			handleValue tokenized.nativeFunctions[id].compile input

		best[0]
	
module.exports.compileExpression = require "./compileExpression"