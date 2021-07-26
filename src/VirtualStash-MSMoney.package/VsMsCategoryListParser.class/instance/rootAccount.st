as yet unclassified
rootAccount
	| fieldSeparator categoryName categoryGroup |
	fieldSeparator := Character tab asParser.
	categoryName := fieldSeparator negate plus flatten.
	categoryGroup := #newline asParser negate plus flatten.
	^ (categoryName, fieldSeparator, categoryGroup) ==> [ :n |
		| result |
		result := VsMsCategory new
			name: n first trimBoth;
			group: n third trimBoth;
			yourself.
		self currentRootCategory: result.
		result ]