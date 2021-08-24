accessing
convertToDomainObjects: aCollectionOfDictionaries
	^ aCollectionOfDictionaries
		inject: OrderedCollection new
		into: [ :col :rowDict | 
			| newTransaction split recordedTransaction |
			newTransaction := VsTransaction new
				accountSource: books;
				yourself.
			self initializeTransaction: newTransaction fromRecord: rowDict.
			split := VsSplit new
				accountSource: books;
				yourself.
			self initializeDomainObject: split fromRecord: rowDict.
			recordedTransaction := newTransaction isValid
				ifTrue: [ col add: newTransaction ]
				ifFalse: [ col last ].
			recordedTransaction splits add: split.
			col ]