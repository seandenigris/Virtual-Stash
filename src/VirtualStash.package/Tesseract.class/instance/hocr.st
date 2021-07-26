protocol
hocr

	| hocrString |
	tempFileExtension := 'html'.
	hocrString := self evaluate: self hocrCommand.
	^ Hocr on: hocrString.