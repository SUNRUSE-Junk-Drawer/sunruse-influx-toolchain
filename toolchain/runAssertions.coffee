# Given:
#	The tokenized types.
# Returns:
#	An array, wherein each item is an object describing an assertion result:
#		resultType: String describing the outcome of the assertion:
#			"failedToCompile"
#			"didNotReturnPrimitiveConstant"
#			"primitiveTypeNotAssertable"
#			"primitiveValueIncorrect"				
#			"successful"
#		assertion: The function from the tokenized types which was attempted to
#			be compiled.
#		output: When truthy, the function compiled, and its output value object
#			is here.
# This compiles every function named "assert" with an input of an empty
# properties object.  Each should return a single primitive constant.  If the
# value is equivalent to the primitive type's "assertionPass" property, the
# assertion passes.
module.exports = (tokenized) ->
	emptyProperties = 
		score: 0
		properties: {}
	for funct in tokenized.functions when funct.name is "assert"
		result = module.exports.compileExpression tokenized, emptyProperties, funct.declarations.output, funct
		if not result 
			resultType: "failedToCompile"
			assertion: funct
		else
			if not result.primitive
				resultType: "didNotReturnPrimitiveConstant"
				assertion: funct
				output: result
			else
				primitive = tokenized.primitives[result.primitive.type]
				if primitive.assertionPass is undefined
					resultType: "primitiveTypeNotAssertable"
					assertion: funct
					output: result
				else
					if not primitive.equal result.primitive.value, primitive.assertionPass
						resultType: "primitiveValueIncorrect"
						assertion: funct
						output: result
					else
						resultType: "successful"
						assertion: funct
						output: result
	
module.exports.compileExpression = require "./compileExpression"