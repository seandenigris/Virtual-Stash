Extension { #name : #MpRelatableEntity }

{ #category : #'*VirtualStash-Core' }
MpRelatableEntity >> isVendorFor: aDocument [

	
	| includesName |
	includesName := (aDocument resource vsAnalysisInput includesSubstring: self fullName  caseSensitive: false).
	includesName ifTrue: [ ^ true ].
	
	self website ifNotNil: [ :url | 
		^ aDocument contents includesSubstring: url host ].
	
	^ false
]

{ #category : #'*VirtualStash-Core' }
MpRelatableEntity >> vsIsMentionedIn: aString [

	
	| includesName |
	includesName := aString includesSubstring: self fullName  caseSensitive: false.
	includesName ifTrue: [ ^ true ].
	
	self website ifNotNil: [ :url | 
		^ aString includesSubstring: url host ].
	
	^ false
]
