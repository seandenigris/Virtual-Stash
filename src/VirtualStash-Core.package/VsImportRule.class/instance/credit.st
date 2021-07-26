accessing-convenience
credit
	| result |
	result := self transaction splits select: #isCredit.
	result size = 1 ifFalse: [ self error: 'Rules assume only one credit and one debit' ].
	^ result first