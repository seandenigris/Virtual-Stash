accessing
buildPatchOperations
	self party: self user.
	self memo: transaction input string.
	super buildPatchOperations