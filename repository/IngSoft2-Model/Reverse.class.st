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
Reverse >> apply: aGameBoard [ 
	shipsGame reverseTurnsOrder.
]

{ #category : #action }
Reverse >> applyFrom: aNumberOfShip [ 
	shipsGame chosen: self from: aNumberOfShip.
	shipsGame applyChosenCard.
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
Reverse >> selected: anInteger [ 
	^self.
]

{ #category : #action }
Reverse >> verifyUseWith: aNumberOfShip [ 	
	shipsGame verify: self IsInHandOf: aNumberOfShip.
	shipsGame chosenCard: self .
]
