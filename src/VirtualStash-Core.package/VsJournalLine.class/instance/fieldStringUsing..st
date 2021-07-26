accessing
fieldStringUsing: aDescription
	^ (self model magritteDescription includes: aDescription)
		ifTrue: [ aDescription toString: (aDescription read: self model) ]
		ifFalse: [ '' ]