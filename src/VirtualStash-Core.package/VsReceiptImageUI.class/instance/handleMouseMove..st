event handling
handleMouseMove: anEvent
	"Purpose: We want to handle events with no buttons pressed, but by default Morphic only fires #mouseMove: if a mouse a button is down"

	"Without the following line, mouse events are processed even if e.g. a window is dragged over me!"
	(anEvent hand hasSubmorphs) ifTrue: [ ^self ].
	
	^ self mouseMove: anEvent