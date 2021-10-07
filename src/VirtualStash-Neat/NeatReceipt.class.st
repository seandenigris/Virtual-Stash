Class {
	#name : #NeatReceipt,
	#superclass : #Object,
	#instVars : [
		'vendor',
		'date',
		'amount',
		'paymentType',
		'category',
		'notes',
		'fileSize',
		'file'
	],
	#category : 'VirtualStash-Neat'
}

{ #category : #examples }
NeatReceipt class >> allFromCSV: file [
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
]

{ #category : #examples }
NeatReceipt class >> findFilesFor: receiptCollection [
	[ :job |
	receiptCollection doWithIndex: [ :e :i | 
		job progress: i / receiptCollection size.
		e findFile ] ] asJob run
]

{ #category : #examples }
NeatReceipt class >> importFromCSV: file [
	"Neat claims to have export capability, but in fact your data is locked in the applicated because you can access your files, and you can access your meta info, but you can't associate one to the other. For example, if I can export the vendor, date, and amount to CSV, and see the folder where the libraray stores all the PDFs, but don't have the filename! But... we are smarter than them :) They do give the file size, which is fairly unique (no duplicates in 1877 real receipts tested)"

	| receipts |
	receipts := NeatReceipt allFromCSV: file.
	self findFilesFor: receipts.
	^ receipts
]

{ #category : #accessing }
NeatReceipt >> amount [
	^ amount
]

{ #category : #accessing }
NeatReceipt >> amount: anObject [
	amount := anObject
]

{ #category : #'as yet unclassified' }
NeatReceipt >> asVsReceipt [
	"Skip payment type (which doesn't seem to be consistently correct in Neat), category (which is meaningless), and note (which there's only a handful of)"
	^ VsReceipt new
			vendor: self vendor;
			amount: self amount;
			date: self date;
			importFile: self file moving: false;
			yourself
]

{ #category : #accessing }
NeatReceipt >> category [
	^ category
]

{ #category : #accessing }
NeatReceipt >> category: anObject [
	category := anObject
]

{ #category : #accessing }
NeatReceipt >> date [
	^ date
]

{ #category : #accessing }
NeatReceipt >> date: anObject [
	date := anObject
]

{ #category : #accessing }
NeatReceipt >> file [
	^ file
]

{ #category : #accessing }
NeatReceipt >> file: anObject [
	file := anObject
]

{ #category : #accessing }
NeatReceipt >> fileSize [
	^ fileSize
]

{ #category : #accessing }
NeatReceipt >> fileSize: anObject [
	fileSize := anObject
]

{ #category : #actions }
NeatReceipt >> findFile [
	| neatLibraryFolder matches |
	neatLibraryFolder := FileLocator documents / 'Neat Library.nrmlib'.
	matches := neatLibraryFolder files select: [ :e | e size = self fileSize ].
	self assert: matches size = 1 description: 'Two files in Neat Library with same size!'. "I did a test on a real library with 1877 files and they all had distinct sizes, so we should be okay"
	file := matches first.
]

{ #category : #accessing }
NeatReceipt >> notes [
	^ notes
]

{ #category : #accessing }
NeatReceipt >> notes: anObject [
	notes := anObject
]

{ #category : #accessing }
NeatReceipt >> paymentType [
	^ paymentType
]

{ #category : #accessing }
NeatReceipt >> paymentType: anObject [
	paymentType := anObject
]

{ #category : #accessing }
NeatReceipt >> vendor [
	^ vendor
]

{ #category : #accessing }
NeatReceipt >> vendor: anObject [
	vendor := anObject
]
