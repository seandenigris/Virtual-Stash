accessing
genericPartiesEnsureNamed: aString aliases: aCollection
	| rule rules sourceCode |
	rules := self generic asSortedCollection: #partyName ascending.
	rules 
		detect: [ :e | e partyName = aString ]
		ifFound: [ :e | ^ e ]
		ifNone: [ 
			rule := VsImportRule new
				partyName: aString;
				partyAliases: aCollection;
				yourself.
			rules add: rule ].
	sourceCode := String streamContents: [ :str |
	str nextPutAll: 'genericParties
	^ #(
		"Name" "Alias"'.
	rules do: [ :r | 
		| aliasesToStore |
		str cr; tab; tab; print: r partyName; space.
		aliasesToStore := r partyAliases ifEmpty: [ nil ].
		aliasesToStore storeOn: str ].
	str cr; tab; nextPutAll: ').' ].
	self class compile: sourceCode classified: 'accessing'.
	^ rule
	