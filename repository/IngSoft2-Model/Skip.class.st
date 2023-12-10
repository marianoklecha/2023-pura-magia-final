Class {
	#name : #Skip,
	#superclass : #Object,
	#instVars : [
		'shipsGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Skip class >> verifyCanInitializeWith: anInstance [ 
	(anInstance isKindOf: ShipsGame)ifFalse:[ Error signal: 'The card must receive a ShipsGame instance' ]
]

{ #category : #action }
Skip class >> with: aShipsGame [
	self verifyCanInitializeWith: aShipsGame.
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Skip >> apply: aGameBoard [ 
	shipsGame turnsManager skipTurn.
]

{ #category : #action }
Skip >> applyFrom: aNumberOfShip [ 
	shipsGame chosen: self from: aNumberOfShip.
	shipsGame applyChosenCard.
]

{ #category : #action }
Skip >> initializeWith: aShipsGame [ 
	shipsGame := aShipsGame .
]

{ #category : #action }
Skip >> permanent [
	^false.
]

{ #category : #action }
Skip >> selected: aNumberOfShip [ 
	^self.
]

{ #category : #action }
Skip >> verifyUseWith: aNumberOfShip [ 	
	shipsGame verify: self IsInHandOf: aNumberOfShip.
	shipsGame chosenCard: self .
]
