Class {
	#name : #Reverse,
	#superclass : #Object,
	#instVars : [
		'shipsGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Reverse class >> verifyCanInitializeWith: anInstance [ 
	(anInstance isKindOf: ShipsGame)ifFalse:[ Error signal: 'The card must receive a ShipsGame instance' ]
]

{ #category : #action }
Reverse class >> with: aShipsGame [
	self verifyCanInitializeWith: aShipsGame.
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Reverse >> applyEffectUsing: aGameBoard [
	|actualAmountToSum newAmountToSum|
	actualAmountToSum:= shipsGame turnsManager amountToSum.
	newAmountToSum := actualAmountToSum*(-1).
	shipsGame turnsManager change: newAmountToSum.
	shipsGame takeJustUsed: self.
]

{ #category : #action }
Reverse >> applyFrom: aNumberOfShip [ 
	shipsGame verify: self IsInHandOf: aNumberOfShip.
	self applyEffectUsing: shipsGame gameboard.
]

{ #category : #initialization }
Reverse >> initializeWith: aShipsGame [ 
	shipsGame := aShipsGame .
]

{ #category : #action }
Reverse >> permanent [
	^false.
]

{ #category : #action }
Reverse >> selected: aNumberOfShip [ 
	^self.
]
