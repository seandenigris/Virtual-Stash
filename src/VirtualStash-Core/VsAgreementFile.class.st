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
VsAgreementFile >> agreementsGtViewFor: aView [
  <gtView>
  
  agreements ifNil: [ ^ aView empty ].
  
  ^ (aView maColumnedListOf: VsAgreement)
      title: 'Agreements';
      items: [ self agreements ];
      actionUpdateButton
]
