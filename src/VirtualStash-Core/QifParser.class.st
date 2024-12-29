Class {
	#name : #QifParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'headerLine',
		'dateItem',
		'splitAccountItem',
		'splitMemoItem',
		'splitAmountItem',
		'split',
		'clearedStatusItem',
		'memoItem',
		'amountItem',
		'payeeItem',
		'accountItem',
		'anyPart',
		'detail',
		'lineSeparator',
		'checkNumberItem'
	],
	#category : #'VirtualStash-Core-QIF'
}

{ #category : #rules }
QifParser >> accountItem [
	^ self accountItemWithCode: $L
]

{ #category : #'as yet unclassified' }
QifParser >> accountItemWithCode: aCharacter [
	| data accountName account category |
	accountName := $] asPParser negate plus flatten.
	account := $[ asPParser, accountName, $] asPParser ==> #second.
	category := ($[ asPParser negate, lineSeparator negate plus) flatten. 
	data := account / category.
	^ aCharacter asPParser, data, lineSeparator ==> #second.
]

{ #category : #rules }
QifParser >> amountItem [
	^ self amountItemWithCode: $T
]

{ #category : #'as yet unclassified' }
QifParser >> amountItemWithCode: aCharacter [
	^ self detailItemCode: aCharacter do: [ :e | | withoutCommas |
		withoutCommas := e copyWithout: $,.
		withoutCommas asNumber ].
]

{ #category : #rules }
QifParser >> anyPart [
	^ dateItem / clearedStatusItem / memoItem / amountItem / payeeItem / checkNumberItem / accountItem / split plus
]

{ #category : #rules }
QifParser >> checkNumberItem [
	^ self detailItemCode: $N do: [ :e | e ].
]

{ #category : #rules }
QifParser >> clearedStatusItem [
	^ self detailItemCode: $C do: [ :e |
		e = ''
			ifTrue: [ 'nc' ]
			ifFalse: [ (e = '*' or: [ e = 'c' ]) 
				ifTrue: [ 'c' ]
				ifFalse: [ (e = 'X' or: [ e = 'R' ])
					ifTrue: [ 'r' ] ] ] ].
]

{ #category : #rules }
QifParser >> dateItem [
	^ self detailItemCode: $D do: [ :e | e asDate ].
]

{ #category : #rules }
QifParser >> detail [
	| recordEnd |
	recordEnd := $^ asPParser, lineSeparator optional.
	^ anyPart plus, recordEnd ==> #first
]

{ #category : #'as yet unclassified' }
QifParser >> detailItemCode: aCharacter do: aBlock [
	| data |
	data := lineSeparator negate star flatten ==> aBlock.
	^ aCharacter asPParser, data, lineSeparator ==> #second.
]

{ #category : #rules }
QifParser >> headerLine [
	| accountType |
	accountType := lineSeparator negate plus flatten.
	^ '!Type:' asPParser, accountType, lineSeparator ==> #second
]

{ #category : #rules }
QifParser >> lineSeparator [
	^ #newline asPParser, #newline asPParser optional
]

{ #category : #rules }
QifParser >> memoItem [
	^ self memoItemWithCode: $M
]

{ #category : #'as yet unclassified' }
QifParser >> memoItemWithCode: aCharacter [
	^ self detailItemCode: aCharacter do: [ :e | e ].
]

{ #category : #rules }
QifParser >> payeeItem [
	^ self detailItemCode: $P do: [ :e | e ].
]

{ #category : #rules }
QifParser >> split [
	^ splitAccountItem, splitMemoItem optional, splitAmountItem
]

{ #category : #rules }
QifParser >> splitAccountItem [
	^ self accountItemWithCode: $S
]

{ #category : #rules }
QifParser >> splitAmountItem [
	^ self amountItemWithCode: $$
]

{ #category : #rules }
QifParser >> splitMemoItem [
	^ self memoItemWithCode: $E
]

{ #category : #'as yet unclassified' }
QifParser >> splits [
	^ split star
]

{ #category : #rules }
QifParser >> start [
	^ headerLine, detail star end
]
