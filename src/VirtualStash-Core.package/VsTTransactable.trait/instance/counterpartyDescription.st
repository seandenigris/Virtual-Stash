magritte-accessing
counterpartyDescription
	
	<magritteDescription>
	^ MASingleOptionDescription new
			accessor: #counterparty;
			options: MpAddressBook default contacts;
			priority: 300;
			comment: 'Often called the ==payee== in accounting software, but this is misleading. The payee of a refund is the user, but is that really what we want to know? No! GnuCash gives up altogether and puts a free-form ==description== field where the ==payee== usually goes. Counterparty is the most precise term, meaning the entity on the other side of the transaction.';
			yourself