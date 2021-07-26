accessing
buildPatchOperations
	self
		patchSet: #processorDescription to: self paymentProcessor;
		patchSet: #counterpartyDescription to: nil;
		patchMemoAppend: self memo.