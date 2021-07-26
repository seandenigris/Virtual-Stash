examples
given: inputString thenDontMatchMunicipalityNamed: municipalityName
	[ 
		self
			given: inputString
			appliedTo: []
			then: [ :t | self assert: t counterparty fullName ~= municipalityName ]
	] on: Error do: [ "will end up here if no rule for input; not relevant to this test" ]