Class {
	#name : 'VsCheckImportRule',
	#superclass : 'VsImportRule',
	#category : 'VirtualStash-Core-Bookkeeping',
	#package : 'VirtualStash-Core',
	#tag : 'Bookkeeping'
}

{ #category : 'examples' }
VsCheckImportRule class >> example [
	<gtExample>
	
	self
		given: 'CHECK 101'
		appliedTo: [ ]
		then: [ :r :t | self assert: t number equals: '101' ]
		andMemoAppendedWith: 'Check'
]

{ #category : 'examples' }
VsCheckImportRule class >> isAbstract [

	^ true
]

{ #category : 'applying' }
VsCheckImportRule >> buildPatchOperations [
	self
		patchSet: #numberDescription to: self memo;
		patchSet: #counterpartyDescription to: nil;
		patchMemoAppend: 'Check'.
]

{ #category : 'accessing' }
VsCheckImportRule >> primaryParser [
	^ 'CHECK' asPParser
]
