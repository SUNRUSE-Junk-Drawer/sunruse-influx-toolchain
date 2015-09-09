This is a library of functions used to compile SUNRUSE.influx source code to expression trees so that it can be assembled to native code.  On requiring "sunruse-influx-toolchain", you will get an object containing the toolchain functions.

# Line objects
Line objects describe the file/line/columns relating to an object.  They contain:

* filename: String name of the source file.
* line: Integer, zero-based line number.
* columns:
	* from: Integer, zero based column number of the first character.
	* to: Integer, zero based column number of the character after the last.

# Value objects
A value object is the SUNRUSE.influx equivalent of an expression tree.  Each is an object containing:

* score: Integer; the score accumulated by following this path.
* properties: When truthy, an object where the keys are the names of properties inside the value, and the values are the value objects held.
* native: When truthy, the value is the result of executing a native function.  An object containing:
	* input: The input to the native function.
	* function: A reference to the native function to be executed.
	
	Other data may be present; used internally by the current platform's compiler.
* primitive: When truthy, the value is a primitive constant.  An object containing:
	* type: String specifying the name of the primitive type.
	* value: The value held.
* parameter: When truthy, the value is a runtime parameter.  An object containing:
	* type: String specifying the name of the primitive type.

# Platforms
Platforms are functions, implemented in external modules, returning objects containing:
* primitives: An object where the keys are the names of primitive types, andthe values are objects describing primitive types:
	* parse: A function taking a string which may or may not be a primitive literal as its argument.  When it is not, return undefined.  When it is, return the value.
	* equal: Takes two values previously returned by parse.  Return truthy when they refer to the same value, else, falsy.
	* assertionPass: When not undefined, a value to be compared with the primitive value returned by an assertion, using the "equal" function.  The assertion will pass when this matches.
* nativeFunctions: Initially empty array of objects describing functions.
	* name: String identifying the function.
	* compile: Takes a value object and returns a new value object describing the output if compilation succeeded, else, falsy.
	* inputsEqual: Takes the platform and two value objects returned by separate calls to compile.  Return truthy when they should compile to the same native call, and falsy when they should not.
	* output: String identifying the primitive type returned. 
* compile: Takes the platform, an input value object, the output value object and returns generated native code.

Typically, the following would be added afterwards:
* functions: The tokenized functions.

# Error handling
When a toolchain function encounters an error, it will throw an object.  This will contain "reason", a string describing the error condition.  If the error can be attributed to a specific line in a specific file, a line object is included under "line".

# Functions

## tokenizer

### Given:
* An object, where the keys are the filenames and the values are their contents as strings.

### Returns:
An array of objects describing the tokenized functions.

* name: String identifying the function.
* declarations: A JSON object where the keys are the names of the declarations, and the values are expression objects.  "output" is the return value, while the others are temporary variables.
* line: The line object the function's name was declared on.
 	
Expressions are objects containing:
* line: The line object the expression was declared on.
* properties: When the expression is a group of sub-expressions, an object where the keys are the names of the properties and the values are expression objects.  Mutually exclusive with "chain".
* chain: When the expression is a value followed by a sequence of function names, an array of objects describing this.  Mutually exclusive with "properties".
	* token: String in the chain.
	* line: The line object the token was declared on.
	
### Throws:
(see Error handling)

* "unexpectedIndentation": Indentation occurred without declaring a function or following a chain expression.
* "unindentedToUnexpectedLevel": A line was less indented than that which preceded it, but to a level which hasn't been used before now.
* "functionHasNoOutput": A function was declared, but no output expression was defined.
* "temporaryVariableNamesNotUnique": One or more temporary variables share the same name in the same function.
* "propertyNamesNotUnique": One or more properties share the same share the same name.
* "unexpectedTokensFollowingFunctionName": More than one token was given as the name of a function.
* "expectedExpression": A declaration or property was declared without a chain or following set of properties.
	
## findFunction

### Given:
* The platform instance.
* The value object to take as an input.
* The name of the function to resolve.
* Optionally, an array of strings.  This will be written to log attempts to match functions.
* When the fourth argument is given, a prefix to prepend onto to log lines generated by child expressions and functions.
* An object used to cache previous results, where keys are the names of the functions compiled, and values are objects.  If you don't have one, pass an empty anonymous object.
	* input: The value object taken as input.
	* output: The value object returned.

### Returns:
* If the value has properties and the function name matches one of those properties:
	* score: 1
	* value: The property named in the value object.
* If no matching function compiled, falsy.
* If functions matched, the value object returned by the highest scoring function, whether native or otherwise.

## compileExpression

### Given:
* The platform instance.
* The input value object.
* An expression object.
* The function containing the expression.
* Optionally, an array of strings.  This will be written to log attempts to match functions.
* When the fourth argument is given, a prefix to prepend onto to log lines generated by child expressions and functions.
* The cache object, as described in "findFunction".

### Returns:

* When the expression does not compile, falsy.
* When the expression compiles, the value object generated is returned.

## getValue

### Given:

* The platform instance.
* The input value object.
* A string containing the starting value of an expression.
* The function containing the expression.
* Optionally, an array of strings.  This will be written to log attempts to match functions.
* When the fourth argument is given, a prefix to prepend onto to log lines generated by child expressions and functions.
* The cache object, as described in "findFunction".

# Returns:

* When the starting value could not be resolved, falsy.
* When the starting value is a primitive literal, a value object containing the primitive.
* When the starting value is "input", the input value object.
* When the starting value is the name of a temporary variable, the result of compileExpression for that temporary variable.

## valueIsPrimitive

### Given:
* A value object.
* The name of a primitive type.

### Returns:
* Truthy when the value object is of the named primitive type.
* Otherwise, falsy.

## valuesEquivalent

### Given:
* The platform instance.
* A value object.
* Another value object.

### Returns:
* Truthy if the value objects are considered the same.
* For properties, this recurses and returns truthy only when every property is considered the same.
* Parameters are compared by reference.
* Native function calls are compared first comparing the functions by reference and then using the "inputsEqual" function against the function.
* Primitive constants are compared by checking the types match and then calling the "equal" function against the primitive.
* Otherwise, falsy.

## walk

### Given:
* A value object.
* A callback taking the found value object as an argument.

Executes the callback for the value object after recursing through every child object:
* Every property of properties objects.
* The input of every native function call.

## runAssertions

### Given:
* The platform instance.

### Returns:
* An array, wherein each item is an object describing an assertion result:
	* resultType: String describing the outcome of the assertion:
		* "failedToCompile"
		* "didNotReturnPrimitiveConstant"
		* "primitiveTypeNotAssertable"
		* "primitiveValueIncorrect"				
		* "successful"
	* assertion: The function from the platform which was attempted to be compiled.
	* output: When truthy, the function compiled, and its output value object is here.
	
This compiles every function named "assert" with an input of an empty properties object.  Each should return a single primitive constant.  If the value is equivalent to the primitive type's "assertionPass" property, the assertion passes.