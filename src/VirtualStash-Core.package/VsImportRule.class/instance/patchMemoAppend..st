applying
patchMemoAppend: aString
	| newMemo |
	aString isEmptyOrNil ifTrue: [ ^ self ].
	newMemo := VsTransaction memo: self transaction memo append: aString.
	self patchSet: #memoDescription to: newMemo