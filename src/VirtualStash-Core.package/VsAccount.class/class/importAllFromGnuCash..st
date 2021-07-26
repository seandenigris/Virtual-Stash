importing
importAllFromGnuCash: csvFile
	^ (self maCSVImporter: VsAccountImporter) importFile: csvFile.