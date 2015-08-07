# Value objects contain:
#	score: Integer; the score accumulated by following this path.
#	type: String stating what kind of value is held.
#	properties: When truthy, an object where the keys are the names of 
#		properties inside the value, and the values are the value objects held.
#	native: When truthy, the value is the result of executing a native
#		function.  An object containing:
#			function: The native function which was executed.
#			input: The input to the native function.
#	primitive: When truthy, the value is a primitive constant.  An object
#		containing:
#			type: String specifying the name of the primitive type.
#			value: The value held.
#	parameter: When truthy, the value is a runtime parameter.  An object
#		containing:
#			type: String specifying the name of the primitive type.