Extension { #name : #MADescription }

{ #category : #'*VirtualStash-Core' }
MADescription >> vsColumnWeight [
	^ self propertyAt: #vsColumnWeight ifAbsent: [ 0.2 ]
]
