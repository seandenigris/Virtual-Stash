as yet unclassified
renderTotalsByAccountOn: html
	
	html heading level: 4; with: self model accountTotalsTitle.
	html table: [
		html tableRow: [
			self model accountTotalsColumnHeadings do: [ :h |
				html tableHeading: h ] ].
		self model accountsAndTotalsDo: [ :a :total |
				html tableRow: [
					html tableData: a.
					html tableData: total ] ] ].
	html horizontalRule.