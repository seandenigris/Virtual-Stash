as yet unclassified
testChildAccount

	| input result parser parent |
	input := '     Car Payment	Automobile Expenses'.
	parent := VsMsCategory new name: 'Automobile'; yourself.
	parser := VsMsCategoryListParser new
		currentRootCategory: parent;
		yourself.
	result := parser childAccount parse: input.
	result isPetitFailure should beFalse.
	result name should equal: 'Car Payment'.
	result group should equal: 'Automobile Expenses'.
	(parent children includes: result) should beTrue