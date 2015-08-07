# Given:
#	The tokenized functions.
#	The computed value object to take as an input.
#	The name of the function to resolve.
# Returns:
#	If the value has properties and the function name matches one of those 
#	properties:
#		score: 1
#		value: The property named in the value object.
#	If no matching function compiled, falsy.
#	If functions matched:
#		score: The score obtained by the highest scoring function.
#		value: The value object returned by the highest scoring function.
module.exports = (tokenized, value, name) ->
	throw "notImplemented"