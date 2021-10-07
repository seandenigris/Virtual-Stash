Extension { #name : #MpPerson }

{ #category : #'*VirtualStash-Core' }
MpPerson >> vsBeUser [
	self propertyAt: #vsIsUser put: true
]

{ #category : #'*VirtualStash-Core' }
MpPerson >> vsCashAccount [
	^ self propertyAt: #vsCashAccount ifAbsent: [ nil ]
]

{ #category : #'*VirtualStash-Core' }
MpPerson >> vsCashAccount: anAccount [
	self propertyAt: #vsCashAccount put: anAccount
]

{ #category : #'*VirtualStash-Core' }
MpPerson >> vsIsUser [
	^ self propertyAt: #vsIsUser ifAbsent: [ false ]
]
