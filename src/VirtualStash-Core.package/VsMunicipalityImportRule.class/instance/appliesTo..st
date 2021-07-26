accessing
appliesTo: aVsTransaction
	| input commonNameParser commonNamePlusParser parseResult |
	input := aVsTransaction counterparty asString.
	
	"Since local businesses may have names starting with the municipality name, to avoid wrongly applying in those cases, only match if the input is known to be municipality-related"
	commonNameParser := self commonName asPParser caseInsensitive.
	commonNamePlusParser := commonNameParser, #any asPParser star flatten trimBlanks ==> #second.
	parseResult := commonNamePlusParser parse: input.
	^ parseResult isPetit2Success
		ifTrue: [ parseResult isEmpty or: [ self suffixes includes: parseResult ] ]
		ifFalse: [ super appliesTo: aVsTransaction ]