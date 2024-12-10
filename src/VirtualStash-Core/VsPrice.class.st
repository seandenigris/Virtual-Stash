Class {
	#name : #VsPrice,
	#superclass : #Object,
	#traits : 'DbTDomainObject',
	#classTraits : 'DbTDomainObject classTrait',
	#category : #'VirtualStash-Core-Vendors'
}

{ #category : #utility }
VsPrice class >> search: client new: aClass for: aSearch priority: aNumber [
	
	^ aSearch explicit
		title: 'New ', (aClass name allButFirst: 'Vs' size);
		itemName: #displayString;
		priority: aNumber;
		search: [ :aContext | 
			| input |
			input := aContext searchQuery trimBoth.
			{ aClass named: input } asAsyncStream ];
		send: [ :result | 
			client add: result ]
]

{ #category : #'as yet unclassified' }
VsPrice >> compoundingFormula [
	
	^ AcCompoundingFormula new
		presentValue: self total;
		yourself
]

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
VsPrice >> list [

	^ VsPriceList uniqueInstance
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
VsPrice >> total [

	self subclassResponsibility
]

{ #category : #accessing }
VsPrice >> totalDescription [
	<magritteDescription>
	
	^ MAMoneyDescription vsNew
		accessor: #total;
		priority: 500;
		yourself
]
