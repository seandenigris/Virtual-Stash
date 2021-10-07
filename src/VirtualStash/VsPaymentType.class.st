Class {
	#name : #VsPaymentType,
	#superclass : #Object,
	#classInstVars : [
		'wallet'
	],
	#category : 'VirtualStash-Receipts'
}

{ #category : #'as yet unclassified' }
VsPaymentType class >> all [

	wallet ifNotNil: [ ^ wallet ].
	wallet := OrderedCollection new.
	wallet
		add: ((VsCreditCard
			named: 'Business Amex')
			ending: 3007).
	wallet
		add: ((VsCreditCard
			named: 'Personal Amex')
			ending: 5005).
	^ wallet.
]
