private
showContextMenu

	| menu possibleVendor |
	menu := UIManager default newMenuIn: self for: self receipt.
	
	possibleVendor := self receipt possibleVendors.
	menu add: 'Make ', possibleVendor name, ' vendor' selector: #vendor: argument: possibleVendor.
	menu add: 'Enter as personal' selector: #enterAsPersonal.
	menu popUpEvent: self activeHand lastEvent in: self world.