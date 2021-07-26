accessing
save

	| newName message party |
	newName := matchList selectedIndices 
		ifEmpty: [ editorInputElement text asString ]
		ifNotEmpty: [ 
			| colItem |
			colItem := matchList items at: matchList selectedIndices first.
			colItem first ].
	party := MpAddressBook default ensureOrganizationNamed: newName.
	self transactionGroup counterparty: party.
	
	self paymentProcessor ifNotNil: [ :p | self transactionGroup paymentProcessor: p ].
	
	(self inputString = newName or: [ party aliases includes: self inputString ]) ifTrue: [ ^ self ].
	party aliases add: self inputString.