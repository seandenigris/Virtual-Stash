Extension { #name : #Object }

{ #category : #'*VirtualStash-Core' }
Object >> addTalent: aTrait during: aBlock [
	self addTalent: aTrait.
	^ [ aBlock cull: self ] ensure: [ self removeTalent: aTrait ].
]

{ #category : #'*VirtualStash-Core' }
Object >> maToString: aDescription [
	^ aDescription toString: (aDescription accessor read: self)
]
