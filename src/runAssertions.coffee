module.exports = (platform) ->
	emptyProperties = 
		score: 0
		properties: {}
	for funct in platform.functions when funct.name is "assert"
		result = module.exports.compileExpression platform, emptyProperties, funct.declarations.output, funct, null, null, {}
		if not result 
			resultType: "failedToCompile"
			assertion: funct
		else
			if not result.primitive
				resultType: "didNotReturnPrimitiveConstant"
				assertion: funct
				output: result
			else
				primitive = platform.primitives[result.primitive.type]
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