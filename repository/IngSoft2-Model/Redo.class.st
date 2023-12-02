Class {
	#name : #Redo,
	#superclass : #Object,
	#instVars : [
		'cardToRedo',
		'chosenShip',
		'shipsGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Redo class >> with: aShipsGame [
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Redo >> apply: aGameBoard [
	cardToRedo selected: chosenShip .
	cardToRedo apply: aGameBoard.
	^ cardToRedo
]

{ #category : #action }
Redo >> behaveInstantaneousWith: aNumberOfShip [

	shipsGame chosenCard: self.
	shipsGame cardDirectedTo: aNumberOfShip
]

{ #category : #action }
Redo >> behavePermanentWith: aNumberOfShip [ 
	(shipsGame playerTurn: aNumberOfShip) ifTrue:[
			shipsGame chosenCard: self  ].
]

{ #category : #action }
Redo >> cancellationFrom: aNumberOfShip to: aChosenNumberOfShip canceled: aCard [
	|lastCardUsedInGame|
	lastCardUsedInGame := shipsGame lastUsedCard.
	lastCardUsedInGame  canceled: aCard.
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
	shipsGame cardDirectedTo: aChosenNumberOfShip.
	shipsGame applyChosenCard.
]

{ #category : #initialization }
Redo >> initializeWith: aShipsGame [ 
	shipsGame := aShipsGame .
]

{ #category : #validation }
Redo >> permanent: aShipsGame verify: aNumberOfShip [
	aShipsGame verify: self IsInHandOf: aNumberOfShip.
	cardToRedo permanent
		ifFalse: [ self behaveInstantaneousWith: aNumberOfShip ]
		ifTrue: [ self behavePermanentWith: aNumberOfShip ]
]

{ #category : #action }
Redo >> redo: lastUsedCard [ 
	cardToRedo := lastUsedCard .
]

{ #category : #instance }
Redo >> selected: aShipPosition [ 
	chosenShip := aShipPosition .
]
