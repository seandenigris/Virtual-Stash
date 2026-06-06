Extension { #name : 'Number' }

{ #category : '*VirtualStash-Core' }
Number >> dollar [

	^ self dollars
]

{ #category : '*VirtualStash-Core' }
Number >> dollars [

	^ VsUnits
		quantity: self
		of: #dollar
]
