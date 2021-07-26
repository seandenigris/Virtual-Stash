private
executable

	| homebrewLocation macPortsLocation |
	homebrewLocation := '/usr/local/bin/tesseract' asFileReference.
	homebrewLocation exists ifTrue: [ ^ homebrewLocation ].
	
	macPortsLocation := '/opt/local/bin/tesseract' asFileReference.
	macPortsLocation exists ifTrue: [ ^ macPortsLocation ].
	
	^ self error: 'Tesseract not installed!'.