examples
findFilesFor: receiptCollection
	[ :job |
	receiptCollection doWithIndex: [ :e :i | 
		job progress: i / receiptCollection size.
		e findFile ] ] asJob run