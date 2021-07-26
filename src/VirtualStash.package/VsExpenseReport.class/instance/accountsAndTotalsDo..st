as yet unclassified
accountsAndTotalsDo: aBlock

	| accountsWithActivity |
	accountsWithActivity := (self expenses collect: [ :e | e category ]) asSet.
	accountsWithActivity do: [ :a | | expensesForAccount total |
		expensesForAccount := self expenses select: [ :e | e category = a ].
		total := expensesForAccount inject: 0 into: [ :s :exp | s + exp amount ].
		aBlock value: a value: total ].