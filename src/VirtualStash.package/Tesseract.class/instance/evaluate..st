private
evaluate: commandString

	| p result |
	p := PipeableOSProcess waitForCommand: commandString.
	p succeeded ifFalse: [ ^ self error: 'tesseract failed with: ', p errorUpToEnd ].
	result := self tempFile readStreamDo: [ :str | str contents ].
	self tempFile delete.
	^ result.
	