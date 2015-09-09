# Platforms are functions returning objects containing:
# 	primitives: An object where the keys are the names of primitive types, and
#		the values are objects describing primitive types:
#			parse: A function taking a string which may or may not be a 
#				primitive literal as its argument.  When it is not, return 
#				undefined.  When it is, return the value.
#			equal: Takes two values previously returned by parse.  Return
#				truthy when they refer to the same value, else, falsy.
#			assertionPass: When not undefined, a value to be compared with the
#				a primitive value returned by an assertion, using the "equal"
#				function.  The assertion will pass when this matches.
# 	nativeFunctions: Initially empty array of objects describing functions.
#		name: String identifying the function.
#		compile: Takes a value object and returns a new value object describing 
#			the output if compilation succeeded, else, falsy.
#		inputsEqual: Takes the platform and two value objects returned 
#			by separate calls to compile.  Return truthy when they should 
#			compile to the same native call, and falsy when they should not.
#		output: String identifying the primitive type returned. 
#	compile: Takes the platform, an input value object, the output 
#		value object and returns generated native code.
# Typically, the following would be added afterwards:
#	functions: The tokenized functions.