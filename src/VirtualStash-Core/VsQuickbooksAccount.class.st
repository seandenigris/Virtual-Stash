Class {
	#name : #VsQuickbooksAccount,
	#superclass : #Object,
	#instVars : [
		'name',
		'type',
		'balance'
	],
	#category : 'VirtualStash-Core-QuickBooks'
}

{ #category : #'as yet unclassified' }
VsQuickbooksAccount class >> all [

	^ VsQuickbooksAccountList new allAccounts.
]

{ #category : #private }
VsQuickbooksAccount >> balance [
	self shouldBeImplemented.
]

{ #category : #private }
VsQuickbooksAccount >> balance: anInteger [ 

	balance := anInteger.
]

{ #category : #private }
VsQuickbooksAccount >> ignore: aString [ 

]

{ #category : #private }
VsQuickbooksAccount >> name [

	^ name.
]

{ #category : #private }
VsQuickbooksAccount >> name: aString [ 

	name := aString.
]

{ #category : #'as yet unclassified' }
VsQuickbooksAccount >> printOn: aStream [

	aStream
		nextPutAll: name;
		nextPutAll: ' (';
		nextPutAll: type description;
		nextPutAll: ') ';
		nextPutAll: balance asString.
]

{ #category : #accessing }
VsQuickbooksAccount >> type [

	^ type.
]

{ #category : #private }
VsQuickbooksAccount >> type: typeClass [

	 type := typeClass.
]
