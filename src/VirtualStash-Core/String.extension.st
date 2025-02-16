Extension { #name : #String }

{ #category : #'*VirtualStash-Core' }
String >> amountsRecognized [
	| parseResult |
	
	parseResult := (VsMoneyParser new islandInSea) plus parse: self.
	^ parseResult isPetit2Success
		ifTrue: [ parseResult asSet ]
		ifFalse: [ #() ].
		
	"Packaged for GT because not sure if PP2 is guaranteed to be installed in vanilla Pharo"
]
