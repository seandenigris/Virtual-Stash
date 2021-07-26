accessing
transactionsSortedByStringCounterparty
	^ (self transactions select: [ :e | e counterparty isString ] thenCollect: #counterparty) asSet asSortedCollection