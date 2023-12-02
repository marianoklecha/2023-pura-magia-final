Class {
	#name : #Cancellation,
	#superclass : #Object,
	#instVars : [
		'cardToRemove',
		'chosenShip',
		'shipsGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Cancellation class >> with: aShipsGame [ 
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Cancellation >> apply: aGameBoard [ 
	| collectionCards|
	collectionCards := chosenShip shipCards cardsForMe.
	(collectionCards includes: cardToRemove)
		ifTrue: [ collectionCards remove: cardToRemove ]
		ifFalse: [ self applyForCardsForAllTo: aGameBoard].
	
	^(self)
	
]

{ #category : #action }
Cancellation >> applyForCardsForAllTo: aGameBoard [

	| cardsForAllShips |
	cardsForAllShips := aGameBoard cardsForAllShips.
	(cardsForAllShips includes: cardToRemove) ifTrue: [ 
		cardsForAllShips remove: cardToRemove.
		] ifFalse: [Error signal: 'The card you want to cancel is not affecting the ship'].
	
]

{ #category : #initialization }
Cancellation >> canceled: aCardToRemove [
	cardToRemove:= aCardToRemove.
]

{ #category : #action }
Cancellation >> from: aNumberOfShip applyTo: aChosenNumberOfShip canceled: aCard [ 

	shipsGame  chosen: self from: aNumberOfShip.
	self  canceled: aCard .
	shipsGame cardDirectedTo: aChosenNumberOfShip.
	shipsGame applyChosenCard.
]

{ #category : #action }
Cancellation >> from: aNumberOfShip canceled: aCard [ 

	shipsGame  chosen: self from: aNumberOfShip.
	self canceled: aCard .
	shipsGame  applyChosenCard.
]

{ #category : #initialization }
Cancellation >> initializeWith: aShipsGame [ 
	shipsGame := aShipsGame .
]

{ #category : #action }
Cancellation >> permanent [
	^false.
]

{ #category : #validation }
Cancellation >> permanent: aShipsGame verify: aNumberOfShip [

	aShipsGame verify: self IsInHandOf: aNumberOfShip.
	aShipsGame chosenCard: self.
	aShipsGame cardDirectedTo: aNumberOfShip
]

{ #category : #instance }
Cancellation >> selected: aShipPosition [  
	chosenShip := aShipPosition.
]
