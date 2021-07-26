accessing
oldReceipts
	^ oldReceipts ifNil: [ oldReceipts := OrderedCollection new ]