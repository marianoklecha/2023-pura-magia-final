Class {
	#name : #ShipsGame,
	#superclass : #Object,
	#instVars : [
		'result',
		'gameboard',
		'chosenCard',
		'lastUsedCard',
		'aCollectionOfUsedCards',
		'amountOfShips',
		'turnToThrow'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
ShipsGame class >> initializeEmpty [
	^(self new) initializeWith: 'The Game does not have a winner'
]

{ #category : #action }
ShipsGame >> applyChosenCard [
	lastUsedCard := chosenCard apply: gameboard .
]

{ #category : #action }
ShipsGame >> cardDirectedTo: aNumberOfShip [ 
	chosenCard selected: (gameboard shipWith: aNumberOfShip)
]

{ #category : #validation }
ShipsGame >> chosen: aCard from: aNumberOfShip [

	| aShip |
	aShip := gameboard shipWith: aNumberOfShip.
	aCard permanent: self verify: aNumberOfShip .
]

{ #category : #instance }
ShipsGame >> chosenCard: aCard [ 
	chosenCard := aCard .
]

{ #category : #creation }
ShipsGame >> create: anAmountOfShips [

	| shipsCollection |
	shipsCollection := OrderedCollection new.

	1 to: anAmountOfShips do: [ :count | 
	shipsCollection add: (Ship with: count) ].

	^ shipsCollection
]

{ #category : #intialization }
ShipsGame >> initializeWith: aResult [

	result := aResult.
	gameboard := nil.
	turnToThrow := 1.
	amountOfShips := 0.
	aCollectionOfUsedCards := OrderedCollection new.
]

{ #category : #action }
ShipsGame >> lastUsedCard [
	^ lastUsedCard .
]

{ #category : #validation }
ShipsGame >> ranking [
	^gameboard ranking
]

{ #category : #validation }
ShipsGame >> result [
	^ result
]

{ #category : #starting }
ShipsGame >> startwith: anAmountOfShips and: aGameboard [

	| ships |
	gameboard := aGameboard.
	ships := self create: anAmountOfShips .
	amountOfShips := anAmountOfShips. 
	aGameboard fillWith: ships
]

{ #category : #action }
ShipsGame >> throwNextShip [

	gameboard verifyThereIsNotAWinner.
	gameboard move: (gameboard shipWith: turnToThrow).
	turnToThrow := turnToThrow + 1.
	turnToThrow <= amountOfShips ifFalse: [ turnToThrow := 1 ]
]

{ #category : #validation }
ShipsGame >> verify: aCard IsInHandOf: aNumberOfShip [

	| aShipCards aCollectionOfCards|
	aShipCards := (gameboard shipWith: aNumberOfShip) shipCards.
	aShipCards verifyThatIncludes: aCard .
	aCollectionOfCards:= aShipCards cardsInHand.
	aCollectionOfCards remove: aCard.
	aCollectionOfUsedCards add: aCard.
			
]

{ #category : #validation }
ShipsGame >> verifyIsTurnOf: aNumberOfShip [

	aNumberOfShip = turnToThrow ifFalse: [ 
		Error signal: 'Cannot use permanent card when its not their turn' ]
]

{ #category : #validation }
ShipsGame >> winner [

	^ gameboard winner
]
