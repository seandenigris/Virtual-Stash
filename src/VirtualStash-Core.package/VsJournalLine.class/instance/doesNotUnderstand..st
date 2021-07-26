magritte-accessing
doesNotUnderstand: aMessage
	^ (self model isNotNil and: [ self model respondsTo: aMessage selector ]) 
		ifTrue: [ aMessage sendTo: self model ]
		ifFalse: [ super doesNotUnderstand: aMessage ]