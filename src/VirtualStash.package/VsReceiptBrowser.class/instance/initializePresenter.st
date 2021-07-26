initialization
initializePresenter

	list whenSelectedItemChanged: [ :receipt | receiptModel ifNotNil: [ receiptModel receipt: receipt ] ].