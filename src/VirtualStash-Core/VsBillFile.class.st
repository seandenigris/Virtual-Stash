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
	
	^ aView list
		title: 'Bills';
		priority: 35;
		items: [ self items ]
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
