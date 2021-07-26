as yet unclassified
importFile: file moving: aBoolean

	| r |
	r := RlResourceLibrary uniqueInstance import: file into: Path workingDirectory moving: aBoolean.
	self resource: r