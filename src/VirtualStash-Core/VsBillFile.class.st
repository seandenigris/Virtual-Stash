Class {
	#name : #VsBillFile,
	#superclass : #Object,
	#instVars : [
		'items'
	],
	#category : #'VirtualStash-Core-Receipts'
}

{ #category : #accessing }
VsBillFile >> itemBaseClass [
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
		default: (SortedCollection sortUsing: #date descending undefinedFirst);
		priority: 100;
		classes: self itemBaseClass withAllSubclasses;
		gtSearchDelegateTo: self resourceLibrary 
			message: #resourcesSearchRecentFor: 
			do: [ :search |
				search
					title: 'New item from recent resource';
					send: [ :resource | 
						| newItem |
						newItem := self itemBaseClass fromResourceable: resource.
						self items add: newItem ] ];
		beReadOnly;
		yourself
]

{ #category : #accessing }
VsBillFile >> itemsGtViewFor: aView [
	<gtView>
	^ (aView
		maColumnedListOf: self itemBaseClass
		descriptionsSelect: [ :desc | desc propertyAt: #isHighlight ifAbsent: [ false ] ])
		title: self itemsTypeLabel translated;
		priority: 10;
		items: [ self items ];
		actionUpdateButton;
		yourself
]

{ #category : #accessing }
VsBillFile >> itemsSearchFor: aSearch [
	<gtSearch>
	
	^ self 
		items: [ self items ] 
		searchTitled: self itemsTypeLabel translated
		priority: 10 
		for: aSearch
]

{ #category : #accessing }
VsBillFile >> itemsSearchNewFor: aSearch [
	<gtSearch>
	
	^ (PeGtDelegatedSearch
		to: self resourceLibrary 
		message: #resourcesSearchRecentFor: 
		configured: [ :search |
			search
				title: 'New item from recent resource';
				send: [ :resource | 
					| newItem |
					newItem := self itemBaseClass fromResourceable: resource.
					self items add: newItem ] ])
		gtSpotterOn: aSearch
]

{ #category : #accessing }
VsBillFile >> itemsTypeLabel [

	^ 'Bills'
]

{ #category : #accessing }
VsBillFile >> resourceLibrary [
	^ RlResourceLibrary uniqueInstance
]
