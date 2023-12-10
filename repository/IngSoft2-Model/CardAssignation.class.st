Class {
	#name : #CardAssignation,
	#superclass : #Object,
	#instVars : [
		'deckOfCards',
		'numberOfCell'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creating }
CardAssignation class >> withDeck [
	^(self new) initializeWith: Deck new.
]

{ #category : #action }
CardAssignation >> applyTo: aGameBoard for: aShip [
	|numberOfShip|
	
	numberOfShip:= aShip numberOfShip .
	aShip add: deckOfCards giveCard .
	
]

{ #category : #initialization }
CardAssignation >> initializeWith: aDeckOfCards [ 
	deckOfCards := aDeckOfCards .
]

{ #category : #action }
CardAssignation >> with: aNumberOfCell [
	numberOfCell := aNumberOfCell .
]
