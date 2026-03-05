Extension { #name : 'RlPDF' }

{ #category : '*VirtualStash-Core' }
RlPDF >> vsAnalysisInput [

	^ self ocr
]

{ #category : '*VirtualStash-Core' }
RlPDF >> vsImageResource [
	^ self imageResource
]
