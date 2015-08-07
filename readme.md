SUNRUSE.influx is an experimental pure functional programming language where every program compiles to run in constant time.  It also uses a pattern matching approach inspired by CSS's specificity system wherein the most specific function which compiles wins.  While every program is statically typed once compiled, they are loosely typed at compile-time.

There is only one statement to learn: the function declaration.

	# Begin by naming your function.
	helloWorld
		
		# We can create a temporary variable by naming it and then following it with an expression.
		# An expression starts with a value and then a chain of function names.
		cubeRootOf2 2.0 sqrt sqrt
		
		# You can additionally create objects containing multiple named values, or even nest them.
		parentObj
			# To access this, use "parentObj childObj".
			childObj
				# To access this, use "parentObj childObj val1"
				val1 true
				val2 false
				val3 5
				# You may reference temporary variables as values.
				val4 cubeRootOf2
		
		# To get data from the function input, use "input" as a value.
		tempVar input propertyName
		
		# Finally, define the output for your function.  The syntax is the same as in temporary variables.
		output
			thingOne cubeRootOf2
			thingTwo parentObj childObj val3
			thingThree tempVar
		
When multiple functions exist with the same name, whichever is the most specific which compiles wins:

	# Returns true given:
	#	bounds
	#		left
	#		right
	#		top (positive)
	#		bottom (negative)
	#	point
	#		a
	#		b
	# when the point is within the bounds.
	intersects
		leftPair
			a input bounds left
			b input point a
		rightPair
			a input bounds right
			b input point a
		bottomPair
			a input bounds bottom
			b input point b
		bottomCrossed bottomPair greaterThan
		topPair
			a input bounds top
			b input point b
		topCrossed topPair lessThan
		
		leftRight
			a leftPair greaterThan
			b rightPair lessThan
		topBottom
			a leftPair greaterThan
			b rightPair lessThan	
		total
			a leftRight or
			b topBottom or
		output total or		
	
	# Returns true given:
	#	circle
	#		radius
	#		origin
	#			a
	#			b	
	#	point
	#		a
	#		b
	# when the point is within the circle.
	intersects
		pointOrigin
			a input point
			b input circle origin
		distanceRadius 
			a pointOrigin subtract magnitude
		    b input circle radius
		output
		
The following primitive types exist by default:

| Name    | Literal examples      |
| ------- | --------------------- |
| boolean | true false            |
| int     | 0 -4 7                |
| float   | 0.0 0.4 4.5 -0.7 -7.3 |

The following functions are natively implemented by default:

* add a int, b int -> int
* add a float, b float -> float
* subtract a int, b int -> int
* subtract a float, b float -> float
* multiply a int, b int -> int
* multiply a float, b float -> float
* divide a int, b int -> int
* divide a float, b float -> float
* equal a int, b int -> bool
* equal a float, b float -> bool
* lessThan a int, b int -> bool
* lessThan a float, b float -> bool
* greaterThan a int, b int -> bool
* greaterThan a float, b float -> bool
* greaterThanOrEqual a int, b int -> bool
* greaterThanOrEqual a float, b float -> bool
* not bool -> bool
* or a bool, b bool -> bool
* and a bool, b bool -> bool
* xor a bool, b bool -> bool
* nor a bool, b bool -> bool
* nand a bool, b bool -> bool
* xnor a bool, b bool -> bool
* switch a, b, on bool -> anything