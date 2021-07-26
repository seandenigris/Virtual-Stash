accessing
all
	^ self generic, ((VsImportRule allSubclasses reject: #isAbstract) collect: #new) "We refer to the class explicitly so that this works the same from the subclasses"