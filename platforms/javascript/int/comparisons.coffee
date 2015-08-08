valueIsPrimitive = require "./../../../toolchain/valueIsPrimitive"

module.exports = [
		intEqual =
			name: "equal"
			compile: (value) ->
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "int" then return null
				if not valueIsPrimitive value.properties.b, "int" then return null
				if value.properties.a.primitive and value.properties.b.primitive
					return unused =
						score: value.properties.a.score + value.properties.b.score + 1
						primitive:
							type: "bool"
							value: value.properties.a.primitive.value == value.properties.b.primitive.value
				return unused =
					score: value.properties.a.score + value.properties.b.score + 1
					native:
						input: value
						function: intEqual
			output: "bool"								
	,
		intLess =
			name: "less"
			compile: (value) ->
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "int" then return null
				if not valueIsPrimitive value.properties.b, "int" then return null
				if value.properties.a.primitive and value.properties.b.primitive
					return unused =
						score: value.properties.a.score + value.properties.b.score + 1
						primitive:
							type: "bool"
							value: value.properties.a.primitive.value < value.properties.b.primitive.value
				return unused =
					score: value.properties.a.score + value.properties.b.score + 1
					native:
						input: value
						function: intLess
			output: "bool"												
	,
		intGreater =
			name: "greater"
			compile: (value) ->
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "int" then return null
				if not valueIsPrimitive value.properties.b, "int" then return null
				if value.properties.a.primitive and value.properties.b.primitive
					return unused =
						score: value.properties.a.score + value.properties.b.score + 1
						primitive:
							type: "bool"
							value: value.properties.a.primitive.value > value.properties.b.primitive.value
				return unused =
					score: value.properties.a.score + value.properties.b.score + 1
					native:
						input: value
						function: intGreater
			output: "bool"												
	,
		intLessOrEqual =
			name: "lessOrEqual"
			compile: (value) ->
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "int" then return null
				if not valueIsPrimitive value.properties.b, "int" then return null
				if value.properties.a.primitive and value.properties.b.primitive
					return unused =
						score: value.properties.a.score + value.properties.b.score + 1
						primitive:
							type: "bool"
							value: value.properties.a.primitive.value <= value.properties.b.primitive.value
				return unused =
					score: value.properties.a.score + value.properties.b.score + 1
					native:
						input: value
						function: intLessOrEqual
			output: "bool"												
	,
		intGreaterOrEqual =
			name: "greaterOrEqual"
			compile: (value) ->
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "int" then return null
				if not valueIsPrimitive value.properties.b, "int" then return null
				if value.properties.a.primitive and value.properties.b.primitive
					return unused =
						score: value.properties.a.score + value.properties.b.score + 1
						primitive:
							type: "bool"
							value: value.properties.a.primitive.value >= value.properties.b.primitive.value
				return unused =
					score: value.properties.a.score + value.properties.b.score + 1
					native:
						input: value
						function: intGreaterOrEqual
			output: "bool"																
]
