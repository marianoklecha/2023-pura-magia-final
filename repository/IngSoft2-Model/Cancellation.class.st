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

{ #category : #initialization }
Cancellation class >> verifyCanInitializeWith: anInstance [ 
	(anInstance isKindOf: ShipsGame)ifFalse:[ Error signal: 'The card must receive a ShipsGame instance' ]
]

{ #category : #action }
Cancellation class >> with: aShipsGame [
	self verifyCanInitializeWith: aShipsGame.
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Cancellation >> applyEffectUsing: aGameBoard [

	| collectionCards chosenShip|
	chosenShip := aGameBoard shipWith: chosenShipNumber .
	collectionCards := chosenShip shipCards cardsForMe.
	(collectionCards includes: cardToRemove)
		ifTrue: [ collectionCards remove: cardToRemove ]
		ifFalse: [ self cancelCardsFrom: aGameBoard ].
	shipsGame takeJustUsed: self.
]

{ #category : #action }
Cancellation >> cancelCardsFrom: aGameBoard [

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
Cancellation >> from: aNumberOfShip applyTo: aChosenNumberOfShip cancelling: aCard [ 

	shipsGame verify: self IsInHandOf: aNumberOfShip.
	cardToRemove:= aCard.
	chosenShipNumber := aChosenNumberOfShip.
	self applyEffectUsing: shipsGame gameboard.
]

{ #category : #action }
Cancellation >> from: aNumberOfShip cancelling: aCard [

	self from: aNumberOfShip applyTo: aNumberOfShip cancelling: aCard.
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
