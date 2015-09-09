module.exports = ->
	[
		module.exports.makeUnary "not", "bool", "bool", ((value) -> !value), (platform, cache, value) -> "!(" + (module.exports.codeCache platform, cache, value) + ")"
		module.exports.makeUnorderedBinary "and", "bool", "bool", ((a, b) -> a and b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") && (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.makeUnorderedBinary "or", "bool", "bool", ((a, b) -> a or b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") || (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.makeUnorderedBinary "equal", "bool", "bool", ((a, b) -> a is b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") == (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
	]

module.exports.codeCache = require "./../codeCache"
module.exports.makeUnary = require "./../../helpers/makeUnary"
module.exports.makeOrderedBinary = require "./../../helpers/makeOrderedBinary"
module.exports.makeUnorderedBinary = require "./../../helpers/makeUnorderedBinary"