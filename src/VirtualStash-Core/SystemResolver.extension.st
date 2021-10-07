Extension { #name : #SystemResolver }

{ #category : #'*VirtualStash-Core' }
SystemResolver >> virtualStashData [ 
	<origin>
	^ (FileLocator dynabookData / 'Virtual Stash') resolve
]
