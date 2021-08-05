accessing
exampleCash
	<gtExample>
	^ self new
		resource: (FileLocator virtualStashData / 'Examples' / 'Receipt_20151230_0004.pdf') asRlResource;
		yourself