accessing
magritteDescription
	| desc field acc |
	self flag: 'do we need #descriptionContainer?'.
	desc := self transactions first magritteDescription
		blocClass: MACompositeElementBuilder;
		yourself.
	field := #transactions.
	desc children do: [ :e | MACompositeAccessor via: field using: e ].
	^ desc