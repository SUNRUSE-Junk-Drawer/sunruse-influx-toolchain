module.exports = ->
	[
		module.exports.makeSwitch "int", (platform, cache, value) -> 
			"(" + (module.exports.codeCache platform, cache, value.properties.on) + ") ? (" + (module.exports.codeCache platform, cache, value.properties.b) + ") : (" + (module.exports.codeCache platform, cache, value.properties.a) + ")" 
		module.exports.makeSwitch "float", (platform, cache, value) -> 
			"(" + (module.exports.codeCache platform, cache, value.properties.on) + ") ? (" + (module.exports.codeCache platform, cache, value.properties.b) + ") : (" + (module.exports.codeCache platform, cache, value.properties.a) + ")"
		module.exports.makeSwitch "bool", (platform, cache, value) -> 
			"(" + (module.exports.codeCache platform, cache, value.properties.on) + ") ? (" + (module.exports.codeCache platform, cache, value.properties.b) + ") : (" + (module.exports.codeCache platform, cache, value.properties.a) + ")"						
	]
	
module.exports.makeSwitch = require "./../helpers/makeSwitch"
module.exports.codeCache = require "./codeCache"