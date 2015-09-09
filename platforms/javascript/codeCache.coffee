# Given:
#	The platform instance.
#	An array of objects describing previously compiled native code:
#		code: String containing code to use when referencing this value.
#		value: The value object code was generated for.
#		working: String containing code generated to compute this value.
#	A value object being compiled into native code.
# Returns:
#	When a primitive constant was given, the appropiate string representing 
#		its value.
#	When a value object matching based on valuesEquivalent exists in the array 
#		of previously compiled native code, temp_(the zero-based index of the 
#		object).
#	When a native function, its function.generateCode is called with the array
#		of previously compiled native code as the first argument and the input
#		as the second.  The result is then stored in a new object in the array.
#	If none of these conditions pass, falsy.
module.exports = (platform, cache, value) ->
	if value.primitive
		switch value.primitive.type
			when "int" then return "" + value.primitive.value
			when "bool" then return "" + value.primitive.value
			when "float"
				temp = "" + value.primitive.value
				if Number.isInteger value.primitive.value then temp += ".0"
				return temp
	for cached in cache
		if module.exports.valuesEquivalent platform, cached.value, value
			return cached.code
	if value.native
		generated = value.native.function.generateCode platform, cache, value.native.input
		greatest = 0
		for existing in cache
			if existing.value.native then greatest++
		created = 
			code: "temp_" + greatest
			value: value
			working: "var temp_" + greatest + " = " + generated + ";"
		cache.push created
		return created.code

module.exports.valuesEquivalent = require "./../../toolchain/valuesEquivalent"