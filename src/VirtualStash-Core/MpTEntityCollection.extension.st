Extension { #name : #MpTEntityCollection }

{ #category : #'*VirtualStash-Core' }
MpTEntityCollection >> vsUsers [
	| result |
	result := self people select: [ :e | e vsIsUser ].
	result size > 1 ifTrue: [ self error: 'we do not support multi-user yet' ].
	^ result
]
