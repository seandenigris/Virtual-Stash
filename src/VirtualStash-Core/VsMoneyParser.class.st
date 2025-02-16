Class {
	#name : #VsMoneyParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'upToTwoDigits'
	],
	#category : #'VirtualStash-Core'
}

{ #category : #accessing }
VsMoneyParser class >> exampleCents [
	<gtExample>
	^ self
		given: [ '0.13' ]
		when: [ :input | self parse: input ]
		then: [ :result | result should equal: '0.13' dollars ]
]

{ #category : #accessing }
VsMoneyParser class >> exampleHundreds [
	<gtExample>
	^ self
		given: [ '123.45' ]
		when: [ :input | self parse: input ]
		then: [ :result | result should equal: '123.45' dollars ]
]

{ #category : #accessing }
VsMoneyParser class >> exampleNoCents [
	<gtExample>
	^ self
		given: [ '$13' ]
		when: [ :input | self parse: input ]
		then: [ :result | result should equal: '13' dollars ]
]

{ #category : #accessing }
VsMoneyParser class >> exampleNoCommas [
	<gtExample>
	^ self
		given: [ '1234.56' ]
		when: [ :input | self parse: input ]
		then: [ :result | result should equal: '1234.56' dollars ]
]

{ #category : #accessing }
VsMoneyParser class >> exampleWithCommas [
	<gtExample>
	^ self
		given: [ '1,234.56' ]
		when: [ :input | self parse: input ]
		then: [ :result | result should equal: '1234.56' dollars ]
]

{ #category : #accessing }
VsMoneyParser >> start [
	| dollars cents upToThreeDigits comma sign |
	"making the dollar sign optional resulted in too many false hits"
	sign := $$ asPParser "optional" ==> [ :n | '' ].
	upToThreeDigits := self upToDigits: 3.
	comma := $, asPParser optional ==> [ :n | '' ].
	dollars := (self upToDigits: 3) separatedBy: comma.
	cents := ($. asPParser ==> #asString, self twoDigits) optional ==> [ :n | n ifNil: [ '' ] ].
	^ sign, dollars, cents ==> [ :n | 
		| resultString |
		resultString := n flatten flatCollect: #yourself as: String.
		resultString dollars ]
]

{ #category : #accessing }
VsMoneyParser >> twoDigits [
	^ #digit asPParser plus min: 2; max: 2; flatten
]

{ #category : #accessing }
VsMoneyParser >> upToDigits: anInteger [
	^ #digit asPParser plus min: 1; max: anInteger; flatten
]

{ #category : #accessing }
VsMoneyParser >> upToTwoDigits [
	^ self upToDigits: 2
]
