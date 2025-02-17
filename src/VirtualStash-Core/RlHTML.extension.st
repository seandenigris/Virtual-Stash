Extension { #name : #RlHTML }

{ #category : #'*VirtualStash-Core' }
RlHTML >> vsAnalysisInput [
	"Return 'just the plain text the user would see if rendered'"

	^ PBApplication uniqueInstance newCommandStringFactory
		bindingAt: #htmlString put: self contents;
		script: 'import html2text
text_maker = html2text.HTML2Text()
text_maker.ignore_links = True
text_maker.ignore_images = True
text_maker.ignore_tables = True
text_maker.ignore_emphasis = True';
		resultExpression: 'text_maker.handle(htmlString)';
		sendAndWait	
		
	"Reference: https://github.com/Alir3z4/html2text/blob/master/docs/usage.md#using-options"
]
