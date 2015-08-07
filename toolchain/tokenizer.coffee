# Given:
#	A JSON object, where the keys are filenames and values are file contents.
# Returns:
#	 a JSON object containing a basic, tokenized set of functions:
# 	functions: An array of JSON objects describing functions.
#		name: String identifying the function.
#		declarations: A JSON object where the keys are the names of the
#					  declarations, and the values are expression objects.
#					  "output" is the return value, while the others are 
#					  temporary variables.
#		line: The line object the function's name was declared on.
# 	Expressions are JSON objects containing:
#		line: The line object the expression was declared on.
#		properties: When the expression is a group of sub-expressions, a JSON
#				    object where the keys are the names of the properties and 
#					the values are expression objects.  Mutually exclusive with
#					"chain".
#		chain: When the expression is a value followed by a sequence of 
#			   function names, an array of the strings making this chain.  
#			   Mutually exclusive with "properties".
# 	primitives: An object where the keys are the names of primitive types, and
#		the values are objects describing primitive types:
#			parse: A function taking a string which may or may not be a 
#				primitive literal as its argument.  When it is not, return 
#				undefined.  When it is, return the value.
# 	nativeFunctions: Initially empty array of objects describing functions.
#		name: String identifying the function.
#		compile: Takes a value object and returns a new value object describing 
#			the output if compilation succeeded, else, falsy.
module.exports = (tokenized, value, name) ->
	throw "notImplemented"