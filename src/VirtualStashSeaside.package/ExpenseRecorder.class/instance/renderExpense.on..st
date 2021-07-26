as yet unclassified
renderExpense: expense on: html

"	html listItem with: expense asString."
	html tableRow: [
		html
			tableData: expense date mmddyyyy;
			tableData: expense category;
			tableData: expense description;
			tableData: expense amount ].