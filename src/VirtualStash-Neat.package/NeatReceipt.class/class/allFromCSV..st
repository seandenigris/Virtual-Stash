examples
allFromCSV: file
	| reader |
	^ file readStreamDo: [ :rs | 
			reader := NeoCSVReader on: rs.
			reader
				recordClass: NeatReceipt;
				skipHeader;
				addField: #vendor:;
			  addField: #date: converter: [ :string | | withoutWeekday |
					withoutWeekday := string copyAfter: Character space.
					Date fromString: withoutWeekday ];
			  addFloatField: #amount:;
				addField: #paymentType:;
				addField: #category:;
				addField: #notes:;
				addIntegerField: #fileSize:;
			  upToEnd ].