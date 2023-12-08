Class {
	#name : #Speed,
	#superclass : #Object,
	#instVars : [
		'shipsGame',
		'chosenShipNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Speed class >> with: aShipsGame [ 
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Speed >> amountToChange [
	^1.
]

{ #category : #action }
Speed >> apply: aGameBoard [ 
	((aGameBoard shipWith: chosenShipNumber)shipCards ) store: (self). 
	^(self)
]

{ #category : #action }
Speed >> from: aNumberOfShip applyTo: aChosenNumberOfShip [ 
	shipsGame chosen: self from: aNumberOfShip.
	chosenShipNumber := aChosenNumberOfShip .
	shipsGame applyChosenCard.
]

{ #category : #initialization }
Speed >> initializeWith: aShipsGame [ 
	shipsGame := aShipsGame .
]

{ #category : #validation }
Speed >> permanent [
	^true
]

{ #category : #selection }
Speed >> selected: aShip [ 
	chosenShipNumber := aShip .
]

{ #category : #validation }
Speed >> verifyUseWith: aNumberOfShip [ 
	shipsGame verifyIsTurnOf: aNumberOfShip.
	shipsGame verify: self IsInHandOf: aNumberOfShip.
	shipsGame chosenCard: self.
]
