module.exports = {}
module.exports[submodule] = require "./" + submodule for submodule in [
	"compileExpression"
	"findFunction"
	"getValue"
	"runAssertions"
	"tokenizer"
	"valueIsPrimitive"
	"valuesEquivalent"
	"walk"
]