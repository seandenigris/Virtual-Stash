Class {
	#name : #VsBillFile,
	#superclass : #Object,
	#instVars : [
		'items'
	],
	#category : #'VirtualStash-Core-Receipts'
}

{ #category : #accessing }
VsBillFile >> gtViewItemsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Bills' translated;
		priority: 10;
		items: [ self items ];
		column: 'Date' translated text: [ :e | e maToString: e dateDescription ];
		column: 'Vendor' translated text: [ :e | e maToString: e counterpartyDescription ];
		column: 'Total' translated text: [ :e | e maToString: e amountDescription ];
		yourself
]

{ #category : #accessing }
VsBillFile >> items [

	^ self maLazyInstVarUsing: self itemsDescription
]

{ #category : #accessing }
VsBillFile >> items: anObject [

	items := anObject
]

{ #category : #accessing }
VsBillFile >> itemsDescription [
	<magritteDescription>

	^ MAToManyRelationDescription new
		accessor: #items;
		classes: VsBill withAllSubclasses;
		default: (SortedCollection sortUsing: #date descending undefinedFirst);
		priority: 100;
		beRequired;
		beReadOnly;
		yourself
]
