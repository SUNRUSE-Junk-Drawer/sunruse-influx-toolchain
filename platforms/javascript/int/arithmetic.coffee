module.exports = ->
	[
		module.exports.makeUnary "negate", "int", "int", ((value) -> -value), (getCode, value) -> "-(" + (getCode value) + ")"
		module.exports.makeUnorderedBinary "add", "int", "int", ((a, b) -> a + b), (getCode, value) -> "(" + (getCode value.properties.a) + ") + (" + (getCode value.properties.b) + ")"
		module.exports.makeOrderedBinary "subtract", "int", "int", ((a, b) -> a - b), (getCode, value) -> "(" + (getCode value.properties.a) + ") - (" + (getCode value.properties.b) + ")"
		module.exports.makeUnorderedBinary "multiply", "int", "int", ((a, b) -> a * b), (getCode, value) -> "(" + (getCode value.properties.a) + ") * (" + (getCode value.properties.b) + ")"
		module.exports.makeOrderedBinary "divide", "int", "int", ((a, b) -> Math.round(a / b)), (getCode, value) -> "(" + (getCode value.properties.a) + ") / (" + (getCode value.properties.b) + ")"
	]

module.exports.makeUnary = require "./../../helpers/makeUnary"
module.exports.makeOrderedBinary = require "./../../helpers/makeOrderedBinary"
module.exports.makeUnorderedBinary = require "./../../helpers/makeUnorderedBinary"