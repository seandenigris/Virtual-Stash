applying
buildPatchOperations
	self
		patchSet: #numberDescription to: self memo;
		patchSet: #counterpartyDescription to: nil;
		patchMemoAppend: 'Check'.