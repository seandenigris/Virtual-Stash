accessing
fixParentsOf: aCollection
	aCollection do: [ :e |
		e parent ifNotNil: [
			| parent |
			parent := aCollection detect: [ :candidate | candidate gnuCashAccountFullName = e parent ].
			e parent: parent ] ]