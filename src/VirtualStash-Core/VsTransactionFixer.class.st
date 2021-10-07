"
I am an example of naivety and NIH syndrome. I am a hand-rolled attempt to determine whether a counterparty is a variant (e.g. misspelled). I will probably go away as we are currently exploring leveraging Python for this task.
"
Class {
	#name : #VsTransactionFixer,
	#superclass : #Object,
	#instVars : [
		'transaction',
		'input',
		'prefixWordCount',
		'counterparty',
		'suffix',
		'alias'
	],
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #accessing }
VsTransactionFixer class >> isDeprecated [
	^ true.
]

{ #category : #accessing }
VsTransactionFixer >> alias [
	^ self maLazyInstVarUsing: self aliasDescription
]

{ #category : #accessing }
VsTransactionFixer >> alias: aString [
	alias := aString
]

{ #category : #'magritte-accessing' }
VsTransactionFixer >> aliasDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #alias;
		default: (self parser parse: self input) first;
		shouldCacheDefault: true;
		yourself
]

{ #category : #accessing }
VsTransactionFixer >> apply [
	| party |
	party := MpOrganization ensureNamed: self counterparty.
	self applyAliasTo: party.
	self transaction
		counterparty: party;
		memoAppend: self suffix.
]

{ #category : #accessing }
VsTransactionFixer >> applyAliasTo: party [
	self alias isEmptyOrNil ifTrue: [ ^ self ].
	(party aliases includes: self alias) ifTrue: [ ^ self ].
	
	party aliases add: self alias
]

{ #category : #accessing }
VsTransactionFixer >> counterparty [
	^ counterparty ifNil: [ counterparty := (self parser parse: self input) first ]
]

{ #category : #accessing }
VsTransactionFixer >> counterparty: aString [
	counterparty := aString
]

{ #category : #'magritte-accessing' }
VsTransactionFixer >> counterpartyDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #counterparty;
		yourself
]

{ #category : #accessing }
VsTransactionFixer >> input [
	^ self transaction counterparty
]

{ #category : #'magritte-accessing' }
VsTransactionFixer >> inputDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #input;
		yourself
]

{ #category : #accessing }
VsTransactionFixer >> parser [
	^ self partyParser, self separatorParser, #any asPParser star flatten
]

{ #category : #accessing }
VsTransactionFixer >> partyParser [
	| prefixWord result |
	prefixWord := self separatorParser negate star flatten.
	result := (1 to: self prefixWordCount - 1)
		inject: prefixWord
		into: [ :p :e | p , self separatorParser , prefixWord ].
	^ result flatten
]

{ #category : #accessing }
VsTransactionFixer >> prefix [
	^ (self parser parse: self input) first
]

{ #category : #accessing }
VsTransactionFixer >> prefixWordCount [
	^ self maLazyInstVarUsing: self prefixWordCountDescription
]

{ #category : #accessing }
VsTransactionFixer >> prefixWordCount: aNumber [
	prefixWordCount := aNumber
]

{ #category : #'magritte-accessing' }
VsTransactionFixer >> prefixWordCountDescription [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #prefixWordCount;
		default: 1;
		yourself
]

{ #category : #accessing }
VsTransactionFixer >> result [
	^ { self counterparty. self alias. self suffix }
]

{ #category : #accessing }
VsTransactionFixer >> separatorParser [
	^ ' ' inject: $* asPParser into: [ :p :e | 
		p / e asPParser ]
]

{ #category : #accessing }
VsTransactionFixer >> suffix [
	^ (self parser parse: self input) last
]

{ #category : #accessing }
VsTransactionFixer >> suffix: aString [
	suffix := aString
]

{ #category : #'magritte-accessing' }
VsTransactionFixer >> suffixDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #suffix;
		yourself
]

{ #category : #accessing }
VsTransactionFixer >> transaction [
	^ transaction
]

{ #category : #accessing }
VsTransactionFixer >> transaction: anObject [
	transaction := anObject
]
