Class {
	#name : 'VsTransactionBatchEdit',
	#superclass : 'Object',
	#instVars : [
		'accountNew',
		'counterparty',
		'accountOld',
		'projects',
		'journal',
		'agreement'
	],
	#category : 'VirtualStash-Core-Bookkeeping',
	#package : 'VirtualStash-Core',
	#tag : 'Bookkeeping'
}

{ #category : 'accessing' }
VsTransactionBatchEdit >> accountNew [

  ^ accountNew
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> accountNew: anObject [

  accountNew := anObject
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> accountNewDescription [
	<magritteDescription>
	
	^ self splitsFirst accountDescription
		label: 'New account'; 
		accessor: #accountNew;
		yourself
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> accountOld [

  ^ accountOld
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> accountOld: anObject [

  accountOld := anObject
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> accountOldDescription [
	<magritteDescription>
	
	^ self splitsFirst accountDescription
		accessor: #accountOld;
		label: 'Old account'; 
		yourself
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> accountSource [

  ^ self books
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> agreement [

  ^ agreement
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> agreement: anObject [

  agreement := anObject
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> agreementDescription [
	<magritteDescription>
	
	^ self splitsFirst agreementDescription
		gtSearchSource: (MessageSend
			receiver: self splitsFirst
			selector: #agreementSource);
		yourself
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> books [
	
	^ self splitsFirst accountSource
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> chartOfAccounts [
	
	^ self books chartOfAccounts
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> counterparty [

  ^ counterparty
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> counterparty: anObject [

  counterparty := anObject
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> counterpartyDescription [
	<magritteDescription>
	
	^ VsTransaction magritteTemplate counterpartyDescription
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> displayStringOn: aStream [

	aStream
		nextPutAll: '[';
		print: self journal entries size;
		nextPutAll: ' transactions]'
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> execute [

	self journal  iterator 
		| [ :aTransaction | self updateTransaction: aTransaction ] doIt 
		> NullAddableObject
]

{ #category : 'views' }
VsTransactionBatchEdit >> gtJournalFor: aView [
  <gtView>
  
  ^ aView forward
      title: 'Transactions';
      priority: 1;
      object: [ self journal ];
      view: #entriesGtViewOn:
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> journal [

  ^ journal
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> journal: anObject [

  journal := anObject
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> maExecutingFormFor: aView [
	<gtView>

	| description |
	
	"Cache the description because this can be expensive and we want the view to be fast not to break the debugging workflow"
	description := self magritteDescription.
	
	(description isContainer not or: [ description isEmpty ]) ifTrue: [ ^ aView empty ].
	
	^ aView explicit
		title: 'Magritte';
		priority: 25;
		stencil: [ self magritteFormExecuting ]
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> magritteFormExecuting [

	| builder |
	builder := self magritteDescription elementBuilderFor: self.
	builder addButtons: #(execute).
	^ builder element
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> mementoClass [

	^ MAStraightMemento
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> printOn: aStream [

	self printFromDisplayStringOn: aStream
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> projectList [

	^ PpProjectList uniqueInstance
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> projects [

  ^ self maLazyInstVarUsing: self projectsDescription
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> projects: anObject [

  projects := anObject
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> projectsDescription [
	<magritteDescription>

	^ MAToManyRelationDescription new
		accessor: #projects;
		gtSearchSource: [ self projectList ];
		default: OrderedCollection new;
		classes: PpValue withAllSubclasses;
		yourself.
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> splitsFirst [
	
	^ self journal entries first splits first
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> updateTransaction: aTransaction [ 
	
	self accountNew ifNotNil: [ 
		aTransaction splits 
			detect: [ :aSplit | aSplit account = self accountOld ]
			ifFound: [ :aSplit | aSplit account: self accountNew ] ].
	
	self agreement ifNotNil: [ aTransaction agreement: self agreement ].
	
	self counterparty ifNotNil: [ aTransaction counterparty: self counterparty ].
	
	self projects ifNotEmpty: [ aTransaction ppValues: self projects ].
]
