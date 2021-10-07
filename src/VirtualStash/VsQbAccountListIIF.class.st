Class {
	#name : #VsQbAccountListIIF,
	#superclass : #Object,
	#instVars : [
		'name',
		'type',
		'balance'
	],
	#category : 'VirtualStash-QuickBooks'
}

{ #category : #'as yet unclassified' }
VsQbAccountListIIF class >> on: aFileReference [

	^ self
			file: aFileReference;
			yourself.
]

{ #category : #'as yet unclassified' }
VsQbAccountListIIF >> accounts [

		| reader |
	FileStream fileNamed: '/Users/sean/Desktop/Quickbooks Accounts.iif' do: [ :file |
		reader := NeoCSVReader on: file.
		reader
			skipHeader;
			skipHeader;
			skipHeader;
			separator: Character tab;
			recordClass: VsQuickbooksAccount;
			addIgnoredField;
			addField: #name:;
			addIgnoredField;
			addIgnoredField;
			addField: #type: converter: [ :str | VsQbAccountType onIIF: str ];
			addFloatField: #balance:;
			addIgnoredField;
			addIgnoredField;
			addIgnoredField;
			addIgnoredField.
		^ reader upToEnd.
		 ].
]
