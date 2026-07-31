Class {
	#name : 'VsAgreementFile',
	#superclass : 'Object',
	#instVars : [
		'agreements'
	],
	#classVars : [
		'UniqueInstance'
	],
	#category : 'VirtualStash-Core-Agreements',
	#package : 'VirtualStash-Core',
	#tag : 'Agreements'
}

{ #category : 'persistence' }
VsAgreementFile class >> restoreFrom: anObject [
	
	UniqueInstance := anObject
]

{ #category : 'persistence' }
VsAgreementFile class >> spData [
	
	^ UniqueInstance
]

{ #category : 'accessing' }
VsAgreementFile class >> uniqueInstance [

  ^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : 'accessing' }
VsAgreementFile class >> uniqueInstance: anObject [

  UniqueInstance := anObject
]

{ #category : 'as yet unclassified' }
VsAgreementFile >> add: aVsAgreement [ 

	^ self agreements add: aVsAgreement
]

{ #category : 'accessing' }
VsAgreementFile >> agreements [

  ^ agreements ifNil: [ agreements := OrderedCollection new ]
]

{ #category : 'accessing' }
VsAgreementFile >> agreements: anObject [

  agreements := anObject
]

{ #category : 'views' }
VsAgreementFile >> agreementsGtSearchFor: aSearch [
  <gtSearch>
  
  ^ aSearch list
		title: 'Agreements';
		priority: 30;
		items: [ self agreements ];
		"itemName: #path;
		sendCategory: [ :aCategory :aStep :thisSearch | aCategory items contents asWebLinkGroup ];"
		filterBySubstring
]

{ #category : 'views' }
VsAgreementFile >> agreementsGtViewFor: aView [
	<gtView>

	| result agreementDescriptions currentTermDescriptions |
	agreements ifNil: [ ^ aView empty ].

	result := aView columnedList
		title: 'Agreements';
		items: [ self agreements ];
		actionUpdateButton.

	agreementDescriptions :=
		VsAgreement magritteTemplate magritteDescription
			reject: [ :description |
				#(terms) includes: description accessor selector ].

	currentTermDescriptions :=
		VsAgreementTerm magritteTemplate magritteDescription
			collect: [ :description |
				description copy
					label: description label;
					accessor: {
						#termsCurrent.
						description accessor };
					beReadOnly;
					yourself ].

	agreementDescriptions do: [ :description |
		description gtAddColumnTo: result ].

	currentTermDescriptions do: [ :description |
		description gtAddColumnTo: result ].

	^ result
]

{ #category : 'as yet unclassified' }
VsAgreementFile >> transactions [

  ^ VsBooks personal generalJournal iterator
    | [ :t | t agreements anySatisfy: [ :anAgreement | self agreements includes: anAgreement ] ] selectIt
    > VsGeneralJournal
]

{ #category : 'GT Views' }
VsAgreementFile >> transactionsGtViewFor: aView [
  <gtView>
  
  self transactions entries ifEmpty: [ ^ aView empty ].
  
  ^ aView forward
      title: 'Transactions';
      object: [ self transactions ];
      view: #entriesGtViewOn:;
      inspectButtonFor: [ self transactions ]
]
