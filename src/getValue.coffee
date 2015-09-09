module.exports = (platform, input, token, funct, log, logPrefix, cache) ->
	if token is "input"
		if log
			log.push logPrefix + "Initial value is the input." 
		return input
	for primitive of platform.primitives
		value = platform.primitives[primitive].parse token
		if value isnt undefined
			if log
				log.push logPrefix + "Initial value is the literal \"" + token + "\" of primitive type \"" + primitive + "\"." 
			return unused =
				score: 0
				primitive:
					type: primitive
					value: value
	if funct.declarations[token]
		if log
			log.push logPrefix + "Attempting to compile declaration \"" + token + "\"..." 
		return module.exports.compileExpression platform, input, funct.declarations[token], funct, log, logPrefix + "\t", cache
	if log
		log.push logPrefix + "Failed to resolve initial value \"" + token + "\"." 
	return
		
module.exports.compileExpression = require "./compileExpression"