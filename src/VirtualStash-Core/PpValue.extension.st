Extension { #name : 'PpValue' }

{ #category : '*VirtualStash-Core' }
PpValue >> vsJournal [

	^ VsBooks personal generalJournal iterator
		| [ :t | t ppProjects includes: self ] selectIt
		> VsGeneralJournal
]
