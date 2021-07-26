accessing
uncategorizedAmount

	| categorizedAmount |
	categorizedAmount := self entries inject: 0 into: [ :sum :e | sum + e amount ].
	^ self amount - categorizedAmount