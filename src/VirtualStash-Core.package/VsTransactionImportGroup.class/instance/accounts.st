accessing
accounts
	^ (self transactions flatCollect: [ :e | e splits collect: #account ]) asSet