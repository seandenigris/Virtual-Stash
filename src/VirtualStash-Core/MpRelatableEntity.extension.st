Extension { #name : #MpRelatableEntity }

{ #category : #'*VirtualStash-Core' }
MpRelatableEntity >> isVendorFor: aDocument [

	
	| includesName |
	includesName := (aDocument contents includesSubstring: self fullName  caseSensitive: false).
	includesName ifTrue: [ ^ true ].
	
	self website ifNotNil: [ :url | 
		^ aDocument contents includesSubstring: url host ].
	
	^ false
]
