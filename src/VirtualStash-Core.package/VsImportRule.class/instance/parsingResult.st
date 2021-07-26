private
parsingResult
	^ parsingResult ifNil: [ parsingResult := self parser parse: self input string ].