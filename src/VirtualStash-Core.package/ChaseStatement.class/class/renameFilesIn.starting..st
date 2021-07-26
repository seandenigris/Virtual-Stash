as yet unclassified
renameFilesIn: folder starting: aDate
	"
	aDate - any date during the first statement"

	| statements sorted |
	statements := folder filesMatching: 'Statement*.pdf'.
	sorted := statements sort: [ :a :b | (a base copyAfter: $-) asNumber < (b base copyAfter: $-) asNumber ].
	sorted
		doWithIndex: [ :e :i | 
			| currentDate newName |
			currentDate := aDate addMonths: i - 1.
			newName := currentDate year asString, '-' , (currentDate monthIndex printPaddedWith: $0 to: 2).
			e renameTo: newName, '.pdf' ]