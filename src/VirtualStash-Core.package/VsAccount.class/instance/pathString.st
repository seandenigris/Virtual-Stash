accessing
pathString
	^ parent ifNotNil: [ :p | p fullName ] ifNil: [ '' ]