as yet unclassified
fromImagesIn: directory

	| images |
	images := directory filesMatching: '*.jpg'.
	^ images collect: [ :e | self new imageFile: e ].