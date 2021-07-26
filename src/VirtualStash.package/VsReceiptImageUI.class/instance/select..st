as yet unclassified
select: aHocrLine 

	| target |
	target := self submorphThat: [ :e | e containsPoint: self topLeft + aHocrLine boundingBox center ] ifNone: [ self error: 'no hocr line at point' ].
	selection ifNotNil: [ selection borderColor: Color black ].
	selection := target.
	target borderColor: Color pink.