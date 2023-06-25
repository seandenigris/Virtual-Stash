Class {
	#name : #VsOfxDatetimeParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'year',
		'twoDigitNumber'
	],
	#category : #'VirtualStash-Core-Bookkeeping'
}

{ #category : #examples }
VsOfxDatetimeParser class >> example [
	<gtExample>
	self
		given: [ '20230621123456.789[+0:UTC]' ]
		when: [ :input | self parse: input ]
		then: [ :result | self assert: result equals: '2023-06-21T12:34:56.789-00:00' asDateAndTime ]
]

{ #category : #accessing }
VsOfxDatetimeParser >> start [
	| date time |
	date := (year , twoDigitNumber , twoDigitNumber)
			==> [ :nodes | 
				Date
					year: nodes first
					month: nodes second
					day: nodes third ].
	time := (twoDigitNumber , twoDigitNumber , $[ asPParser negate plus flatten)
			==> [ :nodes | 
				Time
					hour: nodes first
					minute: nodes second
					second: nodes third asNumber ].
	^ (date , time , '[+0:UTC]' asPParser)
		==> [ :nodes | (DateAndTime date: nodes first time: nodes second) translateToUTC ]
]

{ #category : #accessing }
VsOfxDatetimeParser >> twoDigitNumber [
	^ (#digit asPParser times: 2) flatten ==> #asNumber
]

{ #category : #accessing }
VsOfxDatetimeParser >> year [
	^ (#digit asPParser times: 4) flatten ==> #asNumber
]
