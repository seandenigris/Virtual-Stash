magritte-accessing
memoDescription
	"The term 'memo' seems to be the industry standard. a.k.a. 'notes' (also a good name) and 'description', which we ruled out to avoid confusion because GnuCash uses it as a poor-man's 'payee' field"
	<magritteDescription>
	^ MAMemoDescription new
		accessor: #memo;
		priority: 300;
		default: '';
		yourself