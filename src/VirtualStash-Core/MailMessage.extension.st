Extension { #name : #MailMessage }

{ #category : #'*VirtualStash-Core' }
MailMessage >> vsAnalysisInput [
	
	^ self bodyRlHtml 
		ifNotNil: [ :html | html vsAnalysisInput ]
		ifNil: [ self bodyTextFormatted ]
]
