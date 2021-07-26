private
printOn: aStream

	aStream nextPutAll: '[', date asString, '] ', amount asString, ' for ', description, ' (', category, ')'