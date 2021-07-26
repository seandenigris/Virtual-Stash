as yet unclassified
asVsReceipt
	"Skip payment type (which doesn't seem to be consistently correct in Neat), category (which is meaningless), and note (which there's only a handful of)"
	^ VsReceipt new
			vendor: self vendor;
			amount: self amount;
			date: self date;
			importFile: self file moving: false;
			yourself