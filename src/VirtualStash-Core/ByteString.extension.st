Extension { #name : #ByteString }

{ #category : #'*VirtualStash-Core' }
ByteString >> pyAsTitleCase [
	"See https://pypi.org/project/titlecase/"

	^ PBApplication uniqueInstance newCommandStringFactory
	    addAllBindings: { 
	        #input -> self } asDictionary;
	    script: 'from titlecase import titlecase';
	    resultExpression: 'titlecase(input)';
	    sendAndWait.
]

{ #category : #'*VirtualStash-Core' }
ByteString >> pyAsTitleCaseExample [
	<gtExample>
	| result |
	result := 'title case me' pyAsTitleCase.
	self assert: result equals: 'Title Case Me'.
	^ result
	
]

{ #category : #'*VirtualStash-Core' }
ByteString >> vsAsUSD [
	^ self dollars
]
