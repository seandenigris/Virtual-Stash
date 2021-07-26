magritte-accessing
splitsDescription
	<magritteDescription>
	"On naming... Also seems to be called ==entries== in some accounting software. We chose ==splits== because it is more specific and therefor intention revealing e.g. can't be confused with journal entries, which is somewhat related, but different"
	^ MAToManyRelationDescription new
			accessor: #splits;
			default: OrderedCollection new;
			classes: { VsSplit };
			initializer: [ :inst | 
				inst
					accountSource: self accountSource;
					amount: self uncategorizedAmount ];
			priority: 400;
			yourself