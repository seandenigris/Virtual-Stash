Trait {
	#name : #VsTTransactable,
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #'magritte-accessing' }
VsTTransactable >> counterpartyDescription [
	
	<magritteDescription>
	^ MASingleOptionDescription new
			accessor: #counterparty;
			options: MpAddressBook default contacts;
			priority: 300;
			comment: 'Often called the ==payee== in accounting software, but this is misleading. The payee of a refund is the user, but is that really what we want to know? No! GnuCash gives up altogether and puts a free-form ==description== field where the ==payee== usually goes. Counterparty is the most precise term, meaning the entity on the other side of the transaction.';
			yourself
]

{ #category : #'magritte-accessing' }
VsTTransactable >> dateDescription [
	<magritteDescription>

	^ MADateDescription new
			accessor: #date;
			display: #mmddyyyy;
			beRequired;
			priority: 100;
			yourself
]

{ #category : #'magritte-accessing' }
VsTTransactable >> numberDescription [
	"Also called a 'reference number' e.g. in Quickbooks, or `reference` but we stick with the simplest term that conveys the meaning (also ==reference== could be confusing since we're heavily using Magritte"
	<magritteDescription>
	^ MAStringDescription new
		accessor: #number;
		priority: 200;
		yourself
]
