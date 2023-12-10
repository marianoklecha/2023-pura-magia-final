Class {
	#name : #DeckTests,
	#superclass : #TestCase,
	#instVars : [
		'cells',
		'numberOfLaps',
		'amountOfPlayers',
		'aGameBoard',
		'aGame'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
DeckTests >> setUpGameWith:  anAmountOfPlayers andGameboardWith: anAmountOfCells and: laps [
	cells:= anAmountOfCells .
	numberOfLaps:= laps.
	amountOfPlayers := anAmountOfPlayers .
	aGameBoard := GameBoard with: cells and: numberOfLaps.
	aGameBoard cellsDividedIn: 1.
	aGame:= ShipsGame with: amountOfPlayers and: aGameBoard.
]

{ #category : #tests }
DeckTests >> test025CreateADeckThatGivesARandomCardToAShipFromTheGameboard [
	|aDeckOfCards ship|
	
	self setUpGameWith:  1 andGameboardWith: 10 and: 1.
	aDeckOfCards := Deck new.
	ship := 1.
	aGame useCardsFrom: aDeckOfCards.
	aGame giveCardTo: ship. 
	
	self assert: (aGameBoard shipWith: ship)shipCards cardsInHand size equals: 1  
]

{ #category : #tests }
DeckTests >> test026ShipsStartGameWith2RandomCards [
	|aDeckOfCards ship|
	
	self setUpGameWith:  1 andGameboardWith: 10 and: 1.
	aDeckOfCards := Deck new.
	aGame useCardsFrom: aDeckOfCards .
	aGame distributeFirstCards.
	ship := 1.
	
	self assert: (aGameBoard shipWith: ship)shipCards cardsInHand size equals: 2  
]
