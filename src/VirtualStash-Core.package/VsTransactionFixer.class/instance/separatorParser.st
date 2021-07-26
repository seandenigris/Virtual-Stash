accessing
separatorParser
	^ ' ' inject: $* asPParser into: [ :p :e | 
		p / e asPParser ]