examples
importFromCSV: file
	"Neat claims to have export capability, but in fact your data is locked in the applicated because you can access your files, and you can access your meta info, but you can't associate one to the other. For example, if I can export the vendor, date, and amount to CSV, and see the folder where the libraray stores all the PDFs, but don't have the filename! But... we are smarter than them :) They do give the file size, which is fairly unique (no duplicates in 1877 real receipts tested)"

	| receipts |
	receipts := NeatReceipt allFromCSV: file.
	self findFilesFor: receipts.
	^ receipts