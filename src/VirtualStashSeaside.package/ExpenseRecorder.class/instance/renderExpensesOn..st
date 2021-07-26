as yet unclassified
renderExpensesOn: html

	html heading level: 4; with: 'Itemized Expenses'.
	html table: [
		html tableRow: [
			html
				tableHeading: 'Date';
				tableHeading: 'Account';
				tableHeading: 'Description';
				tableHeading: 'Amount' ].
	self model expenses do: [ :each | self renderExpense: each on: html ] ].