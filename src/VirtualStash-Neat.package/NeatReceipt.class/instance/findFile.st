actions
findFile
	| neatLibraryFolder matches |
	neatLibraryFolder := FileLocator documents / 'Neat Library.nrmlib'.
	matches := neatLibraryFolder files select: [ :e | e size = self fileSize ].
	self assert: matches size = 1 description: 'Two files in Neat Library with same size!'. "I did a test on a real library with 1877 files and they all had distinct sizes, so we should be okay"
	file := matches first.