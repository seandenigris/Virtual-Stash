Class {
	#name : #VsTaxDocument,
	#superclass : #Object,
	#instVars : [
		'resource',
		'year'
	],
	#category : #'VirtualStash-Core-Receipts'
}

{ #category : #'instance creation' }
VsTaxDocument class >> fromResourceable: aResourceable [

	^ self new
		resource: aResourceable asRlResource;
		yourself

]

{ #category : #accessing }
VsTaxDocument >> asEditorElement [
	| container figure maForm aResizer |
	container := BrHorizontalPane new
		vMatchParent;
		hMatchParent.

	figure := self asElement
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 2.5 ];
		margin: (BlInsets all: 5).

	maForm := (self magritteDescription elementBuilderFor: self)
		addButtons;
		element.

	maForm
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 1 ].
		
	aResizer := BlElement new.
	aResizer background: (Color gray alpha: 0.5).
	aResizer geometry: (BlRoundedRectangleGeometry cornerRadius: 2).
	aResizer constraintsDo: [ :c |
		c ignoreByLayout.
		c vertical exact: 70.
		c horizontal exact: 4.
		c ignored vertical alignCenter.
		c ignored horizontal alignRight ].
	aResizer addEventHandler: (BlResizerRightListener new resizeTarget: figure).
	figure addChild: aResizer.

	^ container
		addChild: figure;
		addChild: maForm;
		yourself
]

{ #category : #accessing }
VsTaxDocument >> asElement [
	^ RlHOCRElement new
		client: self;
		yourself.
]

{ #category : #accessing }
VsTaxDocument >> gtEditorFor: aView [
    <gtView>
    ^ aView pannable
        title: 'Editor';
        priority: 0.5;
        stencil: [ self asEditorElement ]
]

{ #category : #accessing }
VsTaxDocument >> imageFile [

	^ self resource imageFile
]

{ #category : #accessing }
VsTaxDocument >> printOn: aStream [

	super printOn: aStream.
	
	aStream
		space;
		print: year
]

{ #category : #accessing }
VsTaxDocument >> resource [

	^ resource
]

{ #category : #accessing }
VsTaxDocument >> resource: anObject [

	resource := anObject
]

{ #category : #accessing }
VsTaxDocument >> wantsHOCR [
	^ false
]

{ #category : #accessing }
VsTaxDocument >> year [

	^ year
]

{ #category : #accessing }
VsTaxDocument >> year: anObject [

	year := anObject
]

{ #category : #accessing }
VsTaxDocument >> yearDescription [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #year;
		priority: 100;
		beRequired;
		propertyAt: #whitelist put: '1234567890';
		yourself
]
