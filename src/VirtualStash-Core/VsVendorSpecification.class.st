Class {
	#name : 'VsVendorSpecification',
	#superclass : 'TestCase',
	#category : 'VirtualStash-Core-Receipts-Specification',
	#package : 'VirtualStash-Core',
	#tag : 'Receipts-Specification'
}

{ #category : 'tests' }
VsVendorSpecification >> testMatchName [
	| vendor receipt |
	receipt := VsReceiptDouble new
		addString: 'DUANE reade';
		yourself.
	vendor := MpOrganization new
		name: 'Duane Reade';
		yourself.
	(vendor isVendorFor: receipt) should be: true
]
