printing
printOn: aStream
	{ self dateDescription. self amountDescription. self counterpartyDescription. self memoDescription } 
		do: [ :d | aStream maPrint: d for:  self ]
		separatedBy: [ aStream space ]