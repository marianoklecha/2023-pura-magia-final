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
Speed class >> verifyCanInitializeWith: anInstance [ 
	(anInstance isKindOf: ShipsGame)ifFalse:[ Error signal: 'The card must receive a ShipsGame instance' ]
]

{ #category : #initialization }
Speed class >> with: aShipsGame [
	self verifyCanInitializeWith: aShipsGame.
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Speed >> amountToChange [
	^1.
]

{ #category : #action }
Speed >> applyEffectUsing: aGameBoard [ 
	((aGameBoard shipWith: chosenShipNumber)shipCards ) store: (self). 
	shipsGame takeJustUsed: self.
]

{ #category : #action }
Speed >> from: aNumberOfShip applyTo: aChosenNumberOfShip [ 
	shipsGame turnsManager verifyIsTurnOf: aNumberOfShip.
	shipsGame verify: self IsInHandOf: aNumberOfShip.
	chosenShipNumber := aChosenNumberOfShip .
	self applyEffectUsing: shipsGame gameboard.
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
