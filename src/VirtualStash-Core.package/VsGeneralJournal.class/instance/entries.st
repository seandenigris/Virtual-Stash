accessing
entries

	^ entries ifNil: [ entries := SortedCollection sortUsing: #date asSortFunction ]