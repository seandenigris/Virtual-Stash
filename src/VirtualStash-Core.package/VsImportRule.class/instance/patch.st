applying
patch
	^ patch 
		ifNotNil: [ patch ]
		ifNil: [ 
			patch := MAPatchMacro new.
			self buildPatchOperations.
			patch ].