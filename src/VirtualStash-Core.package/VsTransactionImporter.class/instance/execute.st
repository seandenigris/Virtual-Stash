accessing
execute
	| transactions |
	transactions := super execute.
	self targetCollection ifNotNil: [ :col | col addAll: transactions ].
	^ transactions