module.exports = ->
	[
		module.exports.makeUnary "negate", "int", "int", ((value) -> -value), (platform, cache, value) -> "-(" + (module.exports.codeCache platform, cache, value) + ")"
		module.exports.makeUnorderedBinary "add", "int", "int", ((a, b) -> a + b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") + (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.makeOrderedBinary "subtract", "int", "int", ((a, b) -> a - b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") - (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.makeUnorderedBinary "multiply", "int", "int", ((a, b) -> a * b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") * (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.makeOrderedBinary "divide", "int", "int", ((a, b) -> Math.round(a / b)), (platform, cache, value) -> "Math.round((" + (module.exports.codeCache platform, cache, value.properties.a) + ") / (" + (module.exports.codeCache platform, cache, value.properties.b) + "))"
		module.exports.makeOrderedBinary "divideDown", "int", "int", ((a, b) -> Math.floor(a / b)), (platform, cache, value) -> "Math.floor((" + (module.exports.codeCache platform, cache, value.properties.a) + ") / (" + (module.exports.codeCache platform, cache, value.properties.b) + "))"
		module.exports.makeOrderedBinary "divideUp", "int", "int", ((a, b) -> Math.ceil(a / b)), (platform, cache, value) -> "Math.ceil((" + (module.exports.codeCache platform, cache, value.properties.a) + ") / (" + (module.exports.codeCache platform, cache, value.properties.b) + "))"
	]

module.exports.codeCache = require "./../codeCache"
module.exports.makeUnary = require "./../../helpers/makeUnary"
module.exports.makeOrderedBinary = require "./../../helpers/makeOrderedBinary"
module.exports.makeUnorderedBinary = require "./../../helpers/makeUnorderedBinary"