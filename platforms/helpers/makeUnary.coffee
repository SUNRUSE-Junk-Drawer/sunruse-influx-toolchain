# Given:
#	String naming the function.
#	String specifying the input primitive type by name.
#	String specifying the output primitive type by name.
#	Function taking the primitive value when the input is constant and returning a primitive constant for the output.
#	Function stored as "generateCode" against the native function object; what this takes and returns is platform-specific.
# Returns:
#	A native function object.
module.exports = (name, inputType, outputType, forConstants, generateCode) ->
	instance = 
		name: name
		output: outputType
		compile: (value) ->
			if not module.exports.valueIsPrimitive value, inputType then return null
			if value.primitive
				return unused =
					score: value.score + 1
					primitive:
						type: outputType
						value: forConstants value.primitive.value
			else
				return unused = 
					score: value.score + 1
					native:
						function: instance
						input: value
		inputsEqual: (platform, a, b) ->
			module.exports.valuesEquivalent platform, a, b
		generateCode: generateCode
module.exports.valueIsPrimitive = require "./../../toolchain/valueIsPrimitive"
module.exports.valuesEquivalent = require "./../../toolchain/valuesEquivalent"