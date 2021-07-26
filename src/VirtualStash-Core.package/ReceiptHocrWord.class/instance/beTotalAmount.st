as yet unclassified
beTotalAmount

	| number dollars cents amountRule parseResult |
	dollars := number := #digit asParser plus flatten.
	cents := $. asParser, number.
	amountRule := $$ asParser optional, (dollars, cents optional) flatten end ==> #second.
	parseResult := amountRule parse: self string.
	self receipt amount: parseResult asNumber