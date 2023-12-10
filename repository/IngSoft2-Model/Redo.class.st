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
Redo class >> verifyCanInitializeWith: anInstance [ 
	(anInstance isKindOf: ShipsGame)ifFalse:[ Error signal: 'The card must receive a ShipsGame instance' ]
]

{ #category : #initialization }
Redo class >> with: aShipsGame [
	self verifyCanInitializeWith: aShipsGame.
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Redo >> applyEffectUsing: aGameBoard [
	cardToRedo selected: chosenShipNumber .
	cardToRedo applyEffectUsing: aGameBoard.
]

{ #category : #action }
Redo >> beInstantaneousWith: aNumberOfShip [

	chosenShipNumber := aNumberOfShip .
]

{ #category : #action }
Redo >> bePermanentWith: aNumberOfShip [ 
	shipsGame turnsManager verifyIsTurnOf: aNumberOfShip.	
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
	shipsGame verify: self IsInHandOf: aNumberOfShip.
	cardToRedo := shipsGame lastUsedCard .
	cardToRedo permanent
		ifFalse: [ self beInstantaneousWith: aNumberOfShip ]
		ifTrue: [ self bePermanentWith: aNumberOfShip ].
	self applyEffectUsing: shipsGame gameboard.
]

{ #category : #action }
Redo >> from: aNumberOfShip to: aChosenNumberOfShip [
	shipsGame verify: self IsInHandOf: aNumberOfShip.
	cardToRedo := shipsGame lastUsedCard .
	cardToRedo permanent
		ifFalse: [ self beInstantaneousWith: aNumberOfShip ]
		ifTrue: [ self bePermanentWith: aNumberOfShip ]. 
	chosenShipNumber := aChosenNumberOfShip .
	self applyEffectUsing: shipsGame gameboard.
]

{ #category : #initialization }
Redo >> initializeWith: aShipsGame [ 
	shipsGame := aShipsGame .
]
