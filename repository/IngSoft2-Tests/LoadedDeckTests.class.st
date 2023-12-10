Class {
	#name : #LoadedDeckTests,
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
LoadedDeckTests >> setUpGameWith:  anAmountOfPlayers andGameboardWith: anAmountOfCells and: laps [
	cells:= anAmountOfCells .
	numberOfLaps:= laps.
	amountOfPlayers := anAmountOfPlayers .
	aGameBoard := GameBoard with: cells and: numberOfLaps.
	aGameBoard cellsDividedIn: 1.
	aGame:= ShipsGame with: amountOfPlayers and: aGameBoard.
]

{ #category : #tests }
LoadedDeckTests >> test001LoadedDeckReceivesAndGivesCard [

	|double loadedDeck aCollectionOfCards|
	self setUpGameWith: 3 andGameboardWith: 4 and: 4.
	aCollectionOfCards := OrderedCollection new.
	double := Double with: aGame.
	aCollectionOfCards add: double.
	loadedDeck := LoadedDeck with: aCollectionOfCards.
	
	self assert: (loadedDeck giveCard) equals: double.

]
