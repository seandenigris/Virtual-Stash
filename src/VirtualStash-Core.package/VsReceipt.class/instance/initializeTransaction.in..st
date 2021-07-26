magritte
initializeTransaction: transaction in: books

	| entry |
	entry := VsSplit new
		account: self paymentMethod;
		amount: self amount;
		accountSource: books.
	transaction
		date: self date;
		counterparty: self vendor;
		receipt: self;
		accountSource: books.
	transaction entries add: entry