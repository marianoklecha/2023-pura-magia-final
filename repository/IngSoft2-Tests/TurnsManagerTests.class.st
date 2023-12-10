Class {
	#name : #TurnsManagerTests,
	#superclass : #TestCase,
	#instVars : [
		'cells',
		'numberOfLaps',
		'amountOfPlayers',
		'aGameBoard',
		'aGame',
		'aCollectionOfCards',
		'loadedDeck'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
TurnsManagerTests >> setUpGameWith:  anAmountOfPlayers andGameboardWith: anAmountOfCells and: laps [
	cells:= anAmountOfCells .
	numberOfLaps:= laps.
	amountOfPlayers := anAmountOfPlayers .
	aGameBoard := GameBoard with: cells and: numberOfLaps.
	aGameBoard cellsDividedIn: 1.
	aGame:= ShipsGame with: amountOfPlayers and: aGameBoard.
]

{ #category : #running }
TurnsManagerTests >> setUpLoadedDeck [
	aCollectionOfCards := OrderedCollection new.
	loadedDeck := LoadedDeck with: aCollectionOfCards.
	aGame useCardsFrom: loadedDeck.
]

{ #category : #running }
TurnsManagerTests >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [
	self
		should: anErrorBlock 
		raise: anExceptionClass 
		withExceptionDo: [ :error |
			self assert: error messageText equals: anErrorMessage 
			 ].
]

{ #category : #tests }
TurnsManagerTests >> test061CreateTurnsManager [

	| turnsManager |
	turnsManager := TurnsManager new.

	self assert: (turnsManager isKindOf: TurnsManager).
]

{ #category : #tests }
TurnsManagerTests >> test062TurnsManagerGivesTurnsInOrder [

	| turnsManager shipNumber1 shipNumber2 shipNumber3 shipNumber4|
	turnsManager := TurnsManager with: 3.
	
	shipNumber1 := turnsManager nextShipNumber.
	shipNumber2 := turnsManager nextShipNumber.
	shipNumber3 := turnsManager nextShipNumber.
	shipNumber4 := turnsManager nextShipNumber.

	self assert: shipNumber1 equals: 1.
	self assert: shipNumber2 equals: 2.
	self assert: shipNumber3 equals: 3.
	self assert: shipNumber4 equals: 1.
]

{ #category : #tests }
TurnsManagerTests >> test063TurnsManagerGivesTurnsInReverseOrder [

	| turnsManager shipNumber1 shipNumber2 shipNumber3 shipNumber4 reverse|
	self setUpGameWith: 3 andGameboardWith: 4 and: 4.
	turnsManager := aGame turnsManager .
	reverse := Reverse with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: reverse.
	aGame giveCardTo: 1.
	
	shipNumber1 := turnsManager nextShipNumber.
	reverse applyFrom: 1.
	shipNumber2 := turnsManager nextShipNumber.
	shipNumber3 := turnsManager nextShipNumber.
	shipNumber4 := turnsManager nextShipNumber.

	self assert: shipNumber1 equals: 1.
	self assert: shipNumber2 equals: 2.
	self assert: shipNumber3 equals: 1.
	self assert: shipNumber4 equals: 3.
]

{ #category : #tests }
TurnsManagerTests >> test064TurnsManagerCanSkipATurn [

	| turnsManager shipNumber1 shipNumber2 shipNumber3 shipNumber4 skip|
	self setUpGameWith: 3 andGameboardWith: 4 and: 4.
	turnsManager := aGame turnsManager .
	skip := Skip with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: skip.
	aGame giveCardTo: 1.
	
	shipNumber1 := turnsManager nextShipNumber.
	skip applyFrom: 1.
	shipNumber2 := turnsManager nextShipNumber.
	shipNumber3 := turnsManager nextShipNumber.
	shipNumber4 := turnsManager nextShipNumber.

	self assert: shipNumber1 equals: 1.
	self assert: shipNumber2 equals: 3.
	self assert: shipNumber3 equals: 1.
	self assert: shipNumber4 equals: 2.
]

{ #category : #tests }
TurnsManagerTests >> test065TurnsManagerAllowsDoubleTurn [

	| turnsManager shipNumber1 shipNumber2 shipNumber3 shipNumber4 shipNumber5 double|
	self setUpGameWith: 3 andGameboardWith: 4 and: 4.
	turnsManager := aGame turnsManager .
	double := Double with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: double.
	aGame giveCardTo: 1.
	
	shipNumber1 := turnsManager nextShipNumber.
	double applyFrom: 1.
	shipNumber2 := turnsManager nextShipNumber.
	shipNumber3 := turnsManager nextShipNumber.
	shipNumber4 := turnsManager nextShipNumber.
	shipNumber5 := turnsManager nextShipNumber.

	self assert: shipNumber1 equals: 1.
	self assert: shipNumber2 equals: 2.
	self assert: shipNumber3 equals: 2.
	self assert: shipNumber4 equals: 3.
	self assert: shipNumber5 equals: 1.
]

{ #category : #tests }
TurnsManagerTests >> test066TurnsManagerRobustCreation [

	| turnsManager |
	
	self should:  [turnsManager :=  TurnsManager with: -1] raise: Error withMessage: 'The amount of ships must be 1 or more'.
]
