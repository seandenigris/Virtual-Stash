Class {
	#name : #VsPrice,
	#superclass : #Object,
	#category : #'VirtualStash-Core-Vendors'
}

{ #category : #accessing }
VsPrice >> dateDescription [
	<magritteDescription>
	
	^ MADateDescription new
		accessor: #date;
		priority: 100;
		beRequired;
		yourself
]

{ #category : #accessing }
VsPrice >> displayStringOn: aStream [

	self name ifNotNil: [ :n | aStream << n ].
	aStream 
		nextPutAll: ' @ ';
		display: self total
]

{ #category : #accessing }
VsPrice >> nameDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #name;
		yourself
]

{ #category : #accessing }
VsPrice >> printOn: aStream [

	self printFromDisplayStringOn: aStream
]

{ #category : #accessing }
VsPrice >> totalDescription [
	<magritteDescription>
	
	^ MAMoneyDescription new
		accessor: #total;
		priority: 500;
		beRequired;
		stringReader: VsMAMoneyStringReader;
		yourself
]
