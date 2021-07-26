accessing
addressBook
	"Hook for testing so we don't pollute the default AddressBook"
	^ addressBook ifNil: [ MpAddressBook default ]