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
Double >> apply: aGameBoard [ 
	shipsGame doubleActualTurn.
]

{ #category : #action }
Double >> applyFrom: aNumberOfShip [ 
	shipsGame chosen: self from: aNumberOfShip.
	shipsGame applyChosenCard.
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

{ #category : #action }
Double >> verifyUseWith: aNumberOfShip [ 	
	shipsGame verify: self IsInHandOf: aNumberOfShip.
	shipsGame chosenCard: self .
]
