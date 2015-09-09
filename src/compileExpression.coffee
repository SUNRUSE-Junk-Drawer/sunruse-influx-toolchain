module.exports = (platform, input, expression, funct, log, logPrefix, cache) ->
	if expression.chain
		if log
			chain = []
			for token in expression.chain
				chain.push token.token
			log.push logPrefix + "Attempting to compile chain \"" + (chain.join " ") + "\"..."
		value = module.exports.getValue platform, input, expression.chain[0].token, funct, log, logPrefix + "\t", cache
		for func in [1 ... expression.chain.length]
			if not value then return null
			value = module.exports.findFunction platform, value, expression.chain[func].token, log, logPrefix + "\t", cache
		if log and value
			log.push logPrefix + "\tSuccessfully compiled chain."
		value
	else
		output =
			score: 0 
			properties: {}
		if log
			log.push logPrefix + "Attempting to compile properties " + ((Object.keys expression.properties).join ", ") + "..."
		for property of expression.properties
			if log
				log.push logPrefix + "Attempting to compile property \"" + property + "\"..."
			value = module.exports.compileExpression platform, input, expression.properties[property], funct, log, logPrefix + "\t", cache
			if not value then return null
			output.properties[property] = value
			output.score += value.score
		if log
			log.push logPrefix + "\tSuccessfully compiled all properties with a total score of " + output.score + "."			
		output
	
module.exports.getValue = require "./getValue"
module.exports.findFunction = require "./findFunction"
module.exports.compileExpression = module.exports