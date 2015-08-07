# Given:
#	The tokenized functions.
#	The input value object.
#	An expression object.
#	The function containing the expression.
# Returns:
#	When the expression does not compile, falsy.
#	When the expression compiles, a JSON object:
#		score: The score calculated by summing the value and functions' scores.
#		value: The value object returned.
module.exports = (tokenized, value, expression, funct) ->
	throw "notImplemented"