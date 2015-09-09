module.exports = ->
	[
		module.exports.makeUnary "negate", "float", "float", ((value) -> -value), (platform, cache, value) -> "-(" + (module.exports.codeCache platform, cache, value) + ")"
		module.exports.makeUnorderedBinary "add", "float", "float", ((a, b) -> a + b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") + (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.makeOrderedBinary "subtract", "float", "float", ((a, b) -> a - b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") - (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.makeUnorderedBinary "multiply", "float", "float", ((a, b) -> a * b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") * (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.makeOrderedBinary "divide", "float", "float", ((a, b) -> a / b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") / (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
	]

module.exports.codeCache = require "./../codeCache"
module.exports.makeUnary = require "./../../helpers/makeUnary"
module.exports.makeOrderedBinary = require "./../../helpers/makeOrderedBinary"
module.exports.makeUnorderedBinary = require "./../../helpers/makeUnorderedBinary"