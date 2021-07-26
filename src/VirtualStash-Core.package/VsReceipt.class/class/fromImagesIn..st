as yet unclassified
fromImagesIn: directory

	| images |
	images := directory filesMatching: '*.jpg'.
	^ self fromFiles: images