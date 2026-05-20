"
Adapted from `InternationalSystemOfUnits`
"
Class {
	#name : 'VsUnits',
	#superclass : 'Object',
	#classVars : [
		'Units'
	],
	#category : 'VirtualStash-Core',
	#package : 'VirtualStash-Core'
}

{ #category : 'convenience' }
VsUnits class >> named: aSymbol [

	^ self units >> aSymbol
]

{ #category : 'instance creation' }
VsUnits class >> quantity: aNumber of: aSymbolOrUnit [
	
	| unit |
	unit := aSymbolOrUnit isSymbol
		ifTrue: [ self named: aSymbolOrUnit ]
		ifFalse: [ aSymbolOrUnit ].
		
	^ unit * aNumber
]

{ #category : 'persistence' }
VsUnits class >> restoreFrom: anObject [

	Units := anObject.
]

{ #category : 'persistence' }
VsUnits class >> spData [

	^ Units
]

{ #category : 'accessing' }
VsUnits class >> units [

  | usd usCent |
  Units ifNotNil: [ ^ Units ].
  
  Units := Namespace new.
  
  usd := UnitOfAccount on: 'USD' symbol: '$'.
  Units bind: #dollar to: usd.
  
  usCent := MultipleUnitOfMeasure
    basedOn: usd
    singularNamed: 'cent'
    pluralNamed: 'cents'
    symbol: 'c'
    raisedTo: -2.
   Units bind: #cent to: usCent.
  
  ^ Units.
  
  "Implementation note: adapted from:
  	- InternationalSystemOfUnits class>>#initializeBit
  	- UnitOfAccountTest>>setUp"
]
