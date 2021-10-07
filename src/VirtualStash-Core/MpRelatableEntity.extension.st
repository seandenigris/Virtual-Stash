Extension { #name : #MpRelatableEntity }

{ #category : #'*VirtualStash-Core' }
MpRelatableEntity class >> for: receipt [

	^ self all detect: [ :e | e isVendorFor: receipt ] ifNone: [ nil ]
]

{ #category : #'*VirtualStash-Core' }
MpRelatableEntity >> isVendorFor: receipt [

	^ (receipt includesSubstring: self name) or: [ self website ifNotNil: [ :url | receipt includesSubstring: url host ] ifNil: [ false ] ]
]
