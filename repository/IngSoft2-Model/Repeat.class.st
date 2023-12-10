Class {
	#name : #Repeat,
	#superclass : #Object,
	#instVars : [
		'shipsGame',
		'chosenShipNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Repeat class >> verifyCanInitializeWith: anInstance [ 
	(anInstance isKindOf: ShipsGame)ifFalse:[ Error signal: 'The card must receive a ShipsGame instance' ]
]

{ #category : #initialization }
Repeat class >> with: aShipsGame [
	self verifyCanInitializeWith: aShipsGame.
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Repeat >> applyEffectUsing: aGameBoard [ 
	|lastEffectUsed counter chosenShip|
	counter:= 1.
	lastEffectUsed:= aGameBoard lastEffectUsed.
	chosenShip := aGameBoard shipWith: chosenShipNumber.
	lastEffectUsed applyTo: aGameBoard  for: chosenShip  .
	shipsGame takeJustUsed: self.
]

{ #category : #action }
Repeat >> from: aNumberOfShip [
	shipsGame verify: self IsInHandOf: aNumberOfShip.
	chosenShipNumber:= aNumberOfShip.
	self applyEffectUsing: shipsGame gameboard.
]

{ #category : #action }
Repeat >> from: aNumberOfShip to: aChosenNumberOfShip [
	shipsGame verify: self IsInHandOf: aNumberOfShip.
	chosenShipNumber:= aChosenNumberOfShip.
	self applyEffectUsing: shipsGame gameboard.
]

{ #category : #initialization }
Repeat >> initializeWith: aShipsGame [ 
	shipsGame := aShipsGame .
]

{ #category : #action }
Repeat >> permanent [
	^false.
]

{ #category : #intance }
Repeat >> selected: aShipPosition [ 
	chosenShipNumber:= aShipPosition.
]
