Class {
	#name : 'VsOnlinePaymentImportRule',
	#superclass : 'VsImportRule',
	#category : 'VirtualStash-Core-Bookkeeping',
	#package : 'VirtualStash-Core',
	#tag : 'Bookkeeping'
}

{ #category : 'examples' }
VsOnlinePaymentImportRule class >> example [
	<gtExample>
	
	^ self
		given: 'Online Payment 1234567890 To ABC'
		appliedTo: [ ]
		then: [ :r :t | self assert: t counterparty isNil ]
		andMemoAppendedWith: '1234567890 To ABC'
]

{ #category : 'accessing' }
VsOnlinePaymentImportRule >> buildPatchOperations [
	self
		patchMemoAppend: self memo;
		patchSet: #counterpartyDescription to: nil 
]

{ #category : 'as yet unclassified' }
VsOnlinePaymentImportRule >> parser [
	^ self primaryParser, self separatorParser, self extraInfoParser end
]

{ #category : 'accessing' }
VsOnlinePaymentImportRule >> primaryParser [
	^ 'Online Payment' asPParser
]
