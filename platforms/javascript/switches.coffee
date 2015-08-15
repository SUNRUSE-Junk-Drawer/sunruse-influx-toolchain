module.exports = ->
	[
		module.exports.makeSwitch "int", (tokenized, cache, value) -> 
			"(" + (module.exports.codeCache tokenized, cache, value.properties.on) + ") ? (" + (module.exports.codeCache tokenized, cache, value.properties.a) + ") : (" + (module.exports.codeCache tokenized, cache, value.properties.b) + ")" 
		module.exports.makeSwitch "float", (tokenized, cache, value) -> 
			"(" + (module.exports.codeCache tokenized, cache, value.properties.on) + ") ? (" + (module.exports.codeCache tokenized, cache, value.properties.a) + ") : (" + (module.exports.codeCache tokenized, cache, value.properties.b) + ")"
		module.exports.makeSwitch "bool", (tokenized, cache, value) -> 
			"(" + (module.exports.codeCache tokenized, cache, value.properties.on) + ") ? (" + (module.exports.codeCache tokenized, cache, value.properties.a) + ") : (" + (module.exports.codeCache tokenized, cache, value.properties.b) + ")"						
	]
	
module.exports.makeSwitch = require "./../helpers/makeSwitch"
module.exports.codeCache = require "./codeCache"