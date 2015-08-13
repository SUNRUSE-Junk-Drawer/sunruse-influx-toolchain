module.exports = ->
	[
		module.exports.makeUnorderedBinary "equal", "int", "bool", ((a, b) -> a is b), (getCode, value) -> "(" + (getCode value.properties.a) + ") == (" + (getCode value.properties.b) + ")"
		module.exports.makeOrderedBinary "greater", "int", "bool", ((a, b) -> a > b), (getCode, value) -> "(" + (getCode value.properties.a) + ") > (" + (getCode value.properties.b) + ")"
		module.exports.makeOrderedBinary "less", "int", "bool", ((a, b) -> a < b), (getCode, value) -> "(" + (getCode value.properties.a) + ") < (" + (getCode value.properties.b) + ")"
		module.exports.makeOrderedBinary "greaterEqual", "int", "bool", ((a, b) -> a >= b), (getCode, value) -> "(" + (getCode value.properties.a) + ") >= (" + (getCode value.properties.b) + ")"
		module.exports.makeOrderedBinary "lessEqual", "int", "bool", ((a, b) -> a <= b), (getCode, value) -> "(" + (getCode value.properties.a) + ") <= (" + (getCode value.properties.b) + ")"		
	]

module.exports.makeOrderedBinary = require "./../../helpers/makeOrderedBinary"
module.exports.makeUnorderedBinary = require "./../../helpers/makeUnorderedBinary"