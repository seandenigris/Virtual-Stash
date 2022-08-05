Trait {
	#name : #VsTAmexAddress,
	#category : #'VirtualStash-Core-Importing-Amex'
}

{ #category : #accessing }
VsTAmexAddress >> amexCityAndState: aString [
	| lines |
	lines := aString lines.
	self
		city: lines first;
		state: lines second.
]

{ #category : #accessing }
VsTAmexAddress >> amexCityAndStateDescription [
	<magritteDescription>
	^ MAStringDescription new
		priority: 100;
		accessor: #amexCityAndState;
		yourself
]
