accessing
buildPatchOperations
	self patchSet: #processorDescription to: self credit account issuer.
	self error: 'to fully process this, we need access to *all* transactions so we can find the one on the other side'