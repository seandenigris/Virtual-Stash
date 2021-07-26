accessing
testDollarParsing
	#('$1' '$1.0' '$1.00')
		do: [ :in | self assert: (AmDollar parser matches: in) ].
	#('$a' '$1.' '$.00' '1')
		do: [ :in | self deny: (AmDollar parser matches: in) ]