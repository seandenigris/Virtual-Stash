initialize-release
initialize

	super initialize.
	tempFileBase := FileLocator imageDirectory / DateAndTime now asString asLegalSelector.