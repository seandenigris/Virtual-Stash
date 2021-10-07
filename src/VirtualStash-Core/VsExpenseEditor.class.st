"
self open.
"
Class {
	#name : #VsExpenseEditor,
	#superclass : #ComposableModel,
	#instVars : [
		'books',
		'dateLabel',
		'accountLabel',
		'descriptionLabel',
		'amountLabel',
		'date',
		'account',
		'description',
		'amount',
		'model'
	],
	#category : 'VirtualStash-Core-UI'
}

{ #category : #'instance creation' }
VsExpenseEditor class >> captureExpense [

	| instance |
	instance := self new.
	instance openDialogWithSpec.
	^ instance model.
]

{ #category : #'instance creation' }
VsExpenseEditor class >> enterExpenseInto: aVsBooks [ 

	^ self new
			books: aVsBooks;
		 	openDialogWithSpec.
]

{ #category : #'instance creation' }
VsExpenseEditor class >> open [

	^ self new openDialogWithSpec
]

{ #category : #accessing }
VsExpenseEditor class >> spec [
	<spec: #default>

	^ SpecLayout composed
			newColumn: [ :col | col
			newRow: [ :spec | spec add: #date ] height: 30;
			newRow: [ :spec | spec add: #accountLabel; add: #account ] height: 30;
			newRow: [ :spec | spec add: #descriptionLabel; add: #description ] height: 30;
			newRow: [ :spec | spec add: #amountLabel; add: #amount ] height: 30 ];
			yourself.
]

{ #category : #specs }
VsExpenseEditor class >> title [

	^ 'Enter expense...'.
]

{ #category : #accessing }
VsExpenseEditor >> account [
	^ account
]

{ #category : #accessing }
VsExpenseEditor >> accountLabel [
	^ accountLabel
]

{ #category : #private }
VsExpenseEditor >> accountNameCompletion [

	| applicants |
	applicants := VsQuickbooksAccountList new expenseAccounts collect: [ :e | e name ].

	^ EntryCompletion new
			dataSourceBlock: [:currText | applicants];
			filterBlock: [ :currApplicant :currText | 
				currText isEmpty or: [ currApplicant asUppercase includesSubstring: currText asString asUppercase ] ].
]

{ #category : #accessing }
VsExpenseEditor >> amount [
	^ amount
]

{ #category : #private }
VsExpenseEditor >> amountCompletion [

	^ EntryCompletion new
			dataSourceBlock: [:currText | 
				| similarExpenses amounts |
				similarExpenses := VsPre2013Books uniqueInstance expensesSelect: [ :e | e description = description text ].
				amounts := similarExpenses collect: [ :e | e amount asString ].
				amounts asSet asArray ];
			filterBlock: [ :currApplicant :currText | 
				currApplicant asUppercase includesSubstring: currText asString asUppercase ].
]

{ #category : #accessing }
VsExpenseEditor >> amountLabel [
	^ amountLabel
]

{ #category : #accessing }
VsExpenseEditor >> books: aVsBooks [

	books := aVsBooks.
]

{ #category : #accessing }
VsExpenseEditor >> date [
	^ date
]

{ #category : #accessing }
VsExpenseEditor >> dateLabel [
	^ dateLabel
]

{ #category : #accessing }
VsExpenseEditor >> description [
	^ description
]

{ #category : #private }
VsExpenseEditor >> descriptionCompletion [

	| applicants |
	applicants := VsPre2013Books uniqueInstance expensesCollect: [ :e | e description ].

	^ EntryCompletion new
			dataSourceBlock: [:currText | applicants asSet asArray ];
			filterBlock: [ :currApplicant :currText | 
				currApplicant asUppercase includesSubstring: currText asString asUppercase ].
]

{ #category : #accessing }
VsExpenseEditor >> descriptionLabel [
	^ descriptionLabel
]

{ #category : #'as yet unclassified' }
VsExpenseEditor >> initialExtent [

	^ 400@210.
]

{ #category : #initialization }
VsExpenseEditor >> initializeDialogWindow: aWindow [

	aWindow okAction: [ self ok ].
]

{ #category : #initialization }
VsExpenseEditor >> initializeWidgets [

	self instantiateModels: #(
		dateLabel LabelModel
		date	DateModel
		accountLabel LabelModel
		account TextInputFieldModel
		descriptionLabel LabelModel
		description TextInputFieldModel
		amountLabel LabelModel
		amount		TextInputFieldModel).
		
	dateLabel text: 'Date'.
	accountLabel text: 'Account'.
	descriptionLabel text: 'Description'.
	amountLabel text: 'Amount'.

	date dateModel
		keyStrokeForNextFocus: Character tab asShortcut;
		keyStrokeForPreviousFocus: Character tab shift asShortcut.
	date focusOrder
		add: date dateModel;
		add: account.
	
	account
		entryCompletion: self accountNameCompletion";
		acceptBlock: [ :t | Halt now ];
		whenTextIsAccepted: [ :t | Halt now ]";
		keyStrokeForNextFocus: Character tab asShortcut;
		keyStrokeForPreviousFocus: Character tab shift asShortcut.
	description
		entryCompletion: self descriptionCompletion;
		keyStrokeForNextFocus: Character tab asShortcut;
		keyStrokeForPreviousFocus: Character tab shift asShortcut.
	amount
		entryCompletion: self amountCompletion;
	keyStrokeForNextFocus: Character tab asShortcut;
		keyStrokeForPreviousFocus: Character tab shift asShortcut.

	self focusOrder
		add: date dateModel;
		add: account;
		add: description;
		add: amount.
]

{ #category : #callbacks }
VsExpenseEditor >> ok [

	date dateModel accept.
	account accept.
	description accept.
	amount accept.
	"model := VsExpense paid: amount text asNumber on: date date for: description text inCategory: account text."
	VsPre2013Books uniqueInstance on: date date iPaid: amount text asNumber for: description text categorizeAs: account text.
]
