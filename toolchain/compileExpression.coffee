# Given:
#	The tokenized functions.
#	The input value object.
#	An expression object.
#	The function containing the expression.
# Returns:
#	When the expression does not compile, falsy.
#	When the expression compiles, the value object generated is returned.
module.exports = (tokenized, input, expression, funct) ->
	if expression.chain
		value = module.exports.getValue tokenized, input, expression.chain[0], funct
		for func in [1 ... expression.chain.length]
			if not value then return null
			value = module.exports.findFunction tokenized, value, expression.chain[func]
		value
	else
		output =
			score: 0 
			properties: {}
		for property of expression.properties
			value = module.exports.compileExpression tokenized, input, expression.properties[property], funct
			if not value then return null
			output.properties[property] = value
			output.score += value.score
		return output
	
module.exports.getValue = require "./getValue"
module.exports.findFunction = require "./findFunction"
module.exports.compileExpression = module.exports