"
self open.
"
Class {
	#name : #VsExpenseJournalUI,
	#superclass : #ComposableModel,
	#instVars : [
		'addButton',
		'list'
	],
	#category : 'VirtualStash-UI'
}

{ #category : #'instance creation' }
VsExpenseJournalUI class >> open [

	^ self new openWithSpec.
]

{ #category : #accessing }
VsExpenseJournalUI class >> spec [
	<spec: #default>

	^ SpecLayout composed
			newColumn: [ :col | col
				newRow: [ :spec | spec add: #list ];
				newRow: [ :spec | spec add: #addButton ] height: 30 ];
			yourself.
]

{ #category : #specs }
VsExpenseJournalUI class >> title [

	^ 'Expenses for '.
]

{ #category : #initialization }
VsExpenseJournalUI >> addButton [

	^ addButton.
]

{ #category : #callbacks }
VsExpenseJournalUI >> addExpense [

	VsExpenseEditor enterExpenseInto: VsBooks uniqueInstance.
]

{ #category : #initialization }
VsExpenseJournalUI >> initializeWidgets [

	self instantiateModels: #(
		list	MultiColumnListModel "ListComposableModel"
		addButton ButtonModel).
	
	list
		items: VsBooks uniqueInstance expenses;
		displayBlock: [ :e | 
			{ 
				e date asString.
				e account.
				e description.
				e amount asString } ].
	
	addButton
		label: 'Add expense';
		action: [ self addExpense ].
]

{ #category : #accessing }
VsExpenseJournalUI >> list [
	^ list
]
