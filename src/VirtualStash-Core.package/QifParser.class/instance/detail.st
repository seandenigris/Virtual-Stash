rules
detail
	| recordEnd |
	recordEnd := $^ asParser, lineSeparator optional.
	^ anyPart plus, recordEnd ==> #first