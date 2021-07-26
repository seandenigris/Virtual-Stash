accessing
statements
	| files |
	files := self rootFolder / 'Statements' filesMatching: '*.pdf'.
	^ files
		collect: [ :e | 
			| statement dateParts |
			statement := VsStatement on: e.
			"The filename convention is e.g. 2020-11-30... with day optional"
			dateParts := e base splitOn: $-.
			dateParts size > 2
				ifTrue: [ | closingDate |
					closingDate := Date
						year: dateParts first asNumber
						month: dateParts second asNumber
						day: dateParts third asNumber.
					statement closingDate: closingDate ].
			statement ]
		as: SortedCollection