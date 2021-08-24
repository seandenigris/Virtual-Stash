importing
importAllFromGnuCash: csvFile
	^ (self maCSVImporter: VsAccountImporter)
		source: csvFile;
		execute.