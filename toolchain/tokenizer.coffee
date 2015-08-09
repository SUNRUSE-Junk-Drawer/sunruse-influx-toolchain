# Given:
#	A JSON object, where the keys are filenames and values are file contents.
# Returns:
#	An array of JSON objects describing the non-native functions.
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
#			   function names, an array of JSON objects describing this.
#			   Mutually exclusive with "properties".
#				token: String in the chain.
#				line: The line object the token was declared on.
# Throws:
#	JSON objects describing the error encountered.
#		line: The line object describing where the error occurred.
#		reason: String describing the error which occurred.
#			"unexpectedIndentation": Indentation occurred without declaring a
#				function or following a chain expression.
#			"unindentedToUnexpectedLevel": A line was less indented than that
#				which preceded it, but to a level which hasn't been used before
#				now.
#			"functionHasNoOutput": A function was declared, but no output 
#				expression was defined.
#			"temporaryVariableNamesNotUnique": One or more temporary variables
#				share the same name in the same function.
#			"propertyNamesNotUnique": One or more properties share the same
#				share the same name.
#			"unexpectedTokensFollowingFunctionName": More than one token was
#				given as the name of a function.
#			"expectedExpression": A declaration or property was declared
#				without a chain or following set of properties.
# Line objects contain:
#	filename: String name of the source file.
#	line: Integer, zero-based line number.
#	columns:
#		from: Integer, zero based column number of the first character.
#		to: Integer, zero based column number of the character after the last.
# This is to be stored in a workspace object as "functions", alongside:
# 	primitives: An object where the keys are the names of primitive types, and
#		the values are objects describing primitive types:
#			parse: A function taking a string which may or may not be a 
#				primitive literal as its argument.  When it is not, return 
#				undefined.  When it is, return the value.
# 	nativeFunctions: Initially empty array of objects describing functions.
#		name: String identifying the function.
#		compile: Takes a value object and returns a new value object describing 
#			the output if compilation succeeded, else, falsy.
#		output: String identifying the primitive type returned. 
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
					
					haveDeleted = false
					while indentations.length and whitespaces <= indentations[indentations.length - 1].whitespaces
						indentations.length-- 
						haveDeleted = true
						
					if haveDeleted and indentations.length and indentations[indentations.length - 1].whitespaces < whitespaces
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