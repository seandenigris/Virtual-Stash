Class {
	#name : #VsCheckImportRule,
	#superclass : #VsImportRule,
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #examples }
VsCheckImportRule class >> example [
	<gtExample>
	
	self
		given: 'CHECK 101'
		appliedTo: [ ]
		then: [ :r :t | self assert: t number equals: '101' ]
		andMemoAppendedWith: 'Check'
]

{ #category : #applying }
VsCheckImportRule >> buildPatchOperations [
	self
		patchSet: #numberDescription to: self memo;
		patchSet: #counterpartyDescription to: nil;
		patchMemoAppend: 'Check'.
]

{ #category : #accessing }
VsCheckImportRule >> primaryParser [
	^ 'CHECK' asPParser
]
