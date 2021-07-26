private
isHighlightingWordAt: aPoint 

	^ self submorphs anySatisfy: [ :e | e bounds containsPoint: aPoint ]