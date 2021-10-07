Class {
	#name : #VsMsCategoryListParserSpecification,
	#superclass : #BabyPhexample,
	#category : 'VirtualStash-MSMoney'
}

{ #category : #'as yet unclassified' }
VsMsCategoryListParserSpecification >> testAcceptance [

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
]

{ #category : #'as yet unclassified' }
VsMsCategoryListParserSpecification >> testChildAccount [

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
]

{ #category : #'as yet unclassified' }
VsMsCategoryListParserSpecification >> testOneAccount [

	| input result |
	input := 'Automobile	Automobile Expenses'.
	result := VsMsCategoryListParser new rootAccount parse: input.
	result isPetitFailure should beFalse.
	result name should equal: 'Automobile'.
	result group should equal: 'Automobile Expenses'.
]
