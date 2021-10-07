Class {
	#name : #VsMsCategory,
	#superclass : #Object,
	#instVars : [
		'name',
		'group',
		'children'
	],
	#category : 'VirtualStash-MSMoney'
}

{ #category : #'as yet unclassified' }
VsMsCategory class >> convertToAccounts: file [
	"VsMsCategory convertToAccounts: VirtualStashDB backupDirectoryParent / 'MS Money' / 'expense categories.txt'."
	| rootCategories |
	rootCategories := VsMsCategoryListParser parse: file.
	^ rootCategories
			collect: [ :cat | 
				| children |
				children := cat children
					collect: [ :chld | 
						VsAccount new
							name: chld name;
							yourself ].
				VsAccount new
					name: cat name;
					children: children;
					yourself ]
]

{ #category : #accessing }
VsMsCategory >> children [
	^ children ifNil: [ children := OrderedCollection new ]
]

{ #category : #accessing }
VsMsCategory >> children: anObject [
	children := anObject
]

{ #category : #magritte }
VsMsCategory >> descriptionChildren [
	<magritteDescription>
	<gtInspectorPresentationOrder: 10>
	^ MAToManyRelationDescription new
			accessor: #children;
			label: 'Children';
			glmPresentation: #list;
			yourself
]

{ #category : #accessing }
VsMsCategory >> group [
	^ group
]

{ #category : #accessing }
VsMsCategory >> group: anObject [
	group := anObject
]

{ #category : #accessing }
VsMsCategory >> name [
	^ name
]

{ #category : #accessing }
VsMsCategory >> name: anObject [
	name := anObject
]

{ #category : #printing }
VsMsCategory >> printOn: aStream [
	aStream
		nextPutAll: self name;
		nextPutAll: ' Category'
]
