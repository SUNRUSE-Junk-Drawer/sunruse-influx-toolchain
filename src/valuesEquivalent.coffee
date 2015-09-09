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