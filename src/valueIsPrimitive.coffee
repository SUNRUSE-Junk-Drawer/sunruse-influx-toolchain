module.exports = (value, name) ->
	if value.primitive?.type is name then return true
	if value.native?.function.output is name then return true
	if value.parameter?.type is name then return true