as yet unclassified
testRecordingPersonalExpenses

	| books |
	books := VsBooks new.
	books
		on: '1/2/2008' asDate
		iPaid: 375
		for: 'Axle change and check engine light'
		categorizeAs: 'Car/Truck Expense:Auto Repairs & Maintenance'.
		
	books
		on: '1/4/2008' asDate
		iPaidAmex: 5904.79.
