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
	aGame := ShipsGame with: amountOfPlayers and: aGameBoard.
	aGame useCardsFrom: Deck new.
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
	aGameBoard shipsCanThrowUsing: arrayOfDie  .
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
GameTests >> test003GameIsStartedThenWinnerShip [
| aShip|
aShip := ShipPosition new.
self setUpGameWith: 1 andGameboardWith: 4 and: 1.
 
self deny: aGame winner equals: aShip  
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
GameTests >> test019PlayerHasAshipThenPlayerShipHasANumber [
|aPlayer|
aPlayer := Ship with:  1.


self assert: (aPlayer numberOfShip) equals: 1.




  
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

self assert: ((aGameBoard shipWith: 1) actualPosition currentCell)  equals: 3 .




  
]

{ #category : #tests }
GameTests >> test024PlayWithLoadedDiceTwoTurnsThenCheckPositionOfTheSecondPlayer [

self setUpGameWith:4 andGameboardWith: 8 and: 1 .
self setUpLoadedDiceWith: #(1 1 1 1) and: #(2 7 2 4) .


aGame throwNextShip .
aGame throwNextShip .

self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 8 .




  
]

{ #category : #tests }
GameTests >> test025PlayThreeTurnsWithLoadedDiceAndTwoPlayersThenCheckPositionChangeOfTheFirstPlayer [

self setUpGameWith: 2 andGameboardWith: 8 and: 1 .
self setUpLoadedDiceWith: #(1 1) and: #(2 2) .

aGame throwNextShip .
aGame throwNextShip .
aGame throwNextShip .

self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 6 .




  
]

{ #category : #tests }
GameTests >> test026PlayWithNormalDieAndCheckThereIsAWinner [

	die1 := Die with: 20.
	die2 := Die with: 15.
	arrayOfDie := OrderedCollection new.
	arrayOfDie add: die1.
	arrayOfDie add: die2.
	self setUpGameWith: 2 andGameboardWith: 2 and: 1.
	aGameBoard shipsCanThrowUsing: arrayOfDie .

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

self assert: ((aGameBoard shipWith: 1) actualPosition currentLap) equals: 1 .




  
]

{ #category : #tests }
GameTests >> test029GameBoardCircularWithXLapsAndPlayerChangeAcualLap [

self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).

aGame throwNextShip .
aGame throwNextShip.

self assert: ((aGameBoard shipWith: 1) actualPosition currentLap) equals: 2 .





  
]

{ #category : #tests }
GameTests >> test030GameBoardCircularWithXLapsAndPlayerCheckPositionInNewLap [

self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).

aGame throwNextShip .
aGame throwNextShip.

self assert: ((aGameBoard shipWith: 1) actualPosition currentCell)   equals: 1 .
self assert: ((aGameBoard shipWith: 1) actualPosition currentLap)  equals: 2.





  
]

{ #category : #tests }
GameTests >> test031RankingPlayersHavingPlayedAll [
| amountOfParsecsToMove aRanking|

self setUpGameWith: 3 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 2) and: #(3 2 4).
amountOfParsecsToMove:= #(7 3 2 1).
aGameBoard cellsDividedIn: 4.
aGameBoard shipsCanThrowUsing: arrayOfDie .

aGame throwNextShip.
aGame throwNextShip.
aGame throwNextShip.
aRanking := aGame ranking.

self assert: (aRanking at: 1) numberOfShip  equals: 3 .
self assert: (aRanking at: 2) numberOfShip  equals: 1 .
self assert: (aRanking at: 3) numberOfShip  equals: 2 .





  
]

{ #category : #tests }
GameTests >> test043GameUsingParsecs [
| parsecs |

self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
parsecs := Parsecs with: 4.

self assert: (((aGameBoard shipWith: 1) actualPosition currentParsec ) nominalValue ) equals: 0  .





  
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

self assert: (((aGameBoard shipWith: 1)shipCards) cardsInHand size) equals: 1.

]

{ #category : #tests }
GameTests >> test054GameUsingWormholeAndShipDecreasesLapWhenFalling [
| wormHole|
wormHole:= WormHole  new.
self setUpGameWith: 1 andGameboardWith: 4 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(5 0 ).
aGameBoard add: wormHole at: 3.

aGame throwNextShip.
self assert: ((aGameBoard shipWith: 1) actualPosition currentLap)  equals: 2 .

aGame throwNextShip.
self assert: ((aGameBoard shipWith: 1) actualPosition currentLap) equals: 1 .





  
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
aGameBoard cellsDividedIn: 4.
aGameBoard shipsCanThrowUsing: arrayOfDie .
aGameBoard add: hyperJump  at: 3 .
aShip:=((aGameBoard shipWith: 1)).

aGame throwNextShip.

self assert: (((aShip actualPosition) currentParsec )nominalValue)  equals: 3  .
self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 4  .

aGame throwNextShip.

self assert: ((aShip actualPosition currentParsec)nominalValue)  equals: 2  .
self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 4  .





  
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
aGameBoard cellsDividedIn: 4.
aGameBoard shipsCanThrowUsing: arrayOfDie .

aGame throwNextShip. "P1: 4 LAP1 P2: 0 LAP1"
aGame throwNextShip. "P1: 4 LAP1 P2: 3 LAP1"
aGame throwNextShip. "P1: 3 LAP2 P2: 3 LAP1  --> Ship 1 has won"

self assert: aGame winner equals: 1. 
self should:  [aGame throwNextShip] raise: Error withMessage: 'There is a winner and the game has finished, unless you have a card that prevents it, you cant throw'.





  
]

{ #category : #tests }
GameTests >> test060GameboardRobustInstanceCreation [
|arrayOfDie1 arrayOfDie2|
self setUpGameWith: 1 andGameboardWith: 4 and: 1.
arrayOfDie1 := OrderedCollection new.
arrayOfDie2 := OrderedCollection new.
die1 := LoadedDie with: #(1 2) .
arrayOfDie2 add: die1 .

self should:  [aGameBoard shipsCanThrowUsing:  arrayOfDie1] raise: Error withMessage: 'The collection of dices cant be empty'.
self should:  [aGameBoard cellsDividedIn: -2] raise: Error withMessage: 'The amount of parsecs cant be negative or zero'.
self should:  [aGameBoard cellsDividedIn: 0] raise: Error withMessage: 'The amount of parsecs cant be negative or zero'.




  
]

{ #category : #tests }
GameTests >> test061MoveShipWithoutInitializingAmountOfParsecs [
| hyperJump amountOfParsecsToMove parsc1 light1 parsc2 light2 collection1 |
self setUpGameWith: 1 andGameboardWith: 10 and: 1.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 2 ).

parsc1 := Parsecs with: 4.
light1 := LightYears with: 9.
parsc2 := Parsecs with: 2.
light2 := LightYears with: 3.
amountOfParsecsToMove:= OrderedCollection new.
collection1:=OrderedCollection new.
collection1 add: parsc1 ;add: light1 ;add: parsc2 ;add: light2  .
amountOfParsecsToMove add: collection1 .
hyperJump := HyperJump with: amountOfParsecsToMove .
aGameBoard shipsCanThrowUsing: arrayOfDie .
aGameBoard add: hyperJump  at: 3 .

aGame throwNextShip .

self assert: (((aGameBoard shipWith: 1) actualPosition currentParsec) nominalValue ) equals: 1  .
self assert: ((aGameBoard shipWith: 1) actualPosition currentCell ) equals: 6  .




  
]

{ #category : #tests }
GameTests >> test062AccessShipWithNumberThatNotExistThenError [

self setUpGameWith: 1 andGameboardWith: 10 and: 1.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 2 ).

self should:  [aGameBoard shipWith: 3] raise: Error withMessage: 'There is no ship with that number'.




  
]

{ #category : #tests }
GameTests >> test063StartToPlayWithoutDiceThenError [

self setUpGameWith: 1 andGameboardWith: 10 and: 1.

self should:  [aGame throwNextShip] raise: Error withMessage: 'There is no die to throw'.




  
]

{ #category : #tests }
GameTests >> test064ShipWithNegativeOrZeroNumberThenError [

self should:  [Ship with: 0] raise: Error withMessage: 'Ship number cant be negative or zero'.
self should:  [Ship with: -1] raise: Error withMessage: 'Ship number cant be negative or zero'.




  
]

{ #category : #tests }
GameTests >> test065ShipPositionWithNegativeValuesThenError [

self should:  [ShipPosition createWith: -1 at: 1 and: (Parsecs with: 1)] raise: Error withMessage: 'No value can be negative'.
self should:  [ShipPosition createWith: 1 at: -1 and: (Parsecs with: 1)] raise: Error withMessage: 'No value can be negative'.
self should:  [ShipPosition createWith: 1 at: 1 and: (Parsecs with: -1)] raise: Error withMessage: 'No value can be negative'.




  
]

{ #category : #tests }
GameTests >> test066SpaceSheriffDoesntReceiveDieCollectionThenError [

self should:  [SpaceSheriff with: 2] raise: Error withMessage: 'Didnt receive a die'.



  
]
