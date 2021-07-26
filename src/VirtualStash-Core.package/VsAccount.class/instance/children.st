accessing
children
	^ self chart select: [ :e | e parent = self ]