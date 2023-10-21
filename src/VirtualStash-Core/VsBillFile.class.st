Class {
	#name : #VsBillFile,
	#superclass : #Object,
	#instVars : [
		'items'
	],
	#category : #'VirtualStash-Core-Receipts'
}

{ #category : #accessing }
VsBillFile >> itemClass [
	^ VsBill
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
VsBillFile >> items: aBlock searchTitled: aString priority: aNumber for: aSearch [
	
	self flag: 'waiting for streaming Spotter to support #matchSubstrings'.
	^ aSearch list
		priority: aNumber;
		title: aString;
		items: aBlock;
		filterBySubstring
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

{ #category : #accessing }
VsBillFile >> itemsGtViewFor: aView [
	<gtView>
	^ (aView
		maColumnedListOf: self itemClass
		descriptionsSelect: [ :desc | desc propertyAt: #isHighlight ifAbsent: [ false ] ])
		title: 'Bills' translated;
		priority: 10;
		items: [ self items ];
		yourself
]

{ #category : #accessing }
VsBillFile >> itemsSearchFor: aSearch [
	<gtSearch>
	
	^ self 
		items: [ self items ] 
		searchTitled: 'Items' 
		priority: 10 
		for: aSearch
]
