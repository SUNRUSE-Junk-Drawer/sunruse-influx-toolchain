# Given:
#	The platform instance.
#	The array of previously generated code returned by parameterCache/used by
#		codeCache.
#	The output value object to generate code for.
# Returns:
#	A string representing native code specifying the return statement.  For
#		properties this takes the form of an anonymous object, while for 
#		primitive types the bare value is returned.
module.exports = (platform, cache, output) ->
	final = []
	recurseResults = (val, prefix, indents, suffix) ->
		if val.properties
			final.push indents + prefix + "{"
			done = 0
			for name of val.properties
				recurseResults val.properties[name], "\"" + name + "\": ", indents + "\t", (if done is (Object.keys val.properties).length - 1 then "" else ",")
				done++ 
			final.push indents + "}" + suffix
		else
			final.push indents + prefix + (module.exports.codeCache platform, cache, val) + suffix
	
	recurseResults output, "return ", "", ";"
	final.join "\n"
module.exports.codeCache = require "./codeCache"