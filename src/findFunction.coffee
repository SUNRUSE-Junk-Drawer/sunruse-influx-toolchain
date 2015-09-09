module.exports = (platform, input, name, log, logPrefix, cache) ->
	if log
		log.push logPrefix + "Attempting to find a match for function \"" + name + "\"..."
	if input.properties and input.properties[name]
		if log
			log.push logPrefix + "\tUsing the property of the input with a score of " + input.properties[name].score + "."
		input.properties[name]
	else
		if cache[name]
			for cached in cache[name]
				if module.exports.valuesEquivalent platform, input, cached.input
					if log
						log.push logPrefix + "\tTaken from cache."
					return cached.output
		else
			cache[name] = []
		best = []
		bestScore = null
		handleValue = (value, origin) ->
			if value
				if log
					log.push logPrefix + "\t\tSuccessfully compiled with a score of " + value.score + "."
				if not bestScore or value.score > bestScore
					bestScore = value.score
					best = [
						value: value
						origin: origin
					]
				else if value.score is bestScore
					best.push 
						value: value
						origin: origin
			else if log
				log.push logPrefix + "\t\tThis implementation did not compile."
					
		for id of platform.functions
			implementation = platform.functions[id]
			if implementation.name isnt name then continue
			if log
				log.push logPrefix + "\tTrying implementation in file \"" + implementation.line.filename + "\" on line " + implementation.line.line + "..."			
			handleValue (module.exports.compileExpression platform, input, implementation.declarations.output, implementation, log, logPrefix + "\t\t", cache), implementation					
					
		for id of platform.nativeFunctions
			implementation = platform.nativeFunctions[id]
			if implementation.name isnt name then continue
			if log
				log.push logPrefix + "\tTrying native implementation returning primitive type \"" + implementation.output + "\"..." 
			handleValue (implementation.compile input, log, logPrefix + "\t\t"), implementation

		if log
			if best.length
				if best[0].origin.line
					log.push logPrefix + "\tSelected the implementation in file \"" + best[0].origin.line.filename + "\" on line " + best[0].origin.line.line + " which scored " + best[0].value.score + "."
				else
					log.push logPrefix + "\tSelected the native implementation returning primitive type \"" + best[0].origin.output + "\" which scored " + best[0].value.score + "."
			else
				log.push logPrefix + "\tNo matches were found."
		best = if best.length then best[0].value else null
		cache[name].push 
			input: input
			output: best
		best
	
module.exports.compileExpression = require "./compileExpression"
module.exports.valuesEquivalent = require "./valuesEquivalent"