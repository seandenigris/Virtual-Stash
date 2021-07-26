initialization
initializePresenter

	list whenSelectedItemChanged: [ :receipt | receipt ifNotNil: [ receiptModel receipt: receipt ] ].