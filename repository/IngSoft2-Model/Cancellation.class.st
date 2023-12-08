Class {
	#name : #Cancellation,
	#superclass : #Object,
	#instVars : [
		'cardToRemove',
		'shipsGame',
		'chosenShipNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Cancellation class >> with: aShipsGame [ 
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Cancellation >> apply: aGameBoard [

	| collectionCards chosenShip|
	chosenShip := aGameBoard shipWith: chosenShipNumber .
	collectionCards := chosenShip shipCards cardsForMe.
	(collectionCards includes: cardToRemove)
		ifTrue: [ collectionCards remove: cardToRemove ]
		ifFalse: [ self applyForCardsForAllTo: aGameBoard ].

	^ self
]

{ #category : #action }
Cancellation >> applyForCardsForAllTo: aGameBoard [

	| cardsForAllShips |
	cardsForAllShips := aGameBoard cardsForAllShips.
	(cardsForAllShips includes: cardToRemove)
		ifTrue: [ cardsForAllShips remove: cardToRemove ]
		ifFalse: [ 
			Error signal: 'The card you want to cancel is not affecting the ship' ]
]

{ #category : #initialization }
Cancellation >> canceled: aCardToRemove [
	cardToRemove:= aCardToRemove.
]

{ #category : #action }
Cancellation >> from: aNumberOfShip applyTo: aChosenNumberOfShip canceled: aCard [ 

	shipsGame  chosen: self from: aNumberOfShip.
	cardToRemove:= aCard.
	chosenShipNumber := aChosenNumberOfShip.
	shipsGame applyChosenCard.
]

{ #category : #action }
Cancellation >> from: aNumberOfShip canceled: aCard [ 

	shipsGame  chosen: self from: aNumberOfShip.
	cardToRemove:= aCard.
	shipsGame  applyChosenCard.
]

{ #category : #initialization }
Cancellation >> initializeWith: aShipsGame [

	shipsGame := aShipsGame
]

{ #category : #action }
Cancellation >> permanent [
	^false.
]

{ #category : #instance }
Cancellation >> selected: aShipPosition [  
	chosenShipNumber := aShipPosition.
]

{ #category : #validation }
Cancellation >> verifyUseWith: aNumberOfShip [ 

	shipsGame verify: self IsInHandOf: aNumberOfShip.
	shipsGame chosenCard: self.
	chosenShipNumber := aNumberOfShip.
]
