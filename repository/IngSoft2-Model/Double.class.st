Class {
	#name : #Double,
	#superclass : #Object,
	#instVars : [
		'shipsGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Double class >> verifyCanInitializeWith: anInstance [

	(anInstance isKindOf: ShipsGame) ifFalse: [ 
		Error signal: 'The card must receive a ShipsGame instance' ]
]

{ #category : #initialization }
Double class >> with: aShipsGame [
	self verifyCanInitializeWith: aShipsGame.
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Double >> applyEffectUsing: aGameBoard [

	|turnsCollection actualTurn|
	turnsCollection := shipsGame turnsManager turns.
	actualTurn := turnsCollection first.
	turnsCollection addLast: actualTurn.
	shipsGame turnsManager changeTurns: turnsCollection.
	shipsGame takeJustUsed: self.
]

{ #category : #action }
Double >> applyFrom: aNumberOfShip [ 

	shipsGame verify: self IsInHandOf: aNumberOfShip.
	self applyEffectUsing: shipsGame gameboard.
]

{ #category : #initialization }
Double >> initializeWith: aShipsGame [ 

	shipsGame := aShipsGame .
]

{ #category : #action }
Double >> permanent [

	^false.
]

{ #category : #action }
Double >> selected: aNumberOfShip [

	^self.
]
