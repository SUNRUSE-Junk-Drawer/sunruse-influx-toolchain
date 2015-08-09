valueIsPrimitive = require "./../../../toolchain/valueIsPrimitive"

module.exports = [
		floatEqual =
			name: "equal"
			compile: (value) ->
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "float" then return null
				if not valueIsPrimitive value.properties.b, "float" then return null
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
						function: floatEqual
			output: "bool"								
	,
		floatLess =
			name: "less"
			compile: (value) ->
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "float" then return null
				if not valueIsPrimitive value.properties.b, "float" then return null
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
						function: floatLess
			output: "bool"												
	,
		floatGreater =
			name: "greater"
			compile: (value) ->
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "float" then return null
				if not valueIsPrimitive value.properties.b, "float" then return null
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
						function: floatGreater
			output: "bool"												
	,
		floatLessOrEqual =
			name: "lessOrEqual"
			compile: (value) ->
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "float" then return null
				if not valueIsPrimitive value.properties.b, "float" then return null
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
						function: floatLessOrEqual
			output: "bool"												
	,
		floatGreaterOrEqual =
			name: "greaterOrEqual"
			compile: (value) ->
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "float" then return null
				if not valueIsPrimitive value.properties.b, "float" then return null
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
						function: floatGreaterOrEqual
			output: "bool"																
]
