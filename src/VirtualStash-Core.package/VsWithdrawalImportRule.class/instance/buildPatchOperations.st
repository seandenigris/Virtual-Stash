accessing
buildPatchOperations
	self patchSet: #counterpartyDescription to: nil.
	self patch addOperationFor: self debit set: self debit accountDescription to: self user vsCashAccount.