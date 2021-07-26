tests
testMultiSplit
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
