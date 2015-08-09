valueIsPrimitive = require "./../../../toolchain/valueIsPrimitive"

module.exports = [
		boolNot =
			name: "not"
			compile: (value) ->
				if not valueIsPrimitive value, "bool" then return null
				if value.primitive
					return unused =
						score: value.score + 1
						primitive:
							type: "bool"
							value: !value.primitive.value
				return unused =
					score: value.score + 1
					native:
						input: value
						function: boolNot
			output: "bool"															
	,
		boolAnd =
			name: "and"
			compile: (value) ->
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "bool" then return null
				if not valueIsPrimitive value.properties.b, "bool" then return null
				if value.properties.a.primitive and value.properties.b.primitive
					return unused =
						score: value.properties.a.score + value.properties.b.score + 1
						primitive:
							type: "bool"
							value: value.properties.a.primitive.value and value.properties.b.primitive.value
				return unused =
					score: value.properties.a.score + value.properties.b.score + 1
					native:
						input: value
						function: boolAnd
			output: "bool"													
	,
		boolOr =
			name: "or"
			compile: (value) ->
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "bool" then return null
				if not valueIsPrimitive value.properties.b, "bool" then return null
				if value.properties.a.primitive and value.properties.b.primitive
					return unused =
						score: value.properties.a.score + value.properties.b.score + 1
						primitive:
							type: "bool"
							value: value.properties.a.primitive.value or value.properties.b.primitive.value
				return unused =
					score: value.properties.a.score + value.properties.b.score + 1
					native:
						input: value
						function: boolOr
			output: "bool"														
	,
		boolXor =
			name: "xor"
			compile: (value) ->
				if not value.properties then return null
				if not valueIsPrimitive value.properties.a, "bool" then return null
				if not valueIsPrimitive value.properties.b, "bool" then return null
				if value.properties.a.primitive and value.properties.b.primitive
					return unused =
						score: value.properties.a.score + value.properties.b.score + 1
						primitive:
							type: "bool"
							value: (value.properties.a.primitive.value or value.properties.b.primitive.value) and not (value.properties.a.primitive.value and value.properties.b.primitive.value)
				return unused =
					score: value.properties.a.score + value.properties.b.score + 1
					native:
						input: value
						function: boolXor
			output: "bool"														
]