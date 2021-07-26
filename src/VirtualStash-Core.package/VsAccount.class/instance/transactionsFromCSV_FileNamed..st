utilities
transactionsFromCSV_FileNamed: aString
	| csvFile |
	csvFile := self rootFolder / 'Exports' / aString.
	^ (self class maCSVImporter: VsTransactionImporter) importFile: csvFile.