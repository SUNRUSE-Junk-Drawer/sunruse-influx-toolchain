# Given:
#	String naming the function.
#	String specifying the input primitive type by name.
#	String specifying the output primitive type by name.
#	Function taking the primitive value pair when the input is constant and returning a primitive constant for the output.
#	Function stored as "generateCode" against the native function object; what this takes and returns is platform-specific.
# Returns:
#	A native function object.
module.exports = (name, inputType, outputType, forConstants, generateCode) ->
	instance = 
		name: name
		output: outputType
		compile: (value) ->
			if not value.properties then return null
			if not value.properties.a or not value.properties.b then return null
			if not module.exports.valueIsPrimitive value.properties.a, inputType then return null
			if not module.exports.valueIsPrimitive value.properties.b, inputType then return null
			if value.properties.a.primitive and value.properties.b.primitive
				return unused =
					score: value.properties.a.score + value.properties.b.score + 1
					primitive:
						type: outputType
						value: forConstants value.properties.a.primitive.value, value.properties.b.primitive.value
			else
				return unused = 
					score: value.properties.a.score + value.properties.b.score + 1
					native:
						function: instance
						input: 
							score: value.properties.a.score + value.properties.b.score
							properties:
								a: value.properties.a
								b: value.properties.b
		inputsEqual: (platform, a, b) ->
			((module.exports.valuesEquivalent platform, a.properties.a, b.properties.a) and (module.exports.valuesEquivalent platform, a.properties.b, b.properties.b)) or ((module.exports.valuesEquivalent platform, a.properties.a, b.properties.b) and (module.exports.valuesEquivalent platform, a.properties.b, b.properties.a))
		generateCode: generateCode
module.exports.valueIsPrimitive = require "./../../toolchain/valueIsPrimitive"
module.exports.valuesEquivalent = require "./../../toolchain/valuesEquivalent"