applying
buildPatchOperations
	super buildPatchOperations.
	self patchSet: #processorDescription to: self paymentProcessor.