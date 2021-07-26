accessing
memo
	^ memo ifNil: [ memo := self parsingResult last ]