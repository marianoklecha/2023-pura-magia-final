Class {
	#name : #GameTests,
	#superclass : #TestCase,
	#instVars : [
		'aGame',
		'cells',
		'numberOfLaps',
		'amountOfPlayers',
		'aGameBoard',
		'numbers',
		'anotherNumbers',
		'die1',
		'die2',
		'arrayOfDie',
		'numberOfParsecs'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
GameTests >> setUpGameWith:  anAmountOfPlayers andGameboardWith: anAmountOfCells and: laps [
	cells:= anAmountOfCells .
	numberOfLaps:= laps.
	amountOfPlayers := anAmountOfPlayers .
	
	aGameBoard := GameBoard with: cells and: numberOfLaps.
	aGame:= ShipsGame with: amountOfPlayers and: aGameBoard.
]

{ #category : #running }
GameTests >> setUpLoadedDiceWith: array1 and: array2 [
	
	numbers := array1 .
	anotherNumbers := array2 .
	die1 := LoadedDie with: numbers .
	die2 := LoadedDie with: anotherNumbers .

	arrayOfDie := OrderedCollection new.
	arrayOfDie add: die1 .
	arrayOfDie add: die2.
	
	aGameBoard cellsWith: 0 and: arrayOfDie  .
]

{ #category : #running }
GameTests >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [
	self
		should: anErrorBlock 
		raise: anExceptionClass 
		withExceptionDo: [ :error |
			self assert: error messageText equals: anErrorMessage 
			 ].
]

{ #category : #tests }
GameTests >> test001GameIsCreated [

aGame:= ShipsGame new.
self assert:(aGame isKindOf: ShipsGame)
]

{ #category : #tests }
GameTests >> test002GameStateBeforeStartThenMessage [

self setUpGameWith: 1 andGameboardWith: 4 and: 1.

"self assert: aGame result equals: 'The Game does not have a winner' "
]

{ #category : #tests }
GameTests >> test003GameIsStartedThenWinnerShip [
| aShip|
aShip := ShipPosition new.
self setUpGameWith: 1 andGameboardWith: 4 and: 1.
 
self deny: aGame winner equals: aShip  
]

{ #category : #tests }
GameTests >> test004GameIsStartedWithAGameBoardThenCheckTheAmountOfCells [
| aShip  players|
"aGame:= ShipsGame initializeEmpty."
aShip  := ShipPosition  new.
players := OrderedCollection new.
players add: aShip .
cells:= 4.
aGameBoard := GameBoard with: cells and: 1.

"aGame startwith: players and: aGameBoard.
 
self assert: aGameBoard amountOfCells equals: 4 ." "OBSOLET BECAUSE WE ADDED THE CARDS"
]

{ #category : #tests }
GameTests >> test005ShipHasPosition [
| aPlayer   dice  players|
"aGame:= ShipsGame initializeEmpty."
aPlayer := ShipPosition   new.
players := OrderedCollection new.
players add: aPlayer .
dice := 0.
cells:= 4.
aGameBoard := GameBoard with: cells and: 1.

"aGame startwith: players and: aGameBoard.

self assert: (aGameBoard playerPosition: dice ) equals: 0." "OBSOLET BECAUSE WE ADDED THE CARDS"
 

  
]

{ #category : #tests }
GameTests >> test006ShipPositionLowerThanTotalCellsThenNotWinner [
| aPlayer   players|
"aGame:= ShipsGame initializeEmpty."
aPlayer := ShipPosition new.
players := OrderedCollection new.
players add:aPlayer.
cells:= 4.
aGameBoard := GameBoard with: cells and: 1.

"aGame startwith: players and: aGameBoard.

self deny: aGame result equals: aPlayer." "OBSOLET BECAUSE WE ADDED THE CARDS"

  
]

{ #category : #tests }
GameTests >> test007ShipPositionSameAsTotalCellsThenWinner [
|  aPlayer  dice players|
"aGame:= ShipsGame initializeEmpty."
aPlayer := ShipPosition new.
players := OrderedCollection new.
players add:aPlayer.
cells:= 4.
dice:= 4.
"aGameBoard := GameBoard with: cells .
aGame startwith: players and: aGameBoard.
aGameBoard move: aPlayer adding: dice."

"self assert: (aGameBoard checkPositionOf:aPlayer) equals: cells."
"self deny: (aGame winner) equals: aPlayer "
"Cambio la implementacion del winner"

  
]

{ #category : #tests }
GameTests >> test008PlayerPlayTheGame2RoundsThenFinalPositionEqualsAmountOfCells [
| aPlayer   dice players|
"aGame:= ShipsGame initializeEmpty."
aPlayer := ShipPosition new.
players := OrderedCollection new.
players add:aPlayer.
cells:= 4.
dice:= 4.
aGameBoard := GameBoard with: cells and: 1.
"aGame startwith: players and: aGameBoard."

"aGameBoard move: aPlayer adding: dice.

self assert: (aGameBoard checkPositionOf:aPlayer) equals: cells."

  
]

{ #category : #tests }
GameTests >> test009PlayersPlayTheGame2RoundsThenCheckPositions [
| marian delfi  players  dice |
"aGame:= ShipsGame initializeEmpty."
marian := ShipPosition new.
delfi := ShipPosition new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
dice:= 1.
aGameBoard := GameBoard with: cells and: 1.

"aGame startwith: players  and: aGameBoard."
"aGameBoard move: marian  adding: dice.
self assert: (aGameBoard  checkPositionOf: marian  )  equals: 1.
dice:=2.
aGameBoard move: delfi   adding: dice.
self assert: (aGameBoard  checkPositionOf: delfi  )  equals: 2.
aGameBoard move: marian  adding: dice.
self assert: (aGameBoard  checkPositionOf: marian  )  equals: 3.
"
  
]

{ #category : #tests }
GameTests >> test010PlayersPlayTheGame3RoundsThenPlayer1Wins [
| marian delfi  players  dice |
"aGame:= ShipsGame initializeEmpty."
marian := ShipPosition new.
delfi := ShipPosition new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
dice:= 1.
aGameBoard := GameBoard with: cells and: 1.
"aGame startwith: players  and: aGameBoard."

"aGameBoard move: marian  adding: dice.
self assert: (aGameBoard  checkPositionOf: marian  )  equals: 1.
dice:=2.
aGameBoard move: delfi   adding: dice.
self assert: (aGameBoard  checkPositionOf: delfi  )  equals: 2.
aGameBoard move: marian  adding: dice.
self assert: (aGameBoard  checkPositionOf: marian  )  equals: 3.
dice := 1.
aGameBoard move: delfi   adding: dice.
self assert: (aGameBoard  checkPositionOf: delfi  )  equals: 3.
aGameBoard move: marian  adding: dice.
self assert: (aGameBoard  checkPositionOf: marian  )  equals: 4."
"self assert: (aGame winner) equals: marian."
"Cambio la implementacion del winner"



  
]

{ #category : #tests }
GameTests >> test011PlayersPlayWithRoundsThenCheckPosition [
| marian delfi  players  dice |
"aGame:= ShipsGame initializeEmpty."
marian := ShipPosition new.
delfi := ShipPosition new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
numbers := #(1 1 1)  .
dice:= LoadedDie with:numbers.
arrayOfDie  := OrderedCollection new.
arrayOfDie  add: dice .
aGameBoard := GameBoard with: cells and:1 .

"aGame startwith: players  and: aGameBoard." "OBSOLET BECAUSE WE ADDED THE CARDS"
"aGame playUntilWinner: arrayOfDices."

"self assert: (aGameBoard checkPositionOf: delfi)equals: 3. " "Cambiaron las implementaciones"




  
]

{ #category : #tests }
GameTests >> test011PlayersRoundsUntilOneWins [
| marian delfi  players  dice |
"aGame:= ShipsGame initializeEmpty."
marian := ShipPosition new.
delfi := ShipPosition new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
numbers := #(1 1 1)  .
dice:= LoadedDie with:numbers.
arrayOfDie  := OrderedCollection new.
arrayOfDie  add: dice .
aGameBoard := GameBoard with: cells and:1.
"aGame startwith: players  and: aGameBoard." "OBSOLET BECAUSE WE ADDED THE CARDS"

"aGame playUntilWinner: arrayOfDices."

"self assert: (aGame winner)equals: marian. 
self deny: (aGame winner)equals: delfi." "Cambió la implementacion del winner"




  
]

{ #category : #tests }
GameTests >> test012PlayersRoundsUntilOneWins [
| marian delfi  players  dice |
"aGame:= ShipsGame initializeEmpty."
marian := ShipPosition new.
delfi := ShipPosition new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
numbers := #(1 2 3)  .
dice:= LoadedDie with:numbers.
arrayOfDie := OrderedCollection new.
arrayOfDie add: dice .
aGameBoard := GameBoard with: cells and:1.
"aGame startwith: players  and: aGameBoard." "OBSOLET BECAUSE WE ADDED THE CARDS"
"aGame playUntilWinner: arrayOfDices."

"self assert: (aGame  winner)equals: marian. "



  
]

{ #category : #tests }
GameTests >> test013PlayWithLoadedDiceThenWinsPlayer2 [
| marian delfi  players  dice  |
"aGame:= ShipsGame initializeEmpty."
marian := ShipPosition new.
delfi := ShipPosition new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
dice:= LoadedDie .
numbers := #(1 2 1 4)  .
dice := LoadedDie with: numbers .
arrayOfDie := OrderedCollection new.
arrayOfDie add: dice .
aGameBoard := GameBoard with: cells and:1.
"aGame startwith: players  and: aGameBoard." "OBSOLETO 2"

"aGame playUntilWinner: arrayOfDices." "OBSOLETO"

"self assert: (aGame winner)equals: delfi . "

]

{ #category : #tests }
GameTests >> test014playWithRandomDiceThenWinner [
| marian delfi  players  aDice  |
"aGame:= ShipsGame initializeEmpty."
marian := ShipPosition new.
delfi := ShipPosition new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
aDice := Die with: 4.
arrayOfDie := OrderedCollection new.
arrayOfDie add: aDice .
aGameBoard := GameBoard with: cells and:1.
"aGame startwith: players  and: aGameBoard." "OBSOLETO 2"

"aGame playUntilWinner: arrayOfDices." "OBSOLETO"

"self deny: ((aGame winner)isKindOf:  Integer) . "



  
]

{ #category : #tests }
GameTests >> test015PlayWithNPlayersUntilGameEnds [
self setUpGameWith: 1 andGameboardWith: 4 and: 1.

"aGame playUntilWinner: arrayOfDices. ""OBSOLETO"

"self deny: (aGame result) equals: 'The Game has ended' . "



  
]

{ #category : #tests }
GameTests >> test016PlayWithMLoadedDicesAndNPlayersThenCheckWinner [

self setUpGameWith: 3 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 6 ).

self deny: (aGame winner) equals: (aGameBoard shipWith: 1) .
self deny: (aGame winner) equals: (aGameBoard shipWith: 2) .
self deny: (aGame winner) equals: (aGameBoard shipWith: 3) .
"self assert: (aGame winner) equals: (4) ."




  
]

{ #category : #tests }
GameTests >> test017PlayWithMDicesAndNPlayersUntilTheGameEnds [
self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 6 ).

"aGame playUntilWinner: arrayOfDices ." "OBSOLETO"

"self assert: (aGame result) equals: 'The Game has ended'"



  
]

{ #category : #tests }
GameTests >> test018PlayWithMLoadedDicesAndNPlayersUntilWinnerThenCheckFinalPositions [ 
self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 6 ).

"aGame playUntilWinner: arrayOfDices ."
 
"self assert: (aGameBoard checkPositionOf: (aGameBoard shipAt: 2) ) equals: 6 ."

"Obsoleto"




  
]

{ #category : #tests }
GameTests >> test019PlayerHasAshipThenPlayerShipHasANumber [
|aPlayer|
aPlayer := Ship with:  1.


self assert: (aPlayer numberOfShip) equals: 1.




  
]

{ #category : #tests }
GameTests >> test020PlayWithMLoadedDicesAndNPlayersUntilWinnerThenCheckShipNumberAtFirstPositionEqualsOne [

   "aGame:= ShipsGame initializeEmpty."
	cells:= 8.
	numberOfLaps:= 2.
	amountOfPlayers:=1.
	numbers := #(1 1 ).
	anotherNumbers := #(3 4).
	die1  := LoadedDie with: numbers .
	die2  := LoadedDie with: anotherNumbers .
	arrayOfDie  := OrderedCollection new.
	arrayOfDie add: die1  .
	arrayOfDie add: die2 .
	aGameBoard := GameBoard with: cells and: numberOfLaps.
	aGameBoard cellsWith: 0 and: arrayOfDie .
	"aGame startwith: amountOfPlayers   and: aGameBoard."
	amountOfPlayers := 4.
	numberOfLaps:=1.
	numbers := #(2 1 1 1)  .
	die1  := LoadedDie with: numbers .
	arrayOfDie := OrderedCollection new.
	arrayOfDie add: die1  .

	"aGame playUntilWinner: arrayOfDices .

	self assert: (aGameBoard winner) equals: 1 ."




  
]

{ #category : #tests }
GameTests >> test021PlayWithMDicesWithNegativeNumber [


self should:  [Die with: -3] raise: Error withMessage: 'Cannot create die with negative amount of faces'.




  
]

{ #category : #tests }
GameTests >> test022PlayWithGameBoardWithNegativeAmountOfCellsThenThrowAnError [

self should:[ GameBoard  with: -4 and: -1] raise: Error withMessage: 'Cannot create GameBoard with negative amount of cells or laps'.




  
]

{ #category : #tests }
GameTests >> test023PlayerThrowWithTurns [ 

self setUpGameWith:4 andGameboardWith: 8 and:1 .
self setUpLoadedDiceWith: #(1 1 1 1) and: #(2 2 2 4) .

aGame throwNextShip.

self assert: (aGameBoard cellOfShip: 1)  equals: 3 .




  
]

{ #category : #tests }
GameTests >> test024PlayWithLoadedDiceTwoTurnsThenCheckPositionOfTheSecondPlayer [

self setUpGameWith:4 andGameboardWith: 8 and: 1 .
self setUpLoadedDiceWith: #(1 1 1 1) and: #(2 7 2 4) .


aGame throwNextShip .
aGame throwNextShip .

self assert: (aGameBoard cellOfShip: 2) equals: 8 .




  
]

{ #category : #tests }
GameTests >> test025PlayThreeTurnsWithLoadedDiceAndTwoPlayersThenCheckPositionChangeOfTheFirstPlayer [

self setUpGameWith: 2 andGameboardWith: 8 and: 1 .
self setUpLoadedDiceWith: #(1 1) and: #(2 2) .

aGame throwNextShip .
aGame throwNextShip .
aGame throwNextShip .

self assert: (aGameBoard cellOfShip: 1) equals: 6 .




  
]

{ #category : #tests }
GameTests >> test026PlayWithNormalDieAndCheckThereIsAWinner [

	die1 := Die with: 20.
	die2 := Die with: 15.
	arrayOfDie := OrderedCollection new.
	arrayOfDie add: die1.
	arrayOfDie add: die2.
	self setUpGameWith: 2 andGameboardWith: 2 and: 1.
	aGameBoard cellsWith: 0 and: arrayOfDie  .

	aGame throwNextShip.
	
	self deny: aGame winner equals: 0
]

{ #category : #tests }
GameTests >> test027GameBoardCircularWithXLaps [

self setUpGameWith: 1 andGameboardWith: 5 and: 2.
self setUpLoadedDiceWith: #(3 1 ) and: #(3 4 ).

aGame throwNextShip .
self assert: (aGameBoard shipWith: 1) actualPosition currentLap equals:2.




  
]

{ #category : #tests }
GameTests >> test028GameBoardCircularWithXLapsAndPlayerWithLaps [

self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).

self assert: (aGameBoard lapOfShip: 1) equals: 1 .




  
]

{ #category : #tests }
GameTests >> test029GameBoardCircularWithXLapsAndPlayerChangeAcualLap [

self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).

aGame throwNextShip .
aGame throwNextShip.

self assert: (aGameBoard lapOfShip: 1) equals: 2 .





  
]

{ #category : #tests }
GameTests >> test030GameBoardCircularWithXLapsAndPlayerCheckPositionInNewLap [

self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).

aGame throwNextShip .
aGame throwNextShip.

self assert: (aGameBoard cellOfShip: 1)   equals: 1 .
self assert: (aGameBoard lapOfShip:  1)  equals: 2.





  
]

{ #category : #tests }
GameTests >> test031RankingPlayersHavingPlayedAll [
| parsecs  amountOfParsecsToMove aRanking|

self setUpGameWith: 3 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 2) and: #(3 2 4).
amountOfParsecsToMove:= #(7 3 2 1).
parsecs := 4. 
aGameBoard cellsWith: parsecs and: arrayOfDie .

aGame throwNextShip.
aGame throwNextShip.
aGame throwNextShip.
aRanking := aGame ranking.

self assert: (aRanking at: 1) numberOfShip  equals: 3 .
self assert: (aRanking at: 2) numberOfShip  equals: 1 .
self assert: (aRanking at: 3) numberOfShip  equals: 2 .





  
]

{ #category : #tests }
GameTests >> test052UsingRandomDieAndCheckingTheResult [
| die result|
die := Die with: 5.

result:= die throw .

self assert: (result > 0).





  
]

{ #category : #tests }
GameTests >> test053GameUsingCellWithCardThenValidateAmountOfCards [
|anSpecialCard|

self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
anSpecialCard := CardAssignation withDeck.
aGameBoard add: anSpecialCard at: 4.

aGame throwNextShip .

self assert: (((aGameBoard shipWith: 1)shipCards) cardsInHand size) equals: 3.

]

{ #category : #tests }
GameTests >> test054GameUsingWormholeAndShipDecreasesLapWhenFalling [
| wormHole|
wormHole:= WormHole  new.
self setUpGameWith: 1 andGameboardWith: 4 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(5 0 ).
aGameBoard add: wormHole at: 3.

aGame throwNextShip.
self assert: (aGameBoard lapOfShip: 1)  equals: 2 .

aGame throwNextShip.
self assert: (aGameBoard lapOfShip:  1) equals: 1 .





  
]

{ #category : #tests }
GameTests >> test055UsingParsecsAndLightYears [
|parsecs lightYears|

parsecs := Parsecs with: 2.
lightYears := LightYears with: 9. 

self assert: ((parsecs plus: lightYears)nominalValue) equals: 5





  
]

{ #category : #tests }
GameTests >> test056GameWithLightYearsAndParsecsInHyperJump [
| hyperJump amountOfParsecsToMove parsc1 parsc2 light1 light2 collection1 aShip|

self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 6 ).
parsc1 := Parsecs with: 7.
light1 := LightYears with: 9.
parsc2 := Parsecs with: 2.
light2 := LightYears with: 3.
amountOfParsecsToMove:= OrderedCollection new.
collection1:=OrderedCollection new.
collection1 add: parsc1 ;add: light1 ;add: parsc2 ;add: light2  .
amountOfParsecsToMove add: collection1 .
hyperJump := HyperJump with: amountOfParsecsToMove .
aGameBoard cellsWith: 4 and: arrayOfDie .
aGameBoard add: hyperJump  at: 3 .
aShip:=((aGameBoard shipWith: 1)).

aGame throwNextShip.

self assert: (((aShip actualPosition) currentParsec )nominalValue)  equals: 3  .
self assert: (aGameBoard cellOfShip:  1 ) equals: 4  .

aGame throwNextShip.

self assert: ((aShip actualPosition currentParsec)nominalValue)  equals: 2  .
self assert: (aGameBoard cellOfShip:  1 ) equals: 4  .





  
]

{ #category : #tests }
GameTests >> test057GamePlayersWithShipPositionShipCards [

self setUpGameWith: 1 andGameboardWith: 4 and: 1.

self assert: (((aGameBoard shipWith: 1)actualPosition)currentCell ) equals: 0





  
]

{ #category : #tests }
GameTests >> test058WhenThereIsAWinnerNextPlayerCantThrow [
| parsecs  amountOfParsecsToMove|

self setUpGameWith: 2 andGameboardWith: 8 and: 1.
self setUpLoadedDiceWith: #(1 1 2) and: #(3 2 5).
amountOfParsecsToMove:= #(7 3 2 1).
parsecs := 4. 
aGameBoard cellsWith: parsecs and: arrayOfDie .

aGame throwNextShip. "P1: 4 LAP1 P2: 0 LAP1"
aGame throwNextShip. "P1: 4 LAP1 P2: 3 LAP1"
aGame throwNextShip. "P1: 3 LAP2 P2: 3 LAP1  --> Ship 1 has won"

self assert: aGame winner equals: 1. 
self should:  [aGame throwNextShip] raise: Error withMessage: 'There is a winner and the game has finished, unless you have a card that prevents it, you cant throw'.





  
]

{ #category : #tests }
GameTests >> test059PositionManagerThatSolvesInconsistentPositionStates [
|newShipPosition shipPosition aChosenShip cellsToSum parsecs parsecsToSum aPositionManager|
self setUpGameWith: 1 andGameboardWith: 4 and: 4.
self setUpLoadedDiceWith: #(1 1 ) and: #(5 0).
parsecs := 4. 
cellsToSum := 9.
parsecsToSum := 6.
aGameBoard cellsWith: parsecs and: arrayOfDie .
aPositionManager := PositionManager with: 4 and: 4.
aChosenShip:= aGameBoard shipWith: 1 .
shipPosition := aChosenShip actualPosition .

newShipPosition := aPositionManager manageCellsOf: shipPosition at: cellsToSum.
newShipPosition := aPositionManager manageParsecsOf: newShipPosition at: parsecsToSum.
aChosenShip changePosition: newShipPosition.

self assert: aChosenShip actualPosition currentLap equals: 3.
self assert: aChosenShip actualPosition currentCell equals: 2.
self assert: aChosenShip actualPosition currentParsec nominalValue equals: 2.





  
]

{ #category : #tests }
GameTests >> test060GameboardRobustInstanceCreation [
|arrayOfDie1 arrayOfDie2|
self setUpGameWith: 1 andGameboardWith: 4 and: 1.
arrayOfDie1 := OrderedCollection new.
arrayOfDie2 := OrderedCollection new.
die1 := LoadedDie with: #(1 2) .
arrayOfDie2 add: die1 .

self should:  [aGameBoard cellsWith: 5 and: arrayOfDie1] raise: Error withMessage: 'The collection of dices cant be empty'.
self should:  [aGameBoard cellsWith: -2 and: arrayOfDie2] raise: Error withMessage: 'The amount of parsecs cant be negative'.





  
]
