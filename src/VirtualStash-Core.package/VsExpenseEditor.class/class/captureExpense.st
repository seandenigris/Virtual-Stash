instance creation
captureExpense

	| instance |
	instance := self new.
	instance openDialogWithSpec.
	^ instance model.