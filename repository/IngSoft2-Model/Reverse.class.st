Class {
	#name : #Reverse,
	#superclass : #Object,
	#instVars : [
		'shipsGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Reverse class >> with: aShipsGame [ 
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
Reverse >> verifyUseWith: aNumberOfShip [ 	
	shipsGame verify: self IsInHandOf: aNumberOfShip.
	shipsGame chosenCard: self .
]
