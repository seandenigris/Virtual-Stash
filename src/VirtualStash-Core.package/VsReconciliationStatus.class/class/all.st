accessing
all
	^ self allSubclasses collect: [ :e | e new ]