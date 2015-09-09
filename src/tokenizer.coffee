module.exports = (files) ->
	output = []
	for filename of files
		lines = files[filename].split("\n")
		indentations = []
		declaringFunction = null
		lastPropertyChainWhitespaces = null
		for line, lineNumber in lines
			if line.trim()[0] is "#" then continue
			whitespaces = line.search /\S/
			switch whitespaces
				when -1 then ;
				when 0
					lastPropertyChainWhitespaces = null
					if line.trim().split(/\s+/).length > 1
						throw
							reason: "unexpectedTokensFollowingFunctionName"
							line:
								filename: filename
								line: lineNumber
								columns:
									from: whitespaces
									to: whitespaces + line.trim().length
					declaringFunction = 
						name: line.trim()
						line:
							filename: filename
							line: lineNumber
							columns:
								from: whitespaces
								to: whitespaces + line.trim().length
						declarations: {}
					output.push declaringFunction
					indentations = []
				else
					if not declaringFunction
						throw
							reason: "unexpectedIndentation"
							line:
								filename: filename
								line: lineNumber
								columns:
									from: whitespaces
									to: whitespaces + line.trim().length					
					
					if lastPropertyChainWhitespaces and lastPropertyChainWhitespaces < whitespaces
						throw
							reason: "unexpectedIndentation"
							line:
								filename: filename
								line: lineNumber
								columns:
									from: whitespaces
									to: whitespaces + line.trim().length
					
					deletedTo = null
					while indentations.length and whitespaces <= indentations[indentations.length - 1].whitespaces
						deletedTo = indentations[indentations.length - 1].whitespaces
						indentations.length-- 
						
					if deletedTo isnt null and deletedTo isnt whitespaces and indentations.length and indentations[indentations.length - 1].whitespaces < whitespaces
						throw
							reason: "unindentedToUnexpectedLevel"
							line:
								filename: filename
								line: lineNumber
								columns:
									from: whitespaces
									to: line.trim().length + whitespaces
					tokens = line.trim().split /\s+/
					
					parent = undefined
					if indentations.length
						if indentations[indentations.length - 1].properties[tokens[0]]
							throw
								reason: "propertyNamesNotUnique"
								line:
									filename: filename
									line: lineNumber
									columns:
										from: whitespaces
										to: tokens[0].length + whitespaces
						parent = indentations[indentations.length - 1].properties
					else
						if declaringFunction.declarations[tokens[0]]
							throw
								reason: "declarationNamesNotUnique"
								line:
									filename: filename
									line: lineNumber
									columns:
										from: whitespaces
										to: tokens[0].length + whitespaces						
						parent = declaringFunction.declarations

					created = undefined
					
					if tokens.length is 1
						lastPropertyChainWhitespaces = null
						# With expression of properties.
						created =
							line:
								filename: filename
								line: lineNumber
								columns:
									from: whitespaces
									to: whitespaces + tokens[0].length
							properties: {}								
						
						indentations.push
							whitespaces: whitespaces
							properties: created.properties									
					else
						lastPropertyChainWhitespaces = whitespaces
						# With expression of function chain.
						created =
							line:
								filename: filename
								line: lineNumber
								columns:
									from: whitespaces
									to: whitespaces + tokens[0].length
							chain: []						
						
						# This split is done manually so we can get at the column numbers.
						tokenStart = null
						
						for i in [whitespaces + tokens[0].length ... line.length + 1]
							ch = line[i]
							if not ch or /\s/.test ch
								if tokenStart
									created.chain.push
										token: line.slice tokenStart, i
										line:
											filename: filename
											line: lineNumber
											columns:
												from: tokenStart
												to: i
									tokenStart = null
							else
								if not tokenStart
									tokenStart = i
					parent[tokens[0]] = created 
					
	for functionName of output when not output[functionName].declarations["output"]
		throw
			reason: "functionHasNoOutput"
			line: output[functionName].line
					
	recurse = (property) ->
		if property.properties
			if not (Object.keys property.properties).length
				throw
					reason: "expectedExpression"
					line: property.line
			recurse property.properties[propertyName] for propertyName of property.properties
	
	recurse output[functionName].declarations[declarationName] for declarationName of output[functionName].declarations for functionName of output
	output