Class {
	#name : #ShipsGame,
	#superclass : #Object,
	#instVars : [
		'gameboard',
		'chosenCard',
		'lastUsedCard',
		'aCollectionOfUsedCards',
		'amountOfShips',
		'turnsManager'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
ShipsGame class >> with: amountOfPlayers and: aGameBoard [
	^(self new) initializeWith: amountOfPlayers and: aGameBoard
]

{ #category : #action }
ShipsGame >> applyChosenCard [
	lastUsedCard := chosenCard apply: gameboard .
]

{ #category : #validation }
ShipsGame >> chosen: aCard from: aNumberOfShip [

	| aShip |
	aShip := gameboard shipWith: aNumberOfShip.
	aCard verifyUseWith: aNumberOfShip 
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

{ #category : #initialization }
ShipsGame >> initializeWith: anAmountOfShips and: aGameboard [ 
	turnsManager:= TurnsManager with: anAmountOfShips.
	aCollectionOfUsedCards := OrderedCollection new.
	gameboard := aGameboard.
	amountOfShips := anAmountOfShips. 
	aGameboard fillWith: (self create: anAmountOfShips)
]

{ #category : #action }
ShipsGame >> lastUsedCard [
	^ lastUsedCard .
]

{ #category : #validation }
ShipsGame >> ranking [
	
	| array sortedArray |
	array := OrderedCollection new.
	1 to: amountOfShips do: [ :number | array add: (gameboard shipWith: number) ].
	sortedArray := array sorted: [:player1 :player2 | (player1 actualPosition ) currentLap    < (player2 actualPosition ) currentLap  ].
	sortedArray := sortedArray sorted: [:player1 :player2 | (player1 actualPosition )currentCell  < (player2 actualPosition )  currentCell ].
	sortedArray :=sortedArray sorted: [:player1 :player2 | ((player1 actualPosition) currentParsec )nominalValue  < ((player2 actualPosition ) currentParsec)nominalValue  ].
	^sortedArray
]

{ #category : #action }
ShipsGame >> throwNextShip [

	| shipNumber |
	self verifyThereIsNotAWinner.
	shipNumber := turnsManager nextShipNumber.
	gameboard move: (gameboard shipWith: shipNumber).
]

{ #category : #action }
ShipsGame >> turnsManager [
	^ turnsManager
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

{ #category : #action }
ShipsGame >> verifyThereIsNotAWinner [
	(self winner = 0)
		ifFalse: [ Error signal: 'There is a winner and the game has finished, unless you have a card that prevents it, you cant throw' ]
]

{ #category : #validation }
ShipsGame >> winner [

	| winnerNumber shipLap |
	winnerNumber := 0.
	1 to: amountOfShips do: [ :number | 
		shipLap := (gameboard shipWith: number) actualPosition currentLap.
		shipLap > gameboard lapsToWin ifTrue: [ winnerNumber := number ] ].
	^ winnerNumber
]
