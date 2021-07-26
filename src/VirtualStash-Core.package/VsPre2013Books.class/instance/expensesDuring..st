personal expenses
expensesDuring: aTimeSpan

	| unsorted |
	unsorted := self expenses select: [ :e | aTimeSpan includes: e date ].
	^ unsorted sort: [ :a :b | a date < b date ].