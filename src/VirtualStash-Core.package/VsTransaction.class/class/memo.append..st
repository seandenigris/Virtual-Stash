as yet unclassified
memo: aString append: anotherString

	^ String streamContents: [ :s |
		aString ifNotEmpty: [ :m | 
			s nextPutAll: m; nextPutAll: '; ' ].
		s nextPutAll: anotherString ].