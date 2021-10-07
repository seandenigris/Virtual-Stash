Class {
	#name : #QbAccountsTest,
	#superclass : #TestCase,
	#classInstVars : [
		'accounts'
	],
	#category : 'VirtualStash-Core-Tests'
}

{ #category : #'as yet unclassified' }
QbAccountsTest >> test1 [

	| accounts |
	accounts := VsQuickbooksAccount all.
	self assert: accounts first name equals: 'A.P.I.C.'.
	self assert: accounts first type equals: VsQbAccountType equity.
	self assert: accounts first balance equals: 9247.50.
]
