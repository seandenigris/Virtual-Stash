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

	self agreements add: aVsAgreement
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
  
  agreements ifNil: [ ^ aView empty ].
  
  ^ (aView maColumnedListOf: VsAgreement)
      title: 'Agreements';
      items: [ self agreements ];
      actionUpdateButton
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
