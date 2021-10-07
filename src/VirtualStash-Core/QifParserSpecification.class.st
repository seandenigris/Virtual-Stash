Class {
	#name : #QifParserSpecification,
	#superclass : #TestCase,
	#category : 'VirtualStash-Core-QIF'
}

{ #category : #helpers }
QifParserSpecification >> rule: selector parse: aString shouldEqual: anObject [
	| parser result |
	parser := QifParser new perform: selector.
	result := parser end parse: aString, Character cr asString.
	result should equal: anObject
]

{ #category : #tests }
QifParserSpecification >> testAcceptance [
	| parser result input |
	input := '!Type:CCard
D9/7''2005
CX
MCancelled account airtime
T-10.13
PCingular
L[Landscaping Reimbursible Expense]
^
D5/13''2004
CX
M013457946 GROCERIES/SUNDRIES
T-149.93
PStop & Shop
LGroceries
SGroceries
E013457946 GROCERIES/SUNDRIES
$-74.97
S[Cash]
$-74.96
^'.
	parser := QifParser new.
	result := parser parse: input
]

{ #category : #tests }
QifParserSpecification >> testAccount [
	self
		rule: #accountItem
		parse: 'L[Landscaping Reimbursible Expense]'
		shouldEqual: 'Landscaping Reimbursible Expense'.
	self
		rule: #accountItem
		parse: 'LTravel-Vacation:Lodging'
		shouldEqual: 'Travel-Vacation:Lodging'.
]

{ #category : #tests }
QifParserSpecification >> testAmount [
	self
		rule: #amountItem
		parse: 'T-2,738.26'
		shouldEqual: -2738.26.

]

{ #category : #tests }
QifParserSpecification >> testClearedStatus [
	self rule: #clearedStatusItem parse: 'C' shouldEqual: 'nc'.
	self rule: #clearedStatusItem parse: 'C*' shouldEqual: 'c'.
	self rule: #clearedStatusItem parse: 'Cc' shouldEqual: 'c'.
	self rule: #clearedStatusItem parse: 'CX' shouldEqual: 'r'.
	self rule: #clearedStatusItem parse: 'CR' shouldEqual: 'r'
]

{ #category : #tests }
QifParserSpecification >> testDate [
	self
		rule: #dateItem
		parse: 'D1/30''2004'
		shouldEqual: '1/30/2004' asDate
]

{ #category : #tests }
QifParserSpecification >> testDetail [
	| parser result input |
	input := 'D9/7''2005
CX
MCancelled account airtime
N409562
T-10.13
PCingular
L[Landscaping Reimbursible Expense]
^'.
	parser := QifParser new detail end.
	result := parser parse: input.
	result isPetitFailure should beFalse
]

{ #category : #helpers }
QifParserSpecification >> testDetail: aString [
	| parser result |

	parser := QifParser new detail end.
	result := parser parse: aString.
	result isPetitFailure should beFalse
]

{ #category : #tests }
QifParserSpecification >> testDetailEmptySplit [
	"We will not support empty account names"
	<expectedFailure>
	| input |
	input := 'D2/7''2010
CX
T-62.16
PA&P
LFirehouse:Meals
SFirehouse:Meals
$-9.00
S[Cash]
$-53.16
S
$0.00
^'.
	self testDetail: input
]

{ #category : #tests }
QifParserSpecification >> testMemo [
	self
		rule: #memoItem
		parse: 'MPAY AT PUMP2339483498349'
		shouldEqual: 'PAY AT PUMP2339483498349'
]

{ #category : #tests }
QifParserSpecification >> testMultiSplit [
	self
		rule: #splits
		parse: 'SHobbies-Leisure:Entertaining
ELounge w. friends
$-61.21
SGifts
EBottle of wine
$-29.00'
		shouldEqual: {
			{ 'Hobbies-Leisure:Entertaining'. 'Lounge w. friends'. -61.21 }. 
			{ 'Gifts'. 'Bottle of wine'. -29.00 } }.

]

{ #category : #tests }
QifParserSpecification >> testPayee [
	self
		rule: #payeeItem
		parse: 'PAmerican Express'
		shouldEqual: 'American Express'
]

{ #category : #tests }
QifParserSpecification >> testSplit [
	self
		rule: #split
		parse: 'SPersonal Care
Etoothpaste
$-3.38'
		shouldEqual: { 'Personal Care'. 'toothpaste'. -3.38 }.

]

{ #category : #tests }
QifParserSpecification >> testSplitAccount [
	self
		rule: #splitAccountItem
		parse: 'S[Landscaping Reimbursible Expense]'
		shouldEqual: 'Landscaping Reimbursible Expense'.
	self
		rule: #splitAccountItem
		parse: 'STravel-Vacation:Lodging'
		shouldEqual: 'Travel-Vacation:Lodging'.
]

{ #category : #tests }
QifParserSpecification >> testSplitAmount [
	self
		rule: #splitAmountItem
		parse: '$-2,738.26'
		shouldEqual: -2738.26.

]

{ #category : #tests }
QifParserSpecification >> testSplitMemo [
	self
		rule: #splitMemoItem
		parse: 'Etoothpaste'
		shouldEqual: 'toothpaste'
]
