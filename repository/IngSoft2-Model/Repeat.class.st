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
Repeat >> apply: aGameBoard [ 
	|lastEffectUsed counter chosenShip|
	counter:= 1.
	lastEffectUsed:= aGameBoard lastEffectUsed.
	chosenShip := aGameBoard shipWith: chosenShipNumber.
	lastEffectUsed applyTo: aGameBoard  for: chosenShip  .
	^(self)
]

{ #category : #action }
Repeat >> from: aNumberOfShip [
	shipsGame  chosen: self from: aNumberOfShip.
	shipsGame  applyChosenCard.
]

{ #category : #action }
Repeat >> from: aNumberOfShip to: aChosenNumberOfShip [
	shipsGame chosen: self from: aNumberOfShip.
	chosenShipNumber:= aChosenNumberOfShip.
	shipsGame applyChosenCard.
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

{ #category : #validation }
Repeat >> verifyUseWith: aNumberOfShip [ 

	shipsGame verify: self IsInHandOf: aNumberOfShip.
	shipsGame chosenCard: self.
	chosenShipNumber:= aNumberOfShip.
]
