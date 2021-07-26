accessing
inputElement: anElement named: aString in: formElement
	| labelElement text |
	labelElement := BrLabel new text: aString, ':'; aptitude: BrGlamorousLabelAptitude.
	labelElement constraintsDo: [ :c | 
		c vertical fitContent.
		c horizontal fitContent.
		c grid vertical alignCenter ].
	
	formElement addChild: labelElement.
	formElement addChild: anElement.
	^ anElement