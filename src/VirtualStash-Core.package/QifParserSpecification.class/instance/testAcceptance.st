tests
testAcceptance
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