as yet unclassified
accounts

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