as yet unclassified
beDate

	| separator number dateRule parseResult |
	separator := $/ asParser.
	number := #digit asParser star flatten.
	dateRule := (number, separator, number, separator, number) flatten.
	parseResult := dateRule parse: self string.
	self receipt date: parseResult asDate