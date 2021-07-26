accessing
todos
	| todos todoStringSet dashboard |
	todos := entries select: [ :e | e counterparty isKindOf: VsImportName ].
	todoStringSet := todos collect: #counterparty as: Set.
	dashboard := todoStringSet
		collect: [ :s | 
			| effected |
			effected := todos select: [ :t | t counterparty = s ].
			VsTransactionImportGroup new
				transactions: effected;
				yourself ].
	^ dashboard asOrderedCollection sort: #size descending