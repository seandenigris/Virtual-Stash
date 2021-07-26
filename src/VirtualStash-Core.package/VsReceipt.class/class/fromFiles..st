as yet unclassified
fromFiles: files

	^ files collect: [ :e | 
			self new
				importFile: e;
				yourself ].