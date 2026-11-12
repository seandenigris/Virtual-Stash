Class {
	#name : 'VsOFX',
	#superclass : 'RlResource',
	#category : 'VirtualStash-Core-OFX',
	#package : 'VirtualStash-Core',
	#tag : 'OFX'
}

{ #category : 'accessing' }
VsOFX class >> fileExtensions [
	^ #('ofx' 'qfx' 'qbo')
]

{ #category : 'accessing' }
VsOFX >> asXML [

	| xmlString |
	xmlString := PBApplication start newCommandSourceFactory
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

{ #category : 'accessing' }
VsOFX >> fieldNames [

	^ (self transactionTags asSet flatCollect: [ :e | e elements collect: #name ]) asArray
]

{ #category : 'accessing' }
VsOFX >> pharoizeOFXData: anObject [
	(anObject isKindOf: Dictionary) ifTrue: [
		| type |

		type := anObject at: '$type' ifAbsent: [ nil ].
		
		type = 'Decimal' ifTrue: [
			| coefficient exponent value |
		
			coefficient := (anObject at: 'coefficient') asInteger.
			exponent := anObject at: 'exponent'.
		
			value := exponent < 0
				ifTrue: [
					coefficient / (10 raisedTo: exponent negated) ]
				ifFalse: [
			coefficient * (10 raisedTo: exponent) ].

	^ value asScaledDecimal: (0 max: exponent negated) ].

		type = 'DateAndTime' ifTrue: [
			^ DateAndTime fromString: (anObject at: 'value') ].

		type = 'Date' ifTrue: [
			^ (anObject at: 'value') asDate ].

		anObject keysAndValuesDo: [ :key :value |
			anObject
				at: key
				put: (self pharoizeOFXData: value) ].

		^ anObject ].

	(anObject isKindOf: Array) ifTrue: [
		^ anObject collect: [ :each |
			self pharoizeOFXData: each ] ].

	^ anObject
]

{ #category : 'accessing' }
VsOFX >> rawData [
	| jsonString |

	jsonString := PBApplication start newCommandSourceFactory
		sourceWithResult: '
import json
from datetime import date, datetime, time
from decimal import Decimal
from ofxtools.Parser import OFXTree
from ofxtools.models.base import Aggregate

def typed(value):
    if value is None:
        return None

    if isinstance(value, datetime):
        return {
            "$type": "DateAndTime",
            "value": value.isoformat()
        }

    if isinstance(value, date):
        return {
            "$type": "Date",
            "value": value.isoformat()
        }

    if isinstance(value, time):
        return value.isoformat()

    if isinstance(value, Decimal):
        if not value.is_finite():
            raise ValueError("Non-finite decimal value")

        parts = value.as_tuple()
        coefficient = ("-" if parts.sign else "") + "".join(
            map(str, parts.digits)
        )
        
        return {
            "$type": "Decimal",
            "coefficient": coefficient,
            "exponent": parts.exponent
        }

    if isinstance(value, Aggregate):
        result = {}

        # Every supported singular field and subaggregate.
        for name in value.spec_no_listaggregates:
            field = getattr(value, name, None)
            if field is not None:
                result[name] = typed(field)

        # Every repeated element or subaggregate.
        for member in value:
            if isinstance(member, Aggregate):
                name = type(member).__name__.lower()
            elif value.listelements:
                name = next(iter(value.listelements))
            else:
                raise TypeError("Unexpected aggregate member")

            result.setdefault(name, []).append(typed(member))

        return result

    if isinstance(value, (str, int, float, bool)):
        return value

    raise TypeError("Unrecognized OFX value: " + repr(type(value)))

def raw_tree(element):
    return {
        "tag": element.tag,
        "attributes": dict(element.attrib),
        "text": element.text,
        "children": [raw_tree(child) for child in element]
    }

def reported_date(element, name):
    raw = element.findtext(name)
    if not raw:
        raise ValueError("Missing " + name)

    return {
        "$type": "Date",
        "value": datetime.strptime(
            raw[:8], "%Y%m%d"
        ).date().isoformat()
    }

parser = OFXTree()
parser.parse(myFilename)
ofx = parser.convert()

periods = []

for element in parser.findall(".//BANKTRANLIST"):
    periods.append({
        "start": reported_date(element, "DTSTART"),
        "endExclusive": reported_date(element, "DTEND"),
        "startRaw": element.findtext("DTSTART"),
        "endRaw": element.findtext("DTEND")
    })

result = {
    "header": {
        k: typed(v)
        for k, v in vars(parser.header).items()
    },
    "document": typed(ofx),
    "rawBody": raw_tree(parser.getroot()),
    "statements": [
        typed(stmt) for stmt in ofx.statements
    ],
    "searchPeriods": periods
}

json.dumps(result, ensure_ascii=False)
';
		bindingAt: #myFilename put: self file fullName;
		sendAndWait.

	^ self pharoizeOFXData: (STONJSON fromString: jsonString)

]

{ #category : 'accessing' }
VsOFX >> searchPeriod [
	| period |

	period := ((self rawData) at: 'searchPeriods') first.

	^ (period at: 'start') -> (period at: 'endExclusive')
]

{ #category : 'accessing' }
VsOFX >> transactionDictionaries [

	^ self transactionTags collect: [ :tag |
		tag nodes
			inject: Dictionary new
			into: [ :col :e |
				col 
					at: e name put: e contentString;
					yourself ] ]
]

{ #category : 'accessing' }
VsOFX >> transactionTags [ 

	^ (self asXML // #STMTTRN) asOrderedCollection.
]

{ #category : 'as yet unclassified' }
VsOFX >> transactionsForAccount: anAccount in: aBooks imbalanceTo: imbalanceAccount [

	^ VsOfxTransactionImporter new
		account: anAccount;
		books: aBooks;
		imbalanceAccount: imbalanceAccount;
		source: self;
		execute
]

{ #category : 'accessing' }
VsOFX >> transactionsViaJson [
	| transactions |

	transactions := OrderedCollection new.

	((self rawData) at: 'statements') do: [ :statement |
		| transactionList |

		transactionList := statement
			at: 'banktranlist'
			ifAbsent: [ nil ].

		transactionList ifNotNil: [
			transactions addAll: (
				transactionList
					at: 'stmttrn'
					ifAbsent: [ #() ]) ] ].

	^ transactions asArray
]
