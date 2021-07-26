accessing
fullName
	^ self pathString 
		ifEmpty: [ self name ]
		ifNotEmpty: [ :p | p, ':', self name ]