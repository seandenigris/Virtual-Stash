Extension { #name : #MAMoneyDescription }

{ #category : #'*VirtualStash-Core' }
MAMoneyDescription class >> vsNew [

	^ self new
		stringReader: VsMAMoneyStringReader;
		stringWriter: VsMAMoneyStringWriter;
		kind: Measure;
		yourself
]
