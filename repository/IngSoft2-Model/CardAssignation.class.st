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
	^(self new) initializeWith: DeckOfCards new.
]

{ #category : #action }
CardAssignation >> applyTo: aGameBoard for: aShip [
	|numberOfShip|
	
	numberOfShip:= aShip numberOfShip .
	deckOfCards designateRandomCardTo: numberOfShip from: aGameBoard . 
	
]

{ #category : #initialization }
CardAssignation >> initializeWith: aDeckOfCards [ 
	deckOfCards := aDeckOfCards .
]

{ #category : #action }
CardAssignation >> numberOfSpecialCell [
	^numberOfCell .
]

{ #category : #action }
CardAssignation >> with: aNumberOfCell [
	numberOfCell := aNumberOfCell .
]
