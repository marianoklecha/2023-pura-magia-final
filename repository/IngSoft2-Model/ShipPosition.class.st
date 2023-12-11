Class {
	#name : #ShipPosition,
	#superclass : #Object,
	#instVars : [
		'cellNumber',
		'actualLap',
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
ShipPosition class >> createNew [
	^(self new)initializeNew.
]

{ #category : #creation }
ShipPosition class >> createWith: aNumberOfCell at: aNumberOfLap and: aParsec [
	self verifyCanExistWith: aNumberOfCell and: aNumberOfLap and: aParsec . 
	 ^(self new) initializeWith: aNumberOfCell and: aNumberOfLap and: aParsec. 
]

{ #category : #validation }
ShipPosition class >> verifyCanExistWith: aNumberOfCell and: aNumberOfLap and: aParsec [ 
	((aNumberOfCell<0) or: ((aNumberOfLap<0) or: ((aParsec nominalValue) <0))) ifTrue: [ Error signal: 'No value can be negative' ]
]

{ #category : #validation }
ShipPosition >> currentCell [

	^ cellNumber 
]

{ #category : #validation }
ShipPosition >> currentLap [

	^ actualLap
]

{ #category : #validation }
ShipPosition >> currentParsec [
	^parsecs .
]

{ #category : #initialization }
ShipPosition >> initializeNew [

	cellNumber := 0.
	actualLap := 1.
	parsecs := Parsecs with: 0
]

{ #category : #initialization }
ShipPosition >> initializeWith: aNumberOfCell and: aNumberOfLap and: aParsec [

	cellNumber := aNumberOfCell.
	actualLap := aNumberOfLap.
	parsecs := aParsec
]
