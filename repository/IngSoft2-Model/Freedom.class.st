Class {
	#name : #Freedom,
	#superclass : #Object,
	#instVars : [
		'shipsGame',
		'chosenShipNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Freedom class >> verifyCanInitializeWith: anInstance [ 
	(anInstance isKindOf: ShipsGame)ifFalse:[ Error signal: 'The card must receive a ShipsGame instance' ]
]

{ #category : #action }
Freedom class >> with: aShipsGame [
	self verifyCanInitializeWith: aShipsGame.
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Freedom >> apply: aGameBoard [
	|aChosenShip|
	aChosenShip := aGameBoard shipWith: chosenShipNumber .
	aGameBoard spaceSheriff setFree: aChosenShip.
]

{ #category : #action }
Freedom >> from: aNumberOfShip applyTo: aChosenNumberOfShip [ 
	shipsGame chosen: self from: aNumberOfShip.
	chosenShipNumber := aChosenNumberOfShip.
	shipsGame applyChosenCard.
]

{ #category : #initialization }
Freedom >> initializeWith: aShipsGame [ 
	shipsGame:= aShipsGame . 
]

{ #category : #action }
Freedom >> permanent [
		^false.
]

{ #category : #action }
Freedom >> selected: aShip [ 
	chosenShipNumber := aShip .
]

{ #category : #action }
Freedom >> verifyUseWith: aNumberOfShip [ 

	shipsGame verify: self IsInHandOf: aNumberOfShip.
	shipsGame chosenCard: self.
	chosenShipNumber := aNumberOfShip.
]
