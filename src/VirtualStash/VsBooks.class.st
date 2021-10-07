Class {
	#name : #VsBooks,
	#superclass : #Object,
	#instVars : [
		'reimbursibleExpenses',
		'accountNames'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'VirtualStash'
}

{ #category : #persistence }
VsBooks class >> restoreFrom: anObject [

	uniqueInstance := anObject.
]

{ #category : #'instance creation' }
VsBooks class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ].
]

{ #category : #'paying credit cards' }
VsBooks >> accounts [

	^ accountNames.
]

{ #category : #'personal expenses' }
VsBooks >> category: aString [

	^ accountNames add: aString.
]

{ #category : #'as yet unclassified' }
VsBooks >> expenseReportFor: month of: year [
	"See expenseReportFor:of: for acceptable argument values"

	| firstDayOfMonth lastDayOfMonth monthlyExpenses |
	firstDayOfMonth := Date year: year month: month day: 1.
	lastDayOfMonth := firstDayOfMonth onNextMonth - 1 days.
	monthlyExpenses := reimbursibleExpenses select: [ :e | e date >= firstDayOfMonth and: [ e date <= lastDayOfMonth ] ].
	^ VsExpenseReport on: monthlyExpenses.
]

{ #category : #private }
VsBooks >> expenses [

	^ reimbursibleExpenses.
]

{ #category : #'personal expenses' }
VsBooks >> expensesCollect: aBlock [

	^ reimbursibleExpenses collect: aBlock.
]

{ #category : #'as yet unclassified' }
VsBooks >> expensesDo: aBlock [

	reimbursibleExpenses do: aBlock.
]

{ #category : #'personal expenses' }
VsBooks >> expensesDuring: aTimeSpan [

	| unsorted |
	unsorted := self expenses select: [ :e | aTimeSpan includes: e date ].
	^ unsorted sort: [ :a :b | a date < b date ].
]

{ #category : #'as yet unclassified' }
VsBooks >> expensesFor: month of: year [
	"The arguments can be numbers, numbers as strings. For the month, the name also.
	E.g. VsBooks expensesFor: 1 | '1' | 'January' of: 2008 | '2008'"

	| firstDayOfMonth lastDayOfMonth |
	firstDayOfMonth := Date year: year month: month day: 1.
	lastDayOfMonth := firstDayOfMonth onNextMonth - 1 days.
	^ reimbursibleExpenses select: [ :e | e date >= firstDayOfMonth and: [ e date <= lastDayOfMonth ] ].
]

{ #category : #'as yet unclassified' }
VsBooks >> expensesFrom: startDate to: endDate [

	^ reimbursibleExpenses select: [ :e | e date >= startDate and: [ e date <= endDate ]]
]

{ #category : #'personal expenses' }
VsBooks >> expensesSelect: aBlock [

	^ reimbursibleExpenses select: aBlock.
]

{ #category : #'personal expenses' }
VsBooks >> initialize [

	super initialize.
	reimbursibleExpenses := OrderedCollection  new.
	accountNames := Set new.
]

{ #category : #'personal expenses' }
VsBooks >> on: aDate iPaid: amount for: descriptionString categorizeAs: categoryString [ 

	reimbursibleExpenses add: (VsExpense
		paid: amount
		on: aDate
		for: descriptionString
		inCategory: (self category: categoryString)).
]

{ #category : #'paying credit cards' }
VsBooks >> on: aDate iPaidAmex: amountNumber [

	reimbursibleExpenses add: (VsExpense
		paid: amountNumber
		on: aDate
		for: 'Amex payment'
		inCategory: 'Credit Card Payment')
]
