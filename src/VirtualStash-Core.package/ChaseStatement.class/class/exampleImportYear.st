as yet unclassified
exampleImportYear
	| folder newStatements sortedStatements |
	folder := VirtualStashDB backupDirectoryParent / 'Chase Statements' / 'Business Visa'.
	newStatements := folder files select: [ :e | e basename beginsWith: 'Stat' ].
	sortedStatements := newStatements sort: [ :a :b | a creationTime < b creationTime ].
	sortedStatements
		doWithIndex: [ :e :i | 
			| monthIndex |
			monthIndex := i asString padLeftTo: 2 with: $0.
			e renameTo: '2013-' , monthIndex , '.pdf' ]