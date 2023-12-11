Class {
	#name : #GameBoard,
	#superclass : #Object,
	#instVars : [
		'aCollectionOfSpecialCells',
		'dieCollection',
		'lastEffectUsed',
		'collectionOfShips',
		'collectionOfCardsForAllShips',
		'spaceSheriff',
		'positionsManager'
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
GameBoard >> addEffectsUsing: aCollectionOfProbabilities andForHyperJump: aCollectionOfDifferentParsecs [ 

	|randomNumber probabilities amountOfCells|
	amountOfCells := positionsManager cells.
	probabilities := (ProbabilityOfEffects new) createCollectionFrom: aCollectionOfProbabilities .
	1 to: amountOfCells do: [ :index | randomNumber:= 100 atRandom.
		( randomNumber >= 0 and: randomNumber < (probabilities at: 1))
			ifTrue: [ self add: (NullEffect new) at: index. ].
		( randomNumber >= (probabilities  at: 1) and: randomNumber < (probabilities at: 2))
			ifTrue: [ self add: (WormHole new) at: index. ].
	 	(randomNumber >= (probabilities  at: 2) and: randomNumber < (probabilities at: 3))
			ifTrue: [ self add: (SpeedUp new) at: index. ].
			(randomNumber >= (probabilities  at: 3) and: randomNumber < (probabilities at: 4))
		ifTrue: [ self add: (MoonWalk  with: (amountOfCells atRandom)*(-1)) at: index. ].
			(randomNumber >= (probabilities  at: 4) and: randomNumber < (probabilities at: 5))
		ifTrue: [ self add: (HyperJump  with: aCollectionOfDifferentParsecs) at: index. ].
			(randomNumber >= (probabilities  at: 5) and: randomNumber < (probabilities at: 6)) 
		ifTrue: [ self add: (AtomicBomb  new) at: index. ].
			(randomNumber >= (probabilities  at: 6) and: randomNumber < (probabilities at: 7))
		ifTrue: [ self add: (CardAssignation withDeck) at: index. ].].

]

{ #category : #action }
GameBoard >> amountOfShipsPlaying [

	^ collectionOfShips  size.
]

{ #category : #action }
GameBoard >> cardsForAllShips [

	^collectionOfCardsForAllShips .
]

{ #category : #action }
GameBoard >> cellsDividedIn: anAmountOfParsecs [
	positionsManager cellsDividedIn: anAmountOfParsecs
]

{ #category : #action }
GameBoard >> changeCardsForAllWith: aCollectionOfCards [

	collectionOfCardsForAllShips := aCollectionOfCards.
]

{ #category : #creating }
GameBoard >> fillWith: ships [

	collectionOfShips := ships collect: [ :each | each ].
	
]

{ #category : #initialization }
GameBoard >> initializeWith: numberOfCells and: numberOfLaps [

	positionsManager := PositionsManager with: numberOfCells and: numberOfLaps .
	collectionOfShips := OrderedCollection new.
	collectionOfCardsForAllShips := OrderedCollection new.
	aCollectionOfSpecialCells := OrderedCollection new.
	1 to: numberOfCells do: [ :number | aCollectionOfSpecialCells add: (NullEffect new) ].
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
		self move: aShip with: totalResult]
	
]

{ #category : #action }
GameBoard >> move: aShip with: aTotalResult [ 

	|newPosition auxResult specialEffect|
	newPosition := positionsManager manageCellsOf: aShip actualPosition at: aTotalResult.
	aShip changePosition: newPosition.
	auxResult := positionsManager updateToGameCellsHaving: aTotalResult.
	specialEffect := self specialEffectAt: auxResult.
	lastEffectUsed:= specialEffect applyEffectUsing: self for: aShip . 
]

{ #category : #actions }
GameBoard >> positionsManager [

	^ positionsManager
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

	(aNumber > collectionOfShips size or: aNumber < 1) ifTrue: [ 
		Error signal: 'There is no ship with that number' ].
	^ collectionOfShips at: aNumber
]

{ #category : #action }
GameBoard >> shipsCanThrowUsing: aCollectionOfDice [

	self verifyShipsCanThrowWith: aCollectionOfDice.
	dieCollection := aCollectionOfDice .
	spaceSheriff := SpaceSheriff with: dieCollection.
]

{ #category : #action }
GameBoard >> spaceSheriff [

	^ spaceSheriff
]

{ #category : #validation }
GameBoard >> specialEffectAt: aNumberOfCell [

	^ aCollectionOfSpecialCells at: aNumberOfCell
]

{ #category : #action }
GameBoard >> verifyShipsCanThrowWith: aCollection [ 

	(aCollection isEmpty) ifTrue:[ Error signal: 'The collection of dices cant be empty' ].
]
