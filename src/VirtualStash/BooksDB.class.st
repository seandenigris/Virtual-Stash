"
BooksDB saveRepository.
BooksDB restoreLastBackup.
"
Class {
	#name : #BooksDB,
	#superclass : #SpFileDatabase,
	#category : 'VirtualStash-Persistence'
}

{ #category : #accessing }
BooksDB class >> backupDirectory [

	^ (FileLocator home / 'Dropbox' / 'Pharo Data' / 'Virtual Stash' / self backupDirectoryName) ensureCreateDirectory
]

{ #category : #'class initialization' }
BooksDB class >> initialize [

	self restoreLastBackup.
	self enablePersistence
]

{ #category : #restoring }
BooksDB class >> repositories [

	^ { VsBooks uniqueInstance. VsReceiptFile uniqueInstance }.
]

{ #category : #restoring }
BooksDB class >> restoreRepositories: someRepositories [

	VsBooks restoreFrom: someRepositories first.
	VsReceiptFile restoreFrom: someRepositories second.
]
