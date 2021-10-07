Class {
	#name : #VsExpense,
	#superclass : #Object,
	#instVars : [
		'date',
		'description',
		'category',
		'amount'
	],
	#category : 'VirtualStash'
}

{ #category : #'instance creation' }
VsExpense class >> on: aDate for: descriptionString inCategory: categoryString [ 

	^ self new
		setDate: aDate
		description: descriptionString
		category: categoryString.
]

{ #category : #'instance creation' }
VsExpense class >> paid: amount on: aDate for: descriptionString inCategory: categoryString [ 

	^ self new
		setAmount: amount
		date: aDate
		description: descriptionString
		category: categoryString.
]

{ #category : #accessing }
VsExpense >> account [

	^ category.
]

{ #category : #private }
VsExpense >> account: aString [

	^ category := aString.
]

{ #category : #private }
VsExpense >> amount [

	^ amount.
]

{ #category : #private }
VsExpense >> category [

	^ category.
]

{ #category : #accessing }
VsExpense >> date [

	^ date.
]

{ #category : #private }
VsExpense >> description [

	^ description.
]

{ #category : #private }
VsExpense >> printOn: aStream [

	aStream nextPutAll: '[', date asString, '] ', amount asString, ' for ', description, ' (', category, ')'
]

{ #category : #private }
VsExpense >> setAmount: amountNumber date: aDate description: descriptionString category: categoryString [

	amount := amountNumber.
	date := aDate.
	description := descriptionString.
	category := categoryString.
	^ self.
]
