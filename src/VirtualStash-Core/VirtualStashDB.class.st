"
```smalltalk
self saveRepository.
```
```smalltalk
self restoreLastBackup.
```

"
Class {
	#name : #VirtualStashDB,
	#superclass : #SpFileDatabase,
	#category : 'VirtualStash-Core-Persistence'
}

{ #category : #accessing }
VirtualStashDB class >> backupDirectoryParent [

	^ FileLocator virtualStashData
]

{ #category : #'world menu' }
VirtualStashDB class >> menuCommandOn: aBuilder [  
	<worldMenu>
	(aBuilder item: #'Virtual Stash')
		with: [
			(aBuilder item: #'Inspect DB')
				order: 1.0;
				action: [ self spData inspect ].
			(aBuilder item: #'Open Receipt Browser')
				order: 2.0;
				action: [ VsReceiptBrowser open ] ].
]

{ #category : #accessing }
VirtualStashDB class >> schema [

	^ { 
			MyPeopleDB.
			ResourcesLiveDB.
			VsBooks.
			VsPaymentMethod.
			VsPre2013Books
		}.
]
