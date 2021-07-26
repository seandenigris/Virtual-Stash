accessing
nonReceipts

	^ nonReceipts ifNil: [ nonReceipts := OrderedCollection new ].