instance creation
business

	^ business ifNil: [ business := self new title: 'Business'; yourself ].