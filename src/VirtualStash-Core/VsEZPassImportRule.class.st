Class {
	#name : #VsEZPassImportRule,
	#superclass : #VsExplicitCounterpartyImportRule,
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #examples }
VsEZPassImportRule class >> example [
	<gtExample>
	self
		given: 'E-ZPASS'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'E-ZPass' ]
]

{ #category : #examples }
VsEZPassImportRule class >> exampleMemo [
	<gtExample>
	self
		given: 'NEW JERSEY E-ZPASS'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'E-ZPass' ]
		andMemoAppendedWith: 'NEW JERSEY'
]

{ #category : #examples }
VsEZPassImportRule class >> exampleNYS [
	<gtExample>
	self
		given: 'NYS THRUWAY E-ZPASS'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'E-ZPass' ]
		andMemoAppendedWith: 'NYS THRUWAY'
]

{ #category : #accessing }
VsEZPassImportRule class >> isAbstract [
	self flag: 'Ugly hack. Since this belongs to a specific organization, exclude it from enumeration'.
	^ true
]

{ #category : #accessing }
VsEZPassImportRule >> initialize [
	super initialize.
	partyName := 'E-ZPass' "For testing, because there is no hook"
]

{ #category : #accessing }
VsEZPassImportRule >> parser [
	^ ('NEW JERSEY' asPParser / 'NYS THRUWAY' asPParser) trimBlanks optional, super parser ==> [ :n | { nil. nil. nil. nil. n first } ]
]
