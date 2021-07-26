```smalltalk
| receipt |
receipt := self new asMagritteMorph.
receipt
	addWindow;
	openInWorld.
```
# Creation
## Bulk
A common scenario is that you have a bunch of files that you want to turn into receipts. There are two options:
1. If you have a folder full of JPEGs, you can pass them to {{gtMethod:VsReceipt class>>#fromImagesIn:}}
2. For more control, you can create a collection of receipt files and pass them to {{gtMethod:VsReceipt class>>#fromFiles:}}
