accessing
bePerson
	| person |
	person := MpPerson ensureNamed: self input suggestion.
	self transactions do: [ :t | t counterparty: person ]