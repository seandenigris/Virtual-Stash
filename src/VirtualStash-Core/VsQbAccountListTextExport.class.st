Class {
	#name : #VsQbAccountListTextExport,
	#superclass : #Object,
	#instVars : [
		'name',
		'type',
		'balance',
		'file'
	],
	#category : 'VirtualStash-Core-QuickBooks'
}

{ #category : #'as yet unclassified' }
VsQbAccountListTextExport class >> on: aFileReference [

	^ self
			file: aFileReference;
			yourself.
]

{ #category : #'as yet unclassified' }
VsQbAccountListTextExport >> accounts [

	| reader |
	FileStream fileNamed: file do: [ :file |
		reader := NeoCSVReader on: file.
		reader
			readNextRecordAsArray; "skip header"
			recordClass: VsQuickbooksAccount;
			addField: #name:;
			addField: #type: converter: [ :str | VsQbAccountType on: str ];
			addFloatField: #balance:.
		^ reader upToEnd.
		 ].
]

{ #category : #'as yet unclassified' }
VsQbAccountListTextExport >> initialize [

	super initialize.
	file := '/Users/sean/Desktop/Quickbooks Accounts.csv'.
]
