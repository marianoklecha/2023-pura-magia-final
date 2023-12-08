Class {
	#name : #Redo,
	#superclass : #Object,
	#instVars : [
		'cardToRedo',
		'shipsGame',
		'chosenShipNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Redo class >> with: aShipsGame [
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Redo >> apply: aGameBoard [
	cardToRedo selected: chosenShipNumber .
	cardToRedo apply: aGameBoard.
	^ cardToRedo
]

{ #category : #action }
Redo >> behaveInstantaneousWith: aNumberOfShip [

	shipsGame chosenCard: self.
	chosenShipNumber := aNumberOfShip .
]

{ #category : #action }
Redo >> behavePermanentWith: aNumberOfShip [ 
	shipsGame verifyIsTurnOf: aNumberOfShip.
	shipsGame chosenCard: self.
]

{ #category : #action }
Redo >> cancellationFrom: aNumberOfShip to: aChosenNumberOfShip canceled: aCard [
	|lastCardUsedInGame|
	lastCardUsedInGame := shipsGame lastUsedCard.
	lastCardUsedInGame canceled: aCard.
	self from: aNumberOfShip to: aChosenNumberOfShip 
]

{ #category : #action }
Redo >> from: aNumberOfShip [
	shipsGame  chosen: self from: aNumberOfShip.
	shipsGame  applyChosenCard.
]

{ #category : #action }
Redo >> from: aNumberOfShip to: aChosenNumberOfShip [
	shipsGame chosen: self from: aNumberOfShip.
	chosenShipNumber := aChosenNumberOfShip .
	shipsGame applyChosenCard.
]

{ #category : #initialization }
Redo >> initializeWith: aShipsGame [ 
	shipsGame := aShipsGame .
]

{ #category : #instance }
Redo >> selected: aShipPosition [ 
	chosenShipNumber := aShipPosition .
]

{ #category : #validation }
Redo >> verifyUseWith: aNumberOfShip [ 
	shipsGame verify: self IsInHandOf: aNumberOfShip.
	cardToRedo := shipsGame lastUsedCard .
	cardToRedo permanent
		ifFalse: [ self behaveInstantaneousWith: aNumberOfShip ]
		ifTrue: [ self behavePermanentWith: aNumberOfShip ]
]
