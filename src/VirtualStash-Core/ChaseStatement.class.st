Class {
	#name : #ChaseStatement,
	#superclass : #Object,
	#category : 'VirtualStash-Core-Statements'
}

{ #category : #'as yet unclassified' }
ChaseStatement class >> exampleImportYear [
	| folder newStatements sortedStatements |
	folder := VirtualStashDB backupDirectoryParent / 'Chase Statements' / 'Business Visa'.
	newStatements := folder files select: [ :e | e basename beginsWith: 'Stat' ].
	sortedStatements := newStatements sort: [ :a :b | a creationTime < b creationTime ].
	sortedStatements
		doWithIndex: [ :e :i | 
			| monthIndex |
			monthIndex := i asString padLeftTo: 2 with: $0.
			e renameTo: '2013-' , monthIndex , '.pdf' ]
]

{ #category : #'as yet unclassified' }
ChaseStatement class >> renameFilesIn: folder starting: aDate [
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
]
