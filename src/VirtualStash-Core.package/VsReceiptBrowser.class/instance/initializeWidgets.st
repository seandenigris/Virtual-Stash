initialization
initializeWidgets

	list := self instantiate: ListModel.
	list items: self receipts.

	receiptModel := self instantiate: VsReceiptUI.