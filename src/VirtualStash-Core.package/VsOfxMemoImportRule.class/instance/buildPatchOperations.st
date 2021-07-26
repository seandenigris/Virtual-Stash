accessing
buildPatchOperations
	| newMemo |
	newMemo := VsOFX_ExtInfoParser parse: transaction memo.
	self patchMemoAppend: newMemo.