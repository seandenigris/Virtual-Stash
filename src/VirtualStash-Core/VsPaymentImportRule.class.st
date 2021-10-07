Class {
	#name : #VsPaymentImportRule,
	#superclass : #VsImportRule,
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #examples }
VsPaymentImportRule class >> example [
	"<gtExample>"
	
	^ self
		given: 'Payment Thank You - Web'
		appliedTo: [ ]
		then: [ :r :t | self assert: t counterparty isNil ]
		andMemoAppendedWith: '1234567890 To ABC'
]

{ #category : #accessing }
VsPaymentImportRule >> buildPatchOperations [
	self patchSet: #processorDescription to: self credit account issuer.
	self error: 'to fully process this, we need access to *all* transactions so we can find the one on the other side'
]

{ #category : #testing }
VsPaymentImportRule >> primaryParser [

	^ self primaryParserFromOptions: #(
		'Autopay Thank You'
		'AUTOMATIC PAYMENT - THANK'
		'Payment Thank You - Web'
		'Payment to Chase card ending in' )
]
