Class {
	#name : #Overload,
	#superclass : #Object,
	#instVars : [
		'shipsGame',
		'chosenShipNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Overload class >> verifyCanInitializeWith: anInstance [ 
	(anInstance isKindOf: ShipsGame)ifFalse:[ Error signal: 'The card must receive a ShipsGame instance' ]
]

{ #category : #initialization }
Overload class >> with: aShipsGame [
	self verifyCanInitializeWith: aShipsGame.
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Overload >> amountToChange [
	^-2.
]

{ #category : #action }
Overload >> applyEffectUsing: aGameBoard [ 
	((aGameBoard shipWith: chosenShipNumber) shipCards) store: self.
	shipsGame takeJustUsed: self.
]

{ #category : #action }
Overload >> from: aNumberOfShip applyTo: aChosenNumberOfShip [ 
	shipsGame turnsManager verifyIsTurnOf: aNumberOfShip.	
	shipsGame verify: self IsInHandOf: aNumberOfShip.
	chosenShipNumber := aChosenNumberOfShip .
	self applyEffectUsing: shipsGame gameboard.
]

{ #category : #initialization }
Overload >> initializeWith: aShipsGame [
	shipsGame := aShipsGame .
]

{ #category : #validation }
Overload >> permanent [
	^true.
]

{ #category : #instance }
Overload >> selected: aShipPosition [ 
	chosenShipNumber := aShipPosition .
]
