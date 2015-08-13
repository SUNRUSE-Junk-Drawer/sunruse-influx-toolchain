# Given:
#	A value object representing the inputs to the function.
# Returns:
#	An array of objects to be used with codeCache describing the parameters:
#		code: String referencing the parameter.  Of the format 
#			"input.(property name).(property name)".
#		value: The value object code was generated for.
#	Code is not generated for primitive constants.
module.exports = (input) ->
	output = []
	
	recurse = (node, path) ->
		if node.properties
			for name of node.properties
				recurse node.properties[name], path + "." + name
				
		if node.parameter
			output.push
				code: path
				value: node
		
	recurse input, "input"
	
	output