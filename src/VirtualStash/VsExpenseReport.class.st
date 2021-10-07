Class {
	#name : #VsExpenseReport,
	#superclass : #Object,
	#instVars : [
		'expenses'
	],
	#category : 'VirtualStash'
}

{ #category : #'instance creation' }
VsExpenseReport class >> on: expenses [

	^ self new setExpenses: expenses.
]

{ #category : #text }
VsExpenseReport >> accountTotalsColumnHeadings [

	^ #('Account' 'Total').
]

{ #category : #text }
VsExpenseReport >> accountTotalsTitle [

	^ 'Monthly Totals By Expense Account'.
]

{ #category : #'as yet unclassified' }
VsExpenseReport >> accountsAndTotalsDo: aBlock [

	| accountsWithActivity |
	accountsWithActivity := (self expenses collect: [ :e | e category ]) asSet.
	accountsWithActivity do: [ :a | | expensesForAccount total |
		expensesForAccount := self expenses select: [ :e | e category = a ].
		total := expensesForAccount inject: 0 into: [ :s :exp | s + exp amount ].
		aBlock value: a value: total ].
]

{ #category : #private }
VsExpenseReport >> expenses [

	^ expenses.
]

{ #category : #text }
VsExpenseReport >> reportSubSubTitle [

	^ 'Name: Sean DeNigris'.
]

{ #category : #text }
VsExpenseReport >> reportSubTitle [

	^ 'Monthly Expense Report - January 2008'.
]

{ #category : #text }
VsExpenseReport >> reportTitle [

	^ 'Clipper Adams, Inc.'.
]

{ #category : #private }
VsExpenseReport >> setExpenses: someExpenses [

	expenses := someExpenses.
	^ self.
]
