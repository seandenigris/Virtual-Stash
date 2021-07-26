accessing
boundingBox

	| propertiesString tokens |
	propertiesString := xmlElement attributeAt: 'title'.
	tokens := Character space split: propertiesString.
	tokens first = 'bbox' ifFalse: [ self error: 'missing bbox tag' ].
	^ Rectangle left: tokens second asNumber right: tokens fourth asNumber top: tokens third asNumber bottom: tokens fifth asNumber. 