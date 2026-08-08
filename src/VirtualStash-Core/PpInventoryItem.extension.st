Extension { #name : 'PpInventoryItem' }

{ #category : '*VirtualStash-Core' }
PpInventoryItem >> vsJournal [

	^ VsBooks personal generalJournal iterator
		| [ :t | 
			(t subjects includes: self) 
				or: [ t ppValues includes: self ] ] selectIt
		> VsGeneralJournal
]
