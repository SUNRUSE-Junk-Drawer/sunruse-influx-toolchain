valueIsPrimitive = require "./../../../toolchain/valueIsPrimitive"

module.exports = [
		floatAdd =
			name: "add"
			compile: (value) -> 
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "float" then return null
				if not valueIsPrimitive value.properties.b, "float" then return null
				if value.properties.a.primitive and value.properties.b.primitive
					return unused =
						score: value.properties.a.score + value.properties.b.score + 1
						primitive:
							type: "float"
							value: value.properties.a.primitive.value + value.properties.b.primitive.value
				return unused =
					score: value.properties.a.score + value.properties.b.score + 1
					native:
						input: value
						function: floatAdd
			output: "float"
	,
		floatSubtract =
			name: "subtract"
			compile: (value) ->
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "float" then return null
				if not valueIsPrimitive value.properties.b, "float" then return null
				if value.properties.a.primitive and value.properties.b.primitive
					return unused =
						score: value.properties.a.score + value.properties.b.score + 1
						primitive:
							type: "float"
							value: value.properties.a.primitive.value - value.properties.b.primitive.value
				return unused =
					score: value.properties.a.score + value.properties.b.score + 1
					native:
						input: value
						function: floatSubtract
			output: "float"
	,
		floatMultiply =
			name: "multiply"
			compile: (value) ->
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "float" then return null
				if not valueIsPrimitive value.properties.b, "float" then return null
				if value.properties.a.primitive and value.properties.b.primitive
					return unused =
						score: value.properties.a.score + value.properties.b.score + 1
						primitive:
							type: "float"
							value: value.properties.a.primitive.value * value.properties.b.primitive.value
				return unused =
					score: value.properties.a.score + value.properties.b.score + 1
					native:
						input: value
						function: floatMultiply
			output: "float"				
	,
		floatDivide =
			name: "divide"
			compile: (value) ->
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "float" then return null
				if not valueIsPrimitive value.properties.b, "float" then return null
				if value.properties.a.primitive and value.properties.b.primitive
					return unused =
						score: value.properties.a.score + value.properties.b.score + 1
						primitive:
							type: "float"
							value: value.properties.a.primitive.value / value.properties.b.primitive.value
				return unused =
					score: value.properties.a.score + value.properties.b.score + 1
					native:
						input: value
						function: floatDivide
			output: "float"				
	,
		floatNegate =
			name: "negate"
			compile: (value) ->
				if not valueIsPrimitive value, "float" then return null
				if value.primitive
					return unused =
						score: value.score + 1
						primitive:
							type: "float"
							value: -value.primitive.value				
				return unused =
					score: value.score + 1
					native:
						input: value
						function: floatNegate
			output: "float"	
]