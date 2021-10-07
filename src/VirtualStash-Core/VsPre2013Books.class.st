Class {
	#name : #VsPre2013Books,
	#superclass : #Object,
	#instVars : [
		'reimbursibleExpenses',
		'accountNames',
		'generalJournal'
	],
	#classInstVars : [
		'pre2013'
	],
	#category : 'VirtualStash-Core-Pre2013'
}

{ #category : #persistence }
VsPre2013Books class >> restoreFrom: anObject [

	pre2013 := anObject.
]

{ #category : #persistence }
VsPre2013Books class >> spData [

	^ pre2013
]

{ #category : #'instance creation' }
VsPre2013Books class >> uniqueInstance [

	^ pre2013 ifNil: [ pre2013 := self new ].
]

{ #category : #'paying credit cards' }
VsPre2013Books >> accounts [

	^ accountNames.
]

{ #category : #'personal expenses' }
VsPre2013Books >> category: aString [

	^ accountNames add: aString.
]

{ #category : #expenses }
VsPre2013Books >> expenseReportFor: month of: year [
	"See expenseReportFor:of: for acceptable argument values"

	| firstDayOfMonth lastDayOfMonth monthlyExpenses |
	firstDayOfMonth := Date year: year month: month day: 1.
	lastDayOfMonth := firstDayOfMonth onNextMonth - 1 days.
	monthlyExpenses := reimbursibleExpenses select: [ :e | e date >= firstDayOfMonth and: [ e date <= lastDayOfMonth ] ].
	^ VsExpenseReport on: monthlyExpenses.
]

{ #category : #private }
VsPre2013Books >> expenses [

	^ reimbursibleExpenses.
]

{ #category : #'personal expenses' }
VsPre2013Books >> expensesCollect: aBlock [

	^ reimbursibleExpenses collect: aBlock.
]

{ #category : #expenses }
VsPre2013Books >> expensesDo: aBlock [

	reimbursibleExpenses do: aBlock.
]

{ #category : #'personal expenses' }
VsPre2013Books >> expensesDuring: aTimeSpan [

	| unsorted |
	unsorted := self expenses select: [ :e | aTimeSpan includes: e date ].
	^ unsorted sort: [ :a :b | a date < b date ].
]

{ #category : #expenses }
VsPre2013Books >> expensesFor: month of: year [
	"The arguments can be numbers, numbers as strings. For the month, the name also.
	E.g. VsBooks expensesFor: 1 | '1' | 'January' of: 2008 | '2008'"

	| firstDayOfMonth lastDayOfMonth |
	firstDayOfMonth := Date year: year month: month day: 1.
	lastDayOfMonth := firstDayOfMonth onNextMonth - 1 days.
	^ reimbursibleExpenses select: [ :e | e date >= firstDayOfMonth and: [ e date <= lastDayOfMonth ] ].
]

{ #category : #expenses }
VsPre2013Books >> expensesFrom: startDate to: endDate [

	^ reimbursibleExpenses select: [ :e | e date >= startDate and: [ e date <= endDate ]]
]

{ #category : #'personal expenses' }
VsPre2013Books >> expensesSelect: aBlock [

	^ reimbursibleExpenses select: aBlock.
]

{ #category : #accessing }
VsPre2013Books >> generalJournal [
	^ generalJournal
]

{ #category : #accessing }
VsPre2013Books >> generalJournal: anObject [
	generalJournal := anObject
]

{ #category : #'personal expenses' }
VsPre2013Books >> initialize [

	super initialize.
	reimbursibleExpenses := OrderedCollection  new.
	accountNames := Set new.
]

{ #category : #'personal expenses' }
VsPre2013Books >> on: aDate iPaid: amount for: descriptionString categorizeAs: categoryString [ 

	reimbursibleExpenses add: (VsExpense
		paid: amount
		on: aDate
		for: descriptionString
		inCategory: (self category: categoryString)).
]

{ #category : #'paying credit cards' }
VsPre2013Books >> on: aDate iPaidAmex: amountNumber [

	reimbursibleExpenses add: (VsExpense
		paid: amountNumber
		on: aDate
		for: 'Amex payment'
		inCategory: 'Credit Card Payment')
]
