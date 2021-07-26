accessing
accountNamed: fullNameString

	^ self transaction accountSource accounts detect: [ :e | e fullName = fullNameString ]