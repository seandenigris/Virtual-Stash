Class {
	#name : #VsAccountImporter,
	#superclass : #MACSVTwoStageImporter,
	#category : 'VirtualStash-Core'
}

{ #category : #accessing }
VsAccountImporter >> convertToDomainObjects: aCollectionOfDictionaries [
	| result |
	result := aCollectionOfDictionaries collect: [ :e | 
		| account |
		account := self newAccountForRecord: e.
		self initializeDomainObject: account fromRecord: e.
		account ].
		
	"This is done at the end because we can't set the parents until we create all the account objects"
	self fixParentsOf: result.
	^ result
]

{ #category : #accessing }
VsAccountImporter >> fixParentsOf: aCollection [
	aCollection do: [ :e |
		e parent ifNotNil: [
			| parent |
			parent := aCollection detect: [ :candidate | candidate gnuCashAccountFullName = e parent ].
			e parent: parent ] ]
]

{ #category : #accessing }
VsAccountImporter >> newAccountForRecord: aDictionary [
	| cls |
	cls := self recordClass allSubclasses detect: [ :scls | scls gnuCashType = (aDictionary at: #type) ].
	^ cls new
]
