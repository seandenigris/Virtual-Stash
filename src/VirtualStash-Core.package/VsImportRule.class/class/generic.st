accessing
generic

	^ MpAddressBook default organizations collect: #vsCounterpartyRule
	
	"Implementation note: these used to be generated from literal pairs so that they were automatically persisted with the code. In the future, if released publicly, this might be a valid strategy to seed the rules with well-known vendors, or perhaps the address book should be so-seeded. Anyway, the current commit before the new system is be4b83be"