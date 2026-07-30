Extension { #name : 'PpValue' }

{ #category : '*VirtualStash-Core' }
PpValue >> vsJournal [

	^ VsBooks personal generalJournal iterator
		| [ :t | t ppValues includes: self ] selectIt
		> VsGeneralJournal
]
