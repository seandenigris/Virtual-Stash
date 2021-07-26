tests
testClearedStatus
	self rule: #clearedStatusItem parse: 'C' shouldEqual: 'nc'.
	self rule: #clearedStatusItem parse: 'C*' shouldEqual: 'c'.
	self rule: #clearedStatusItem parse: 'Cc' shouldEqual: 'c'.
	self rule: #clearedStatusItem parse: 'CX' shouldEqual: 'r'.
	self rule: #clearedStatusItem parse: 'CR' shouldEqual: 'r'