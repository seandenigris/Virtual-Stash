Extension { #name : 'ByteString' }

{ #category : '*VirtualStash-Core' }
ByteString >> dollars [

  | amt |
  amt := ScaledDecimal readFrom: ( self copyWithout: $, ).
  ^ VsUnits
  	quantity: amt
  	of: #dollar
  	
  "Previoius attempt:
  parser := RxMatcher forString: '\(?\$?(-?(\d|,)+(.\d+)?\)?)( USD)?'.
  And before that:
	| symbol amount |
	symbol := $$ asPParser.
	amount := #digit asPParser plus, ($. asPParser, #digit asPParser, #digit asPParser) optional.
	^ (symbol, amount flatten) ==> [ :n | n second asNumber dollars ]
	And related:
	fromString: aString
	| parser amountString safeAmountString |
	parser := self parser.
	(parser matches: aString) ifFalse: [ self error ].
	amountString := (parser subexpression: 2).
	safeAmountString := amountString copyWithout: $,.
	^ safeAmountString dollars."
]

{ #category : '*VirtualStash-Core' }
ByteString >> pyAsTitleCase [
	"See https://pypi.org/project/titlecase/"

	^ PBApplication uniqueInstance newCommandStringFactory
	    addAllBindings: { 
	        #input -> self } asDictionary;
	    script: 'from titlecase import titlecase';
	    resultExpression: 'titlecase(input)';
	    sendAndWait.
]

{ #category : '*VirtualStash-Core' }
ByteString >> pyAsTitleCaseExample [
	<gtExample>
	| result |
	result := 'title case me' pyAsTitleCase.
	self assert: result equals: 'Title Case Me'.
	^ result
	
]

{ #category : '*VirtualStash-Core' }
ByteString >> vsAsUSD [
	^ self dollars
]
