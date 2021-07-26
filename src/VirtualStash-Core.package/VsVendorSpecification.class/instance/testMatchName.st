tests
testMatchName
	| vendor receipt |
	receipt := VsReceiptDouble new
		addString: 'DUANE reade';
		yourself.
	vendor := MpOrganization new
		name: 'Duane Reade';
		yourself.
	(vendor isVendorFor: receipt) should be: true