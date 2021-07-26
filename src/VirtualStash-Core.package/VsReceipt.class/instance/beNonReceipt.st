as yet unclassified
beNonReceipt
	self flag: 'This is obviously not a good solution, but I have no idea how VS will integrate with other systems, so hack this in to get non-receipts out of the way for now'.
	VsReceiptFile uniqueInstance receipts remove: self.
	VsReceiptFile uniqueInstance nonReceipts add: self.