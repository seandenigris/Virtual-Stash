testing
primaryParserFromOptions: aCollectionOfStrings

	^ aCollectionOfStrings 
		inject: PP2FailingNode instance 
		into: [ :result :str | result / str asPParser ]