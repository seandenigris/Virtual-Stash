Class {
	#name : #VsMAMoneyDescription,
	#superclass : #MAMoneyDescription,
	#category : #'VirtualStash-Core'
}

{ #category : #initialization }
VsMAMoneyDescription >> initialize [

	super initialize.
	self
		stringReader: VsMAMoneyStringReader;
		stringWriter: VsMAMoneyStringWriter.
]

{ #category : #accessing }
VsMAMoneyDescription >> stringReaderClass [

	^ VsMAMoneyStringReader
]

{ #category : #accessing }
VsMAMoneyDescription >> stringWriterClass [

	^ VsMAMoneyStringWriter
]
