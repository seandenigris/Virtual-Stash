examples
example
	<gtExample>
	self
		given: [ 'OFX ext. info: |Trans type:Generic debit|Memo:JOHN SMITH-12345-987654321   800-123-4567' ]
		when: [ :input | self parse: input ]
		then: [ :result | self assert: result equals: 'JOHN SMITH-12345-987654321   800-123-4567' ]