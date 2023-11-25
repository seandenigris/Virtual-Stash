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
VsOFX >> transactionTags [ 

	^ (self asXML // #STMTTRN) asOrderedCollection.
]

{ #category : #accessing }
VsOFX >> transactionsIn: anAccount withImbalance: imbalanceAccount [

	^ self transactionTags collect: [ :e | 
		| transaction split imbalanceSplit |
		split := VsSplit new
			amount: (e elementAt: 'TRNAMT') contentString dollars;
			account: anAccount;
			yourself.
			
		imbalanceSplit := VsSplit new
			amount: (e elementAt: 'TRNAMT') contentString dollars negated;
			account: imbalanceAccount;
			yourself.
			
		transaction := VsTransaction new
			date: (VsOfxDatetimeParser parse: (e elementAt: 'DTPOSTED') contentString) asDate;
			propertyAt: 'ofxFITID' put: (e elementAt: 'FITID') contentString asNumber;
			propertyAt: 'ofxTRNTYPE' put: (e elementAt: 'TRNTYPE') contentString;
			number: ((e elementAt: 'CHECKNUM') ifNotNil: #contentString);
			importedName: (e elementAt: 'NAME') contentString;
			memo: ((e elementAt: 'MEMO') ifNotNil: #contentString);
			yourself.
			
		transaction splits 
			add: split;
			add: imbalanceSplit.
		transaction ]
]
