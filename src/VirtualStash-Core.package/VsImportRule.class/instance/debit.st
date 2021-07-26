accessing-convenience
debit
	| result |
	result := self transaction splits select: #isDebit.
	result size = 1 ifFalse: [ self error: 'Rules assume only one credit and one debit' ].
	^ result first