Class {
	#name : #VsOFX,
	#superclass : #RlResource,
	#category : #'VirtualStash-Core'
}

{ #category : #accessing }
VsOFX class >> fileExtensions [
	^ #('ofx' 'qfx' 'qbo')
]

{ #category : #accessing }
VsOFX >> asXML [

	| xmlString |
	xmlString := PBApplication uniqueInstance newCommandSourceFactory
		sourceWithResult: '# Convert QFX v. 1 (SGML) to XML
# as suggested by https://stackoverflow.com/questions/12505419/parse-sgml-with-open-arbitrary-tags-in-python-3

# Parse QFX - adapted from https://ofxtools.readthedocs.io/en/latest/parser.html
from ofxtools.Parser import OFXTree
parser = OFXTree()
parser.parse(myFilename)
ofx = parser.convert()

# Export to XML - adapted from https://ofxtools.readthedocs.io/en/latest/generating.html
import xml.etree.ElementTree as ET
root = ofx.to_etree()
ET.tostring(root).decode()';
	bindingAt: #myFilename put: self file fullName;
	sendAndWait.
	
	^ XMLDOMParser parse: xmlString
]

{ #category : #accessing }
VsOFX >> fieldNames [

	^ (self transactionTags asSet flatCollect: [ :e | e elements collect: #name ]) asArray
]

{ #category : #accessing }
VsOFX >> transactionDictionaries [

	^ self transactionTags collect: [ :tag |
		tag nodes
			inject: Dictionary new
			into: [ :col :e |
				col 
					at: e name put: e contentString;
					yourself ] ]
]

{ #category : #accessing }
VsOFX >> transactionTags [ 

	^ (self asXML // #STMTTRN) asOrderedCollection.
]
