Class {
	#name : #VsMsCategoryListParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'rootAccount',
		'childAccount',
		'currentRootCategory',
		'rootCategories'
	],
	#category : 'VirtualStash-MSMoney'
}

{ #category : #'as yet unclassified' }
VsMsCategoryListParser class >> ignoredNames [
	^ super ignoredNames, { #currentRootCategory. #rootCategories }
]

{ #category : #'as yet unclassified' }
VsMsCategoryListParser class >> parse: file [

	^ super parse: file contents.
]

{ #category : #'as yet unclassified' }
VsMsCategoryListParser >> childAccount [
	| fieldSeparator categoryName categoryGroup indent |
	indent := #space asParser times: 5.
	fieldSeparator := Character tab asParser.
	categoryName := fieldSeparator negate plus flatten.
	categoryGroup := #newline asParser negate plus flatten.
	^ (indent, categoryName, fieldSeparator, categoryGroup) ==> [ :n | | result |
		result := VsMsCategory new
			name: n second trimBoth;
			group: n fourth trimBoth;
			yourself.
		self currentRootCategory children add: result.
		result ]
]

{ #category : #accessing }
VsMsCategoryListParser >> currentRootCategory [
	^ currentRootCategory
]

{ #category : #accessing }
VsMsCategoryListParser >> currentRootCategory: anObject [
	self rootCategories add: anObject.
	currentRootCategory := anObject
]

{ #category : #'as yet unclassified' }
VsMsCategoryListParser >> rootAccount [
	| fieldSeparator categoryName categoryGroup |
	fieldSeparator := Character tab asParser.
	categoryName := fieldSeparator negate plus flatten.
	categoryGroup := #newline asParser negate plus flatten.
	^ (categoryName, fieldSeparator, categoryGroup) ==> [ :n |
		| result |
		result := VsMsCategory new
			name: n first trimBoth;
			group: n third trimBoth;
			yourself.
		self currentRootCategory: result.
		result ]
]

{ #category : #accessing }
VsMsCategoryListParser >> rootCategories [
	^ rootCategories ifNil: [ rootCategories := OrderedCollection new ]
]

{ #category : #'as yet unclassified' }
VsMsCategoryListParser >> start [

	| branch |
	branch := rootAccount, (#newline asParser, childAccount plus) star.
	^ (branch separatedBy: #newline asParser) end ==> [ :n | self rootCategories ]
]
