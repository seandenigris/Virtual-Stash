accessing
applyAliasTo: party
	self alias isEmptyOrNil ifTrue: [ ^ self ].
	(party aliases includes: self alias) ifTrue: [ ^ self ].
	
	party aliases add: self alias