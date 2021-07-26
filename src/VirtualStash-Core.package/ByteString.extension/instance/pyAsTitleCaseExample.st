*VirtualStash-Core
pyAsTitleCaseExample
	<gtExample>
	| result |
	result := 'title case me' pyAsTitleCase.
	self assert: result equals: 'Title Case Me'.
	^ result
	