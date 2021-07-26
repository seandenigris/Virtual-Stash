accessing
searchWWW
	| url |
	url := 'http://www.google.com/search' asUrl
		queryAt: 'q' put: self counterparty displayString.
	LibC system: 'open "', url asString, '"'