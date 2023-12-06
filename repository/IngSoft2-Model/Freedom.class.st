Class {
	#name : #Freedom,
	#superclass : #Object,
	#instVars : [
		'shipsGame',
		'chosenShip'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Freedom class >> with: aShipsGame [ 
	^(self new) initializeWith: aShipsGame.
]

{ #category : #action }
Freedom >> apply: aGameBoard [ 
	aGameBoard spaceSheriff setFree: chosenShip.
]

{ #category : #action }
Freedom >> from: aNumberOfShip applyTo: aChosenNumberOfShip [ 
	shipsGame chosen: self from: aNumberOfShip.
	shipsGame cardDirectedTo: aChosenNumberOfShip.
	shipsGame applyChosenCard.
]

{ #category : #initialization }
Freedom >> initializeWith: aShipsGame [ 
	shipsGame:= aShipsGame . 
]

{ #category : #action }
Freedom >> permanent [
		^false.
]

{ #category : #action }
Freedom >> permanent: aShipsGame verify: aNumberOfShip [

	aShipsGame verify: self IsInHandOf: aNumberOfShip.
	aShipsGame chosenCard: self.
	aShipsGame cardDirectedTo: aNumberOfShip
]

{ #category : #action }
Freedom >> selected: aShip [ 
	chosenShip := aShip .
]
