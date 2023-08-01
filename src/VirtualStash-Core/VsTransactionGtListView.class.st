Class {
	#name : #VsTransactionGtListView,
	#superclass : #GtPhlowColumnedListView,
	#category : #'VirtualStash-Core'
}

{ #category : #accessing }
VsTransactionGtListView >> cellSpacing [

	^ 5
]

{ #category : #accessing }
VsTransactionGtListView >> newDecoratedItemStencil [
	| anItemElementStencil |
	anItemElementStencil := VsColumnedListRowElementStencilBuilder
			new cellSpacing: self cellSpacing.
	self contextMenuActions
		ifNotEmpty: [ :contextMenuActionsList | 
			anItemElementStencil := GtPhlowColumnedListItemElementWithContextMenuDecorator
					new
					stencilBuilder: anItemElementStencil;
					contextMenuStencil: self contextMenuStencilFromActions ].

	^ anItemElementStencil
]
