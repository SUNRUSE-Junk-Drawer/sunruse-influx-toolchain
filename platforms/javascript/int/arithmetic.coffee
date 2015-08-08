valueIsPrimitive = require "./../../../toolchain/valueIsPrimitive"

module.exports = [
		intAdd =
			name: "add"
			compile: (value) -> 
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "int" then return null
				if not valueIsPrimitive value.properties.b, "int" then return null
				if value.properties.a.primitive and value.properties.b.primitive
					return unused =
						score: value.properties.a.score + value.properties.b.score + 1
						primitive:
							type: "int"
							value: value.properties.a.primitive.value + value.properties.b.primitive.value
				return unused =
					score: value.properties.a.score + value.properties.b.score + 1
					native:
						input: value
						function: intAdd
			output: "int"
	,
		intSubtract =
			name: "subtract"
			compile: (value) ->
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "int" then return null
				if not valueIsPrimitive value.properties.b, "int" then return null
				if value.properties.a.primitive and value.properties.b.primitive
					return unused =
						score: value.properties.a.score + value.properties.b.score + 1
						primitive:
							type: "int"
							value: value.properties.a.primitive.value - value.properties.b.primitive.value
				return unused =
					score: value.properties.a.score + value.properties.b.score + 1
					native:
						input: value
						function: intSubtract
			output: "int"
	,
		intMultiply =
			name: "multiply"
			compile: (value) ->
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "int" then return null
				if not valueIsPrimitive value.properties.b, "int" then return null
				if value.properties.a.primitive and value.properties.b.primitive
					return unused =
						score: value.properties.a.score + value.properties.b.score + 1
						primitive:
							type: "int"
							value: value.properties.a.primitive.value * value.properties.b.primitive.value
				return unused =
					score: value.properties.a.score + value.properties.b.score + 1
					native:
						input: value
						function: intMultiply
			output: "int"				
	,
		intDivide =
			name: "divide"
			compile: (value) ->
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "int" then return null
				if not valueIsPrimitive value.properties.b, "int" then return null
				if value.properties.a.primitive and value.properties.b.primitive
					return unused =
						score: value.properties.a.score + value.properties.b.score + 1
						primitive:
							type: "int"
							value: Math.floor(value.properties.a.primitive.value / value.properties.b.primitive.value)
				return unused =
					score: value.properties.a.score + value.properties.b.score + 1
					native:
						input: value
						function: intDivide
			output: "int"				
	,
		intNegate =
			name: "negate"
			compile: (value) ->
				if not valueIsPrimitive value, "int" then return null
				if value.primitive
					return unused =
						score: value.score + 1
						primitive:
							type: "int"
							value: -value.primitive.value				
				return unused =
					score: value.score + 1
					native:
						input: value
						function: intNegate
			output: "int"	
]