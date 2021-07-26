accessing
gtViewGenericsOn: aView
	<gtClassView>
	| orgColor |
	^ aView mondrian
		title: 'Generics' translated;
		priority: 50;
		painting: [ :mondrian | 
			mondrian nodes
				shape: [ :rule | 
					| aliasColor |
					aliasColor := Color red.
					MpAddressBook default contacts
						detect: [ :e | e fullName = rule partyName ]
						ifFound: [ :org | 
							| orgAs ruleAs |
							orgColor := Color gray.
							aliasColor := Color black.
							orgAs := org aliases.
							ruleAs := rule partyAliases asSet.
							orgAs = ruleAs
								ifFalse: [ 
									(ruleAs difference: orgAs) ifNotEmpty: [ aliasColor := Color green ].
									(orgAs difference: ruleAs) ifNotEmpty: [ aliasColor := Color yellow ] ] ]
						ifNone: [ orgColor := Color purple ].
					BlElement new
						border: (BlBorder paint: aliasColor width: 10);
						background: orgColor;
						constraintsDo: [ :constraints | constraints padding: (BlInsets all: 50) ] ];
				with: self generic.
			mondrian layout grid ];
		send: [ :rule | 
			{rule.
			(MpAddressBook default contacts
				detect: [ :e | e fullName = rule partyName ]
				ifNone: [ nil ])} ]