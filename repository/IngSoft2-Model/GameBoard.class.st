Class {
	#name : #GameBoard,
	#superclass : #Object,
	#instVars : [
		'cells',
		'laps',
		'aCollectionOfSpecialCells',
		'parsecsByCell',
		'dieCollection',
		'turn',
		'lastEffectUsed',
		'collectionOfShips',
		'positionManager',
		'collectionOfCardsForAllShips'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validating }
GameBoard class >> validateCanExistWith: numberOfCells and: numberOfLaps [
	|result|
	result := (numberOfCells > 1 )&(numberOfLaps >= 1 ).
	 result  ifFalse: [ 
		Error signal:
			'Cannot create GameBoard with negative amount of cells or laps' ]
]

{ #category : #creation }
GameBoard class >> with: numberOfCells and: numberOfLaps [ 
	self validateCanExistWith: numberOfCells and: numberOfLaps.
	^(self new) initializeWith: numberOfCells and: numberOfLaps.
	
	
	 
]

{ #category : #adding }
GameBoard >> add: aEffect at: aNumberOfCell [ 
	aCollectionOfSpecialCells add: (Cell with: aEffect  and: aNumberOfCell).
]

{ #category : #action }
GameBoard >> add: aCard to: numberOfPlayer [ 
	| aShip |
	aShip :=(self shipWithNumber: numberOfPlayer). 
	aShip add: aCard.
	
	
]

{ #category : #action }
GameBoard >> addEffects: aCollectionOfProbabilities forHyperJump: aCollectionOfDifferentParsecs [ 
	|randomNumber probabilities|
		
	probabilities := self createCollectionFrom: aCollectionOfProbabilities .
	
	0 to: cells do: [ :index | randomNumber:= 100 atRandom.
		
		( randomNumber >= (probabilities  at: 1) and: randomNumber < (probabilities at: 2)) ifTrue: [ 
			self add: (WormHole new) at: index. 
		 ].
	 (randomNumber >= (probabilities  at: 2) and: randomNumber < (probabilities at: 3)) ifTrue: [ 
			self add: (SpeedUp new) at: index. 
		 ].
	 (randomNumber >= (probabilities  at: 3) and: randomNumber < (probabilities at: 4)) ifTrue: [ 
			self add: (MoonWalk  with: (cells atRandom)*(-1)) at: index. 
		 ].
	 (randomNumber >= (probabilities  at: 4) and: randomNumber < (probabilities at: 5)) ifTrue: [ 
			self add: (HyperJump  with: aCollectionOfDifferentParsecs) at: index. 
		 ].
	(randomNumber >= (probabilities  at: 5) and: randomNumber < (probabilities at: 6)) ifTrue: [ 
			self add: (AtomicBomb  new) at: index. 
		 ].
	(randomNumber >= (probabilities  at: 6) and: randomNumber < (probabilities at: 7)) ifTrue: [ 
			self add: (CardAssignation withDeck) at: index. 
		 ].].

]

{ #category : #counting }
GameBoard >> amountOf: typeOfSpecialEffect [

	| count |
	count := 0.
	aCollectionOfSpecialCells do: [ :each | 
		(each typeOfSpecialEffect isKindOf: typeOfSpecialEffect) ifTrue: [ 
			count := count + 1 ] ].

	^ count
]

{ #category : #validation }
GameBoard >> amountOfCells [
	^cells 
]

{ #category : #counter }
GameBoard >> amountOfNormalCells [
	^ cells - (aCollectionOfSpecialCells size) 
]

{ #category : #action }
GameBoard >> amountOfShipsPlaying [
	^ collectionOfShips  size.
]

{ #category : #action }
GameBoard >> cardsForAllShips [
	^collectionOfCardsForAllShips .
]

{ #category : #initialization }
GameBoard >> cellsWith: anAmountOfParsecs and: aCollectionOfDice [
	parsecsByCell := anAmountOfParsecs .
	positionManager := PositionManager with: cells and: anAmountOfParsecs .
	dieCollection := aCollectionOfDice .
]

{ #category : #validation }
GameBoard >> checkLapOf: aShip [ 
	| anotherShip |
	anotherShip := self positionAtCollectionOf: aShip.
	^ (anotherShip shipPosition ) currentLap.
]

{ #category : #validation }
GameBoard >> checkPositionOf: aShip [

	| anotherShip |
	anotherShip := self positionAtCollectionOf: aShip.
	^ ((anotherShip shipPosition ) currentCell)
]

{ #category : #action }
GameBoard >> createCollectionFrom: aCollection [

	| newCollection |
	newCollection := OrderedCollection new.
	newCollection add: (aCollection at: 1).
	2 to: aCollection size do: [ :index | 
		newCollection add:
			(newCollection at: index - 1) + (aCollection at: index) ].


	^ newCollection
]

{ #category : #action }
GameBoard >> diceResultOf: aShip [
	|dieResult|
	dieResult  := 0.
	dieResult  := self throwVariousDices: dieCollection .
	dieResult := dieResult + (aShip resultOfCards) + (self resultOfCardsForAll).
	^dieResult .
]

{ #category : #creating }
GameBoard >> fillWith: players [
	|aDeckOfCards|
	aDeckOfCards := DeckOfCards new.

	players do: [ :each | collectionOfShips add: each ].

	1 to: collectionOfShips size do: [ :counter | 
		aDeckOfCards designateRandomCardTo: counter from: self.
		aDeckOfCards designateRandomCardTo: counter from: self. ]
]

{ #category : #initialization }
GameBoard >> initializeWith: numberOfCells and: numberOfLaps [ 
	cells := numberOfCells .
	laps := numberOfLaps.
	aCollectionOfSpecialCells := OrderedCollection new.
	collectionOfShips := OrderedCollection new.
	collectionOfCardsForAllShips := OrderedCollection new.
]

{ #category : #validation }
GameBoard >> laps [
	^ laps
]

{ #category : #action }
GameBoard >> lastEffect [
	^lastEffectUsed.
]

{ #category : #action }
GameBoard >> move: aShip [ 
	| aNumberOfShip actualShipPosition result specialEffect auxResult aDieResult |

	aDieResult := self diceResultOf: aShip .
	aNumberOfShip := aShip numberOfShip.
	actualShipPosition := ((collectionOfShips at: aNumberOfShip)shipPosition) currentCell.
	result := actualShipPosition + aDieResult .
	auxResult := positionManager updateResult: result.
	specialEffect := self specialEffectAtCell: auxResult.
	self move:(collectionOfShips at: aNumberOfShip) using: specialEffect and: result  .
]

{ #category : #action }
GameBoard >> move: aShip using: specialEffect and: result [ 
	|newPosition turnShip|
	newPosition := positionManager manageCellsOf: aShip shipPosition at: result.
	aShip changePosition: newPosition.
	turnShip:= self shipWithNumber:  (self turn) .
	lastEffectUsed:= specialEffect applyTo:  self  for: turnShip  . 
]

{ #category : #validation }
GameBoard >> positionAtCollectionOf: aShip [

	| anotherShip counter |
	counter := 1.
	anotherShip := collectionOfShips  at: counter.
	[ anotherShip isTheSameAs: aShip ] whileFalse: [ 
		counter := counter + 1.
		anotherShip := collectionOfShips  at: counter ].
	^ anotherShip
]

{ #category : #actions }
GameBoard >> positionManager [
	^ positionManager
]

{ #category : #validation }
GameBoard >> ranking [
	| array sortedArray |
	array := collectionOfShips .
	sortedArray := array sorted: [:player1 :player2 | (player1 shipPosition ) currentLap    < (player2 shipPosition ) currentLap  ].
	sortedArray := sortedArray sorted: [:player1 :player2 | (player1 shipPosition )currentCell  < (player2 shipPosition )  currentCell ].
	sortedArray :=sortedArray sorted: [:player1 :player2 | ((player1 shipPosition) currentParsec )nominalValue  < ((player2 shipPosition ) currentParsec)nominalValue  ].
	^sortedArray 
	 
]

{ #category : #action }
GameBoard >> resultOfCardsForAll [
	| result |
	result := 0.
	collectionOfCardsForAllShips do: [ :each | 
		result := result + each amountToChange ].

	^ result
	
]

{ #category : #positioning }
GameBoard >> shipWithNumber: index [ 
	^ (collectionOfShips  at: index )
]

{ #category : #validation }
GameBoard >> specialEffectAtCell: aNumberOfCell [

	| typeOfCell |
	typeOfCell := NullEffect new.
	aCollectionOfSpecialCells do: [ :each | 
		each numberOfSpecialCell = aNumberOfCell ifTrue: [ 
			typeOfCell := each typeOfSpecialEffect ] ].

	^ typeOfCell
]

{ #category : #adding }
GameBoard >> store: aCard [ 
	collectionOfCardsForAllShips add: aCard.
]

{ #category : #action }
GameBoard >> throwVariousDices: aCollectionOfDices [

	| result |
	result := 0.
	aCollectionOfDices do: [ :each | result := result + each throw ].

	^ result
]

{ #category : #action }
GameBoard >> turn [
	^ turn
]

{ #category : #action }
GameBoard >> turnOf: numberOfShip [

	turn := numberOfShip.
	self winner = 0
		ifTrue: [ self move: (collectionOfShips at: numberOfShip) ]
		ifFalse: [ Error signal: 'There is a winner and the game has finished, unless you have a card that prevents it, you cant throw' ]
]

{ #category : #validation }
GameBoard >> winner [

	| counter shipLap |
	counter := 1.
	shipLap := (collectionOfShips at: counter) shipPosition currentLap.
	[ counter >= collectionOfShips size or: shipLap >= (laps + 1) ] 
		whileFalse: [ counter := counter + 1. 
			shipLap := (collectionOfShips at: counter) shipPosition currentLap.].

	(counter <= collectionOfShips size and: shipLap >= (laps + 1))
		ifTrue: [ ^ (collectionOfShips at: counter) numberOfShip ]
		ifFalse: [ ^ 0 ]
]
