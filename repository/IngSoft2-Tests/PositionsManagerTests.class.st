Class {
	#name : #PositionsManagerTests,
	#superclass : #TestCase,
	#instVars : [
		'cells',
		'numberOfLaps',
		'amountOfPlayers',
		'aGameBoard',
		'aGame',
		'numbers',
		'anotherNumbers',
		'die1',
		'die2',
		'arrayOfDie'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
PositionsManagerTests >> setUpGameWith:  anAmountOfPlayers andGameboardWith: anAmountOfCells and: laps [
	cells:= anAmountOfCells .
	numberOfLaps:= laps.
	amountOfPlayers := anAmountOfPlayers .
	aGameBoard := GameBoard with: cells and: numberOfLaps.
	aGame:= ShipsGame with: amountOfPlayers and: aGameBoard.
]

{ #category : #running }
PositionsManagerTests >> setUpLoadedDiceWith: array1 and: array2 [
	
	numbers := array1 .
	anotherNumbers := array2 .
	die1 := LoadedDie with: numbers .
	die2 := LoadedDie with: anotherNumbers .
	arrayOfDie := OrderedCollection new.
	arrayOfDie add: die1 .
	arrayOfDie add: die2.
	aGameBoard shipsCanThrowUsing: arrayOfDie  .
]

{ #category : #tests }
PositionsManagerTests >> test059PositionManagerThatSolvesInconsistentPositionStates [
|newShipPosition shipPosition aChosenShip cellsToSum parsecs parsecsToSum aPositionManager|
self setUpGameWith: 1 andGameboardWith: 4 and: 4.
self setUpLoadedDiceWith: #(1 1 ) and: #(5 0).
parsecs := 4. 
cellsToSum := 9.
parsecsToSum := 6.
aGameBoard cellsDividedIn: 4.
aGameBoard shipsCanThrowUsing: arrayOfDie .
aPositionManager := aGameBoard positionsManager .
aGameBoard cellsDividedIn: 4.
aChosenShip:= aGameBoard shipWith: 1 .
shipPosition := aChosenShip actualPosition .

newShipPosition := aPositionManager manageCellsOf: shipPosition at: cellsToSum.
newShipPosition := aPositionManager manageParsecsOf: newShipPosition at: parsecsToSum.
aChosenShip changePosition: newShipPosition.

self assert: aChosenShip actualPosition currentLap equals: 3.
self assert: aChosenShip actualPosition currentCell equals: 2.
self assert: aChosenShip actualPosition currentParsec nominalValue equals: 2.





  
]
