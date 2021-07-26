tests
testDetail
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