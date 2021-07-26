accessing
form
	^ self imageFile
		ifNotNil: [ :f | Form fromFileNamed: f fullName ]
		ifNil: [ Morph new imageForm ]