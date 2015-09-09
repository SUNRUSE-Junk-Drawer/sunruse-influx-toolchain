describe "index", ->
	index = undefined
	beforeEach ->
		index = require "./index"
	describe "imports", ->
		it "compileExpression", ->
			expect(index.compileExpression).toBe require "./compileExpression"
		it "findFunction", ->
			expect(index.findFunction).toBe require "./findFunction"
		it "getValue", ->
			expect(index.getValue).toBe require "./getValue"
		it "runAssertions", ->
			expect(index.runAssertions).toBe require "./runAssertions"
		it "tokenizer", ->
			expect(index.tokenizer).toBe require "./tokenizer"
		it "valueIsPrimitive", ->
			expect(index.valueIsPrimitive).toBe require "./valueIsPrimitive"
		it "valuesEquivalent", ->
			expect(index.valuesEquivalent).toBe require "./valuesEquivalent"
		it "walk", ->
			expect(index.walk).toBe require "./walk"