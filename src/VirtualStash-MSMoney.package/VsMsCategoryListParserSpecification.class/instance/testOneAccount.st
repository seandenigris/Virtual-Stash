as yet unclassified
testOneAccount

	| input result |
	input := 'Automobile	Automobile Expenses'.
	result := VsMsCategoryListParser new rootAccount parse: input.
	result isPetitFailure should beFalse.
	result name should equal: 'Automobile'.
	result group should equal: 'Automobile Expenses'.