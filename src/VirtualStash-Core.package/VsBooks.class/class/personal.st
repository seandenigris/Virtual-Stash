instance creation
personal

	^ personal ifNil: [ personal := self new title: 'Personal'; yourself ].