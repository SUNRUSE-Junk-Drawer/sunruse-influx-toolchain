module.exports = ->
	[
		module.exports.makeUnorderedBinary "equal", "float", "bool", ((a, b) -> a is b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") == (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.makeOrderedBinary "greater", "float", "bool", ((a, b) -> a > b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") > (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.makeOrderedBinary "less", "float", "bool", ((a, b) -> a < b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") < (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.makeOrderedBinary "greaterEqual", "float", "bool", ((a, b) -> a >= b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") >= (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.makeOrderedBinary "lessEqual", "float", "bool", ((a, b) -> a <= b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") <= (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"		
	]

module.exports.codeCache = require "./../codeCache"
module.exports.makeOrderedBinary = require "./../../helpers/makeOrderedBinary"
module.exports.makeUnorderedBinary = require "./../../helpers/makeUnorderedBinary"