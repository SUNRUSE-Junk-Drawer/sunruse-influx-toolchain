# Given:
#	The platform instance.
#	A value object.
#	Another value object.
# Returns:
#	Truthy if the value objects are considered the same.
#	For properties, this recurses and returns truthy only when every property is considered the same.
#	Parameters are compared by reference.
#	Native function calls are compared first comparing the functions by reference and then using the "inputsEqual" function against the function.
#	Primitive constants are compared by checking the types match and then calling the "equal" function against the primitive.
#	Otherwise, falsy.
module.exports = (platform, a, b) ->
	if a is b then return true
	if a.properties
		if not b.properties then return
		for name of a.properties
			if not b.properties[name] then return
		for name of b.properties
			if not a.properties[name] then return	
		for name of a.properties
			if not module.exports.valuesEquivalent platform, a.properties[name], b.properties[name] then return
		return true
	if a.primitive
		if not b.primitive then return
		if a.primitive.type isnt b.primitive.type then return
		return platform.primitives[a.primitive.type].equal a.primitive.value, b.primitive.value
	if a.native
		if not b.native then return
		if a.native.function isnt b.native.function then return
		return a.native.function.inputsEqual platform, a.native.input, b.native.input
	
module.exports.valuesEquivalent = module.exports