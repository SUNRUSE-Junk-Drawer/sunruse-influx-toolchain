module.exports = (val, callback) ->
	if val.properties
		for name of val.properties
			module.exports val.properties[name], callback
	if val.native
		module.exports val.native.input, callback
	callback val