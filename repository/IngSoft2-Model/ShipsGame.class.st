Class {
	#name : #ShipsGame,
	#superclass : #Object,
	#instVars : [
		'gameboard',
		'chosenCard',
		'lastUsedCard',
		'aCollectionOfUsedCards',
		'amountOfShips',
		'turnToThrow',
		'amountToSum'
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

{ #category : #action }
ShipsGame >> doubleActualTurn [
	turnToThrow addLast: (turnToThrow first).
]

{ #category : #initialization }
ShipsGame >> initializeWith: anAmountOfShips and: aGameboard [ 
	turnToThrow := OrderedCollection new.
	turnToThrow add: 1.
	aCollectionOfUsedCards := OrderedCollection new.
	gameboard := aGameboard.
	amountOfShips := anAmountOfShips. 
	amountToSum := 1.
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
ShipsGame >> reverseTurnsOrder [
	amountToSum := amountToSum*(-1).
]

{ #category : #action }
ShipsGame >> skipTurn [

	| shipNumber |
	shipNumber := turnToThrow removeFirst.
	(turnToThrow isEmpty) ifTrue: [  
	shipNumber := shipNumber + amountToSum.
	(shipNumber > amountOfShips or: shipNumber = 0)
		ifTrue: [ 
			shipNumber > amountOfShips
				ifTrue: [ turnToThrow addLast: 1 ]
				ifFalse: [ turnToThrow addLast: amountOfShips ] ]
		ifFalse: [ turnToThrow addLast: shipNumber ]]
]

{ #category : #action }
ShipsGame >> throwNextShip [

	| shipNumber |
	self verifyThereIsNotAWinner.
	shipNumber := turnToThrow removeFirst.
	gameboard move: (gameboard shipWith: shipNumber).
	(turnToThrow isEmpty) ifTrue: [  
	shipNumber := shipNumber + amountToSum.
	(shipNumber > amountOfShips or: shipNumber = 0)
		ifTrue: [ 
			shipNumber > amountOfShips
				ifTrue: [ turnToThrow addLast: 1 ]
				ifFalse: [ turnToThrow addLast: amountOfShips ] ]
		ifFalse: [ turnToThrow addLast: shipNumber ]]
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

	aNumberOfShip = turnToThrow first ifFalse: [ 
		Error signal: 'Cannot use permanent card when its not their turn' ]
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
