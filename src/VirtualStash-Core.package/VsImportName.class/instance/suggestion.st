accessing
suggestion
	^ self 
		ruleIfFound: [ :r | r partyName ]
		ifNone: [ self counterpartyName pyAsTitleCase ]