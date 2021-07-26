accessing
ruleIfFound: foundBlock ifNone: noneBlock
	^ (VsImportRule for: self transaction)
		ifNotNil: [ :r | foundBlock cull: r ]
		ifNil: noneBlock