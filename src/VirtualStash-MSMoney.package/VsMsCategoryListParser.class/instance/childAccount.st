as yet unclassified
childAccount
	| fieldSeparator categoryName categoryGroup indent |
	indent := #space asParser times: 5.
	fieldSeparator := Character tab asParser.
	categoryName := fieldSeparator negate plus flatten.
	categoryGroup := #newline asParser negate plus flatten.
	^ (indent, categoryName, fieldSeparator, categoryGroup) ==> [ :n | | result |
		result := VsMsCategory new
			name: n second trimBoth;
			group: n fourth trimBoth;
			yourself.
		self currentRootCategory children add: result.
		result ]