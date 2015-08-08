# Given:
#	A value object.
#	The name of a primitive type.
# Returns:
#	Truthy when the value object is of the named primitive type.
#	Otherwise, falsy.

module.exports = (value, name) ->
	if value.primitive?.type is name then return true
	if value.native?.function.output is name then return true
	if value.parameter?.type is name then return true