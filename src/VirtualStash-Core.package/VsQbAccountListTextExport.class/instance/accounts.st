as yet unclassified
accounts

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