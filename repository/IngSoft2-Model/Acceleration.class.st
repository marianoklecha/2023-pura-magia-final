Class {
	#name : #Acceleration,
	#superclass : #Object,
	#instVars : [
		'shipsGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Acceleration class >> verifyCanInitializeWith: anInstance [ 
	(anInstance isKindOf: ShipsGame)ifFalse:[ Error signal: 'The card must receive a ShipsGame instance' ]
]

{ #category : #initialization }
Acceleration class >> with: aShipsGame [
	self verifyCanInitializeWith: aShipsGame.
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Acceleration >> amountToChange [
	^1.
]

{ #category : #action }
Acceleration >> apply: aGameBoard [
	aGameBoard store: self.
	^self
]

{ #category : #action }
Acceleration >> applyToAllFrom: aNumberOfShip [ 
	shipsGame chosen: self from: aNumberOfShip.
	shipsGame applyChosenCard.
]

{ #category : #initialization }
Acceleration >> initializeWith: aShipsGame [ 
	shipsGame := aShipsGame .
]

{ #category : #validation }
Acceleration >> permanent [
	^true.
]

{ #category : #action }
Acceleration >> selected: aShip [ 
	^self.
]

{ #category : #validation }
Acceleration >> verifyUseWith: aNumberOfShip [ 
	shipsGame verifyIsTurnOf: aNumberOfShip.
	shipsGame verify: self IsInHandOf: aNumberOfShip.
	shipsGame chosenCard: self.
]
