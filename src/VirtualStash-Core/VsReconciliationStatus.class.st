"
Implementation note: Each status gets its own subclass because we didn't understand the domain well yet and classes make it easy to extend and modify all instances at once as our understanding develops.
"
Class {
	#name : #VsReconciliationStatus,
	#superclass : #Object,
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #accessing }
VsReconciliationStatus class >> all [
	^ self allSubclasses collect: [ :e | e new ]
]

{ #category : #accessing }
VsReconciliationStatus class >> fromGnuCashCode: aString [
	| cls |
	cls := self allSubclasses detect: [ :c | c gnuCashCode = aString ].
	^ cls new
]

{ #category : #accessing }
VsReconciliationStatus >> gnuCashCode [
	^ self class gnuCashCode
]
