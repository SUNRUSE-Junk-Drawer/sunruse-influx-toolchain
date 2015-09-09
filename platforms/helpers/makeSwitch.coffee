# Given:
#	String specifying the input/output primitive type by name.
#	Function stored as "generateCode" against the native function object; what this takes and returns is platform-specific.
# Returns:
#	A native function object specifying a "switch" function, taking:
#		a
#		b
#		on 
#	And returning a when on is false, and b when on is true.
module.exports = (primitiveType, generateCode) ->
	instance = 
		name: "switch"
		output: primitiveType
		compile: (value) ->
			if not value.properties then return null
			if not value.properties.a then return null
			if not value.properties.b then return null
			if not value.properties.on then return null
			if not module.exports.valueIsPrimitive value.properties.a, primitiveType then return null
			if not module.exports.valueIsPrimitive value.properties.b, primitiveType then return null
			if not module.exports.valueIsPrimitive value.properties.on, "bool" then return null
			if value.properties.on.primitive
				cloned = {}
				source = if value.properties.on.primitive.value then value.properties.b else value.properties.a
				cloned[propertyName] = source[propertyName] for propertyName of source
				cloned.score = value.properties.a.score + value.properties.b.score + value.properties.on.score + 1 
				return cloned
			else
				return unused =
					score: value.properties.a.score + value.properties.b.score + value.properties.on.score + 1
					native:
						function: instance
						input:
							score: value.properties.a.score + value.properties.b.score + value.properties.on.score
							properties:
								a: value.properties.a
								b: value.properties.b
								on: value.properties.on
		inputsEqual: (platform, a, b) ->
			(module.exports.valuesEquivalent platform, a.properties.on, b.properties.on) and (module.exports.valuesEquivalent platform, a.properties.a, b.properties.a) and (module.exports.valuesEquivalent platform, a.properties.b, b.properties.b)
		generateCode: generateCode
	
module.exports.valueIsPrimitive = require "./../../toolchain/valueIsPrimitive"
module.exports.valuesEquivalent = require "./../../toolchain/valuesEquivalent"	