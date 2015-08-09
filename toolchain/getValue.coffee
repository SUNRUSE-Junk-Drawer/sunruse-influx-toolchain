# Given:
#	The tokenized functions.
#	The input value object.
#	A string containing the starting value of an expression.
#	The function containing the expression.
# Returns:
#	When the starting value could not be resolved, falsy.
#	When the starting value is a primitive literal, a value object containing
#	the primitive.
#	When the starting value is "input", the input value object.
#	When the starting value is the name of a temporary variable, the result of
#	compileExpression for that temporary variable. 

module.exports = (tokenized, input, token, funct) ->
	if token is "input" then return input
	for primitive of tokenized.primitives
		value = tokenized.primitives[primitive].parse token
		if value isnt undefined
			return unused =
				score: 0
				primitive:
					type: primitive
					value: value
	if funct.declarations[token]
		return module.exports.compileExpression tokenized, input, funct.declarations[token], funct
		
module.exports.compileExpression = require "./compileExpression"