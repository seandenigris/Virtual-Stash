accessing
addressBook

	^ addressBook ifNil: [ addressBook := MpAddressBook default ]