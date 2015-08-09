# Given:
#	A value object.
#	A callback taking the found value object as an argument.
# Executes the callback for the value object after recursing through every
# child object:
#	Every property of properties objects.
#	The input of every native function call.
module.exports = (val, callback) ->
	if val.properties
		for name of val.properties
			module.exports val.properties[name], callback
	if val.native
		module.exports val.native.input, callback
	callback val