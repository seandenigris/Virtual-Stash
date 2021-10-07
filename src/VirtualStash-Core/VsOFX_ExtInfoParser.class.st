Class {
	#name : #'VsOFX_ExtInfoParser',
	#superclass : #PP2CompositeNode,
	#instVars : [
		'memo',
		'header'
	],
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #examples }
VsOFX_ExtInfoParser class >> example [
	<gtExample>
	self
		given: [ 'OFX ext. info: |Trans type:Generic debit|Memo:JOHN SMITH-12345-987654321   800-123-4567' ]
		when: [ :input | self parse: input ]
		then: [ :result | self assert: result equals: 'JOHN SMITH-12345-987654321   800-123-4567' ]
]

{ #category : #accessing }
VsOFX_ExtInfoParser class >> header [
	^ 'OFX ext. info: '
]

{ #category : #accessing }
VsOFX_ExtInfoParser >> header [
	^ self class header asPParser
]

{ #category : #accessing }
VsOFX_ExtInfoParser >> memo [
	^ '|Memo:' asPParser, $| asPParser negate plus flatten ==> #second
]

{ #category : #accessing }
VsOFX_ExtInfoParser >> start [
	^ header, '|Trans type:Generic ' asPParser, ('debit' asPParser / 'credit' asPParser), memo optional end ==> #last
]
