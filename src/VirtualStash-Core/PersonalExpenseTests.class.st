Class {
	#name : #PersonalExpenseTests,
	#superclass : #TestCase,
	#category : 'VirtualStash-Core-Tests'
}

{ #category : #'as yet unclassified' }
PersonalExpenseTests >> testRecordingPersonalExpenses [

	| books |
	books := VsPre2013Books new.
	books
		on: '1/2/2008' asDate
		iPaid: 375
		for: 'Axle change and check engine light'
		categorizeAs: 'Car/Truck Expense:Auto Repairs & Maintenance'.
		
	books
		on: '1/4/2008' asDate
		iPaidAmex: 5904.79.

]
