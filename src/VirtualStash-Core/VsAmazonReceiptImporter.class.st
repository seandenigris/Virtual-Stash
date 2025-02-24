Class {
	#name : #VsAmazonReceiptImporter,
	#superclass : #VsReceiptImporter,
	#category : #'VirtualStash-Core-Receipts'
}

{ #category : #'as yet unclassified' }
VsAmazonReceiptImporter >> amount [

	| input totalLabelLineIdx totalLine |
	input := receipt resource vsAnalysisInput.
	totalLabelLineIdx := input lines
		detectIndex: [ :line | line trimmed = 'Order Total:' ].
	totalLine := input lines at: totalLabelLineIdx + 1.
	^ VsMoneyParser new parse: totalLine trimmed
]

{ #category : #'as yet unclassified' }
VsAmazonReceiptImporter >> appliesTo: aVsReceipt [ 
	
	^ (aVsReceipt resource isKindOf: RlEmail) and: [ aVsReceipt resource senderEmail addressString = 'auto-confirm@amazon.com' ].
]

{ #category : #'as yet unclassified' }
VsAmazonReceiptImporter >> counterparty [

	^ self emailSender
]
