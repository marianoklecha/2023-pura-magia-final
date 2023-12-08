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
Overload class >> with: aShipsGame [
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Overload >> amountToChange [
	^-2.
]

{ #category : #action }
Overload >> apply: aGameBoard [ 
	((aGameBoard shipWith: chosenShipNumber) shipCards) store: self.
	^(self)
]

{ #category : #action }
Overload >> from: aNumberOfShip applyTo: aChosenNumberOfShip [ 
	shipsGame chosen: self from: aNumberOfShip.
	chosenShipNumber := aChosenNumberOfShip .
	shipsGame applyChosenCard.
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

{ #category : #validation }
Overload >> verifyUseWith: aNumberOfShip [ 
	shipsGame verifyIsTurnOf: aNumberOfShip.	
	shipsGame verify: self IsInHandOf: aNumberOfShip.
	shipsGame chosenCard: self .
]
