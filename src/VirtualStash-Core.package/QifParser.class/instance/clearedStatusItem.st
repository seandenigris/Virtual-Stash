rules
clearedStatusItem
	^ self detailItemCode: $C do: [ :e |
		e = ''
			ifTrue: [ 'nc' ]
			ifFalse: [ (e = '*' or: [ e = 'c' ]) 
				ifTrue: [ 'c' ]
				ifFalse: [ (e = 'X' or: [ e = 'R' ])
					ifTrue: [ 'r' ] ] ] ].