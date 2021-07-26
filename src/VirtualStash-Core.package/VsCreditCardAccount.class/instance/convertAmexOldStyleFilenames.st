accessing
convertAmexOldStyleFilenames
	self statements
		select: [ :e | e file base beginsWith: 'Sta' ]
		thenCollect: [ :e | 
			| dateString month newBase |
			dateString := e file base copyAfter: $_.
			month := Month readFrom: dateString readStream.
			newBase := month year asString , '-'
				, (month index printStringPadded: 2).
			e moveFileTo: e parent / newBase , 'pdf' ]