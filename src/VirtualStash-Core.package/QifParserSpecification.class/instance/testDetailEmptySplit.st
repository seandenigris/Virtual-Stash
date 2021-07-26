tests
testDetailEmptySplit
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