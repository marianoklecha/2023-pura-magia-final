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
	|aChosenShip shipsJailed|
	aChosenShip := aGameBoard shipWith: chosenShipNumber .
	shipsJailed := aGameBoard spaceSheriff shipsJailed.
	(shipsJailed includes: aChosenShip)
		ifTrue: [ shipsJailed remove: aChosenShip ]
		ifFalse: [ Error signal: 'The ship you want to free is not in Jail' ].
	aGameBoard spaceSheriff change: shipsJailed.
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
