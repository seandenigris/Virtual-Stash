as yet unclassified
testAcceptance

	| input result parentCategory |
	input := 'Automobile	Automobile Expenses
     Car Payment	Automobile Expenses
Automobile (Business)	Business'.
	
	result := VsMsCategoryListParser parse: input.
	result isPetitFailure should beFalse.
	result size should equal: 2.
	parentCategory := result first.
	parentCategory name should equal: 'Automobile'.
	parentCategory group should equal: 'Automobile Expenses'.
	parentCategory children first name should equal: 'Car Payment'.
	parentCategory children first group should equal: 'Automobile Expenses'.
	result second name should equal: 'Automobile (Business)'.
	result second group should equal: 'Business'.