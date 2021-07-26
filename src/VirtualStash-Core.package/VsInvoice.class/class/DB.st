accessing
DB
	^ DB ifNil: [ DB := OrderedCollection new ]