Class {
	#name : #VsAccountBalance,
	#superclass : #Object,
	#instVars : [
		'account',
		'balance'
	],
	#category : 'VirtualStash'
}

{ #category : #'as yet unclassified' }
VsAccountBalance class >> of: accnt is: aNumber [

	^ self new
			account: accnt;
			balance: aNumber;
			yourself.
]

{ #category : #private }
VsAccountBalance >> account: accnt [

	account := accnt.
]

{ #category : #private }
VsAccountBalance >> accountName [

	^ account.
]

{ #category : #private }
VsAccountBalance >> balance [

	^ balance.
]

{ #category : #private }
VsAccountBalance >> balance: aNumber [

	balance := aNumber.
]
