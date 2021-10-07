Class {
	#name : #VsFieldSetterElement,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'checkbox',
		'label',
		'argument',
		'setter',
		'target'
	],
	#category : 'VirtualStash-Core-GToolkit'
}

{ #category : #accessing }
VsFieldSetterElement class >> example [
	<gtExample>
	^ self target: 1 setter: #tim: value: 3
]

{ #category : #accessing }
VsFieldSetterElement class >> target: anObject setter: aSymbol value: anotherObject [
	^ self basicNew
		target: anObject;
		setter: aSymbol;
		argument: anotherObject;
		initialize.
	
]

{ #category : #accessing }
VsFieldSetterElement >> argument [
	^ argument
]

{ #category : #accessing }
VsFieldSetterElement >> argument: anObject [
	argument := anObject
]

{ #category : #accessing }
VsFieldSetterElement >> initialize [
	super initialize.
	
	checkbox := BrCheckbox new
		aptitude: BrGlamorousCheckboxAptitude;
		margin: (BlInsets top: 6);
		check;
		yourself.
		
	label := BrLabel new
		aptitude: BrGlamorousLabelAptitude + BrGlamorousInputFieldSpacingAptitude new;
		text: self setter, ' ', self argument asString;
		yourself.
		
	self
		hMatchParent;
		vFitContent;
		addChild: checkbox;
		addChild: label;
		yourself
]

{ #category : #accessing }
VsFieldSetterElement >> setter [
	^ setter
]

{ #category : #accessing }
VsFieldSetterElement >> setter: anObject [
	setter := anObject
]

{ #category : #accessing }
VsFieldSetterElement >> target [
	^ target
]

{ #category : #accessing }
VsFieldSetterElement >> target: anObject [
	target := anObject
]
