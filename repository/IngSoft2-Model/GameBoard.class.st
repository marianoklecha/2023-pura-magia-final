Class {
	#name : #GameBoard,
	#superclass : #Object,
	#instVars : [
		'cells',
		'laps',
		'aCollectionOfSpecialCells',
		'parsecsByCell',
		'dieCollection',
		'lastEffectUsed',
		'collectionOfShips',
		'positionManager',
		'collectionOfCardsForAllShips',
		'spaceSheriff'
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
	aCollectionOfSpecialCells at: aNumberOfCell put: (aEffect with: aNumberOfCell).
]

{ #category : #action }
GameBoard >> add: aCard to: numberOfShip [

	collectionOfShips do: [ :each | 
		(each shipCards cardsInHand includes: aCard) ifTrue: [ 
			Error signal: 'The card was already assigned to a ship' ] ].
	(self shipWith: numberOfShip) add: aCard
]

{ #category : #action }
GameBoard >> addEffectsUsing: aCollectionOfProbabilities andForHyperJump: aCollectionOfDifferentParsecs [ 
	|randomNumber probabilities|
	
	
	probabilities := (ProbabilityOfEffects new) createCollectionFrom: aCollectionOfProbabilities .
	
	1 to: cells do: [ :index | randomNumber:= 100 atRandom.
		
		( randomNumber >= 0 and: randomNumber < (probabilities at: 1)) ifTrue: [ 
			self add: (NullEffect new) at: index. 
		 ].
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

{ #category : #action }
GameBoard >> amountOfShipsPlaying [
	^ collectionOfShips  size.
]

{ #category : #action }
GameBoard >> cardsForAllShips [
	^collectionOfCardsForAllShips .
]

{ #category : #validation }
GameBoard >> cellOfShip: aNumber [
	^((self shipWith: aNumber) actualPosition) currentCell
]

{ #category : #initialization }
GameBoard >> cellsWith: anAmountOfParsecs and: aCollectionOfDice [
	self verifyCanExistWith: anAmountOfParsecs and: aCollectionOfDice.
	parsecsByCell := anAmountOfParsecs .
	positionManager := PositionManager with: cells and: anAmountOfParsecs .
	dieCollection := aCollectionOfDice .
	spaceSheriff := SpaceSheriff with: dieCollection.
	
]

{ #category : #creating }
GameBoard >> fillWith: players [
	|aDeckOfCards|
	aDeckOfCards := DeckOfCards new.

	collectionOfShips := players collect: [ :each | each ].

	1 to: collectionOfShips size do: [ :counter | 
		aDeckOfCards designateRandomCardTo: counter from: self.
		aDeckOfCards designateRandomCardTo: counter from: self. ]
]

{ #category : #initialization }
GameBoard >> initializeWith: numberOfCells and: numberOfLaps [ 
	cells := numberOfCells .
	laps := numberOfLaps.
	aCollectionOfSpecialCells := OrderedCollection new.
	1 to: cells do: [ :number | aCollectionOfSpecialCells add: (NullEffect new) ].
	collectionOfShips := OrderedCollection new.
	collectionOfCardsForAllShips := OrderedCollection new.
]

{ #category : #validation }
GameBoard >> lapOfShip: aNumber [
	^ ((self shipWith: aNumber) actualPosition ) currentLap.
]

{ #category : #action }
GameBoard >> lapsToWin [
	^laps
]

{ #category : #action }
GameBoard >> lastEffectUsed [
	^lastEffectUsed.
]

{ #category : #action }
GameBoard >> move: aShip [ 
	| actualShipPosition totalResult aDieResult cardsResult|

	aDieResult := aShip throw: dieCollection .
	cardsResult := aShip resultOfCards + self resultOfCardsForAll.
	actualShipPosition := aShip actualPosition currentCell.
	totalResult := actualShipPosition + aDieResult + cardsResult.
	(spaceSheriff verifyMoveOf: aShip with: aDieResult) ifTrue: [ 
		self move: aShip with: totalResult.
		 ]
	
]

{ #category : #action }
GameBoard >> move: aShip with: aTotalResult [ 
	|newPosition auxResult specialEffect|
	
	newPosition := positionManager manageCellsOf: aShip actualPosition at: aTotalResult.
	aShip changePosition: newPosition.
	auxResult := positionManager updateResult: aTotalResult.
	specialEffect := self specialEffectAtCell: auxResult.
	lastEffectUsed:= specialEffect applyTo: self for: aShip . 
]

{ #category : #actions }
GameBoard >> positionManager [
	^ positionManager
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
GameBoard >> shipWith: aNumber [ 
	^ (collectionOfShips at: aNumber )
]

{ #category : #action }
GameBoard >> spaceSheriff [
	^ spaceSheriff
]

{ #category : #validation }
GameBoard >> specialEffectAtCell: aNumberOfCell [

	^ aCollectionOfSpecialCells at: aNumberOfCell
]

{ #category : #adding }
GameBoard >> store: aCard [ 
	collectionOfCardsForAllShips add: aCard.
]

{ #category : #validation }
GameBoard >> verifyCanExistWith: anAmountOfParsecs and: aCollection [ 
	(aCollection isEmpty) ifTrue:[ Error signal: 'The collection of dices cant be empty' ].
	(anAmountOfParsecs < 0) ifTrue:[ Error signal: 'The amount of parsecs cant be negative' ]
]
