Class {
	#name : #CardsTests,
	#superclass : #TestCase,
	#instVars : [
		'numbers',
		'anotherNumbers',
		'dice1',
		'dice2',
		'arrayOfDices',
		'aGame',
		'cells',
		'numberOfLaps',
		'amountOfPlayers',
		'aGameBoard',
		'die1',
		'die2',
		'arrayOfDie',
		'aCollectionOfCards',
		'loadedDeck'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
CardsTests >> setUpGameWith:  anAmountOfPlayers andGameboardWith: anAmountOfCells and: laps [
	cells:= anAmountOfCells .
	numberOfLaps:= laps.
	amountOfPlayers := anAmountOfPlayers .
	aGameBoard := GameBoard with: cells and: numberOfLaps.
	aGameBoard cellsDividedIn: 1.
	aGame:= ShipsGame with: amountOfPlayers and: aGameBoard.
	aGame useCardsFrom: Deck new.
]

{ #category : #running }
CardsTests >> setUpLoadedDeck [
	aCollectionOfCards := OrderedCollection new.
	loadedDeck := LoadedDeck with: aCollectionOfCards.
	aGame useCardsFrom: loadedDeck.
]

{ #category : #running }
CardsTests >> setUpLoadedDiceWith: array1 and: array2 [
	
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
CardsTests >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [
	self
		should: anErrorBlock 
		raise: anExceptionClass 
		withExceptionDo: [ :error |
			self assert: error messageText equals: anErrorMessage 
			 ].
]

{ #category : #tests }
CardsTests >> test006ShipHasTwoOverloadCardsAsigned [
	| overload1  overload2 player |
	self setUpGameWith: 1 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	
	overload1 := Overload with: aGame .
	overload2 := Overload with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: overload1 ; add: overload2.
	player:= 1.
	aGame giveCardTo: player.
	aGame giveCardTo: player.

	self assert: (((((aGameBoard shipWith: 1)shipCards ) cardsInHand ) at: 1) isKindOf: Overload).
	self assert: (((((aGameBoard shipWith: 1)shipCards ) cardsInHand ) at: 2) isKindOf: Overload).
	
	
]

{ #category : #tests }
CardsTests >> test007ShipAppliesOverloadThenPositionIsLower [
	| overload1 overload2  player player2 |
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	overload1 := Overload with: aGame  .
	overload2 := Overload with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: overload1 ; add: overload2.
	player:=1.
	player2:=2.
	
	aGame giveCardTo: player.
	aGame giveCardTo: player2.

	overload1 from: player applyTo: player2. 	
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 6 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test008ShipAppliesSpeedThenPositionIsHigher [
	| speed1 speed2  player player2 |
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	speed1 := Speed with: aGame.
	speed2 := Speed with: aGame.
	self setUpLoadedDeck.
	aCollectionOfCards add: speed1 ; add: speed2.
	player:= 1.
	player2:=2.
	aGame giveCardTo: player.
	aGame giveCardTo: player2.

	aGame throwNextShip .
	aGame throwNextShip .	
	speed1 from: player applyTo: player.
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 1 )actualPosition currentCell) equals: 7 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test009ShipAppliesAccelerationThenAllPositionsAreHigher [
	| acceleration1 acceleration2 player player2 |
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	acceleration1  := Acceleration with: aGame .
	acceleration2  := Acceleration with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: acceleration1  ; add: acceleration2.
	player:= 1.
	player2:=2.
	aGame giveCardTo: player.
	aGame giveCardTo: player2.
		
	aGame throwNextShip .
	aGame throwNextShip .
	acceleration1 applyToAllFrom: player.
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 7 .
	self assert: ((aGameBoard shipWith: 1) actualPosition currentLap) equals: 1 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 3 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentLap) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test010PlayWithCancelletionCardForOverload [
	| overload  player player2  cancellation|
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	cancellation:= Cancellation with: aGame .
	overload := Overload with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: cancellation ; add: overload .
	player:= 1.
	player2:=2.
	aGame giveCardTo: player2.
	aGame giveCardTo: player.

	overload  from: player  applyTo: player2 .
	cancellation from: player2 applyTo: player2 cancelling: overload .
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test011PlayWithCancelletionCardForSpeed [
	|player player2  cancellation speed|
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	cancellation:= Cancellation with: aGame.
	speed := Speed with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: cancellation ; add: speed.
	player:= 1.
	player2:=2.
	aGame giveCardTo: player2.
	aGame giveCardTo: player.
	
	speed from: player applyTo: player . 
	aGame throwNextShip .
	aGame throwNextShip .
	cancellation from: player2  applyTo: player  cancelling: speed .	
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 7 .
]

{ #category : #tests }
CardsTests >> test012PlayWithCancelletionCardForAcceleration [
	| player player2  cancellation acceleration|

	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	cancellation:= Cancellation with: aGame .
	acceleration := Acceleration  with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: cancellation ; add: acceleration.
	player:= 1.
	player2:=2.
	aGame giveCardTo: player2.
	aGame giveCardTo: player.

	acceleration applyToAllFrom: player . 
	aGame throwNextShip .
	aGame throwNextShip .
	cancellation from: player2 cancelling: acceleration .
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 7 .
]

{ #category : #tests }
CardsTests >> test013PlayWithRepeatCardAndEffectSpeedUpToHimself [
	|player player2   repeat speedUp|

	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	speedUp := SpeedUp new.
	repeat  := Repeat with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: repeat.
	aGameBoard add: speedUp at: 3.
	player:= 1.
	player2:=2.
	aGame giveCardTo: player.

	aGame throwNextShip .
	repeat from: player to: player . 
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 3 .
]

{ #category : #tests }
CardsTests >> test014PlayWithRepeatCardEffectWormHole [
	|player player2  repeat wormHole|
	
	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1 1) and: #(1 6 3 1).
	wormHole := WormHole  new.
	repeat  := Repeat with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: repeat.
	aGameBoard add: wormHole at: 6.
	player:= 1.
	player2:=2.
	aGame giveCardTo: player.
	
	aGame throwNextShip . "Cae en 2"
	aGame throwNextShip . "Cae en 7"
	aGame throwNextShip . "Cae en Wormhole"
	repeat from: player  to: player2  . 
		
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 3 .
]

{ #category : #tests }
CardsTests >> test015PlayWithRepeatCardEffectMoonWalk [
	|player player2 repeat moonWalk|
	
	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	moonWalk := MoonWalk with: -3.
	repeat  := Repeat with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: repeat.
	aGameBoard add: moonWalk at: 6.
	player:= 1.
	player2:=2.
	aGame giveCardTo: player.
	
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	repeat from: player to: player2 . 
	
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 2 .
]

{ #category : #tests }
CardsTests >> test016PlayWithRepeatCardEffectAtomicBomb [
	| player player2  repeat anAtomicBomb|
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	anAtomicBomb := AtomicBomb new.
	repeat  := Repeat with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: repeat.
	aGameBoard add: anAtomicBomb at: 5 .
	player:= 1.
	player2:=2.
	aGame giveCardTo: player.	
	
	aGame throwNextShip .
	aGame throwNextShip .
	repeat from: player. 
	
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 0 .
]

{ #category : #tests }
CardsTests >> test017PlayWithRepeatCardEffectHyperJump [
	| player player2  repeat amountOfParsecsToMove hyperJump parsc1 light1 parsc2 light2 collection1 |
	
	parsc1 := Parsecs with: 7.
	light1 := LightYears with: 9.
	parsc2 := Parsecs with: 2.
	light2 := LightYears with: 3.
	amountOfParsecsToMove:= OrderedCollection new.
	collection1:= OrderedCollection new.
	collection1 add: parsc1; add: light1; add: parsc2; add: light2  .
	amountOfParsecsToMove add: collection1 .
	hyperJump := HyperJump with: amountOfParsecsToMove .
	arrayOfDie := OrderedCollection new.
	arrayOfDie add: (LoadedDie with: #(1 1)); add: (LoadedDie with: #(2 4)).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	aGameBoard cellsDividedIn: 4. 
	aGameBoard shipsCanThrowUsing: arrayOfDie .
	repeat  := Repeat with: aGame.
	self setUpLoadedDeck.
	aCollectionOfCards add: repeat.
	aGameBoard add: hyperJump at: 3 .
	player:= 1.
	player2:=2.
	aGame giveCardTo: player.
	
	aGame throwNextShip .
	repeat  from: player  to: player .
			
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 5 .
	self assert: ((aGameBoard shipWith: 1) actualPosition currentLap) equals: 1 .
]

{ #category : #tests }
CardsTests >> test018PlayWithRedoCardAndOverloadCard [
	| overload redo player player2 |
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	overload := Overload  with: aGame .
	redo:= Redo with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: overload ; add: redo.
	player:=1.
	player2:=2.
	aGame giveCardTo: player.
	aGame giveCardTo: player2.
	
	overload from: player applyTo: player2 . 
	aGame throwNextShip . 
	redo  from: player2 to: player .
	aGame throwNextShip . 
	aGame throwNextShip . 
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 4 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 6 .
		
	
	
	
]

{ #category : #tests }
CardsTests >> test019PlayWithRedoCardAndAccelerationCard [
	| acceleration redo player player2 |
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	acceleration := Acceleration with: aGame .
	redo:= Redo with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: acceleration ; add: redo.
	player:=1.
	player2:=2.
	aGame giveCardTo: player.
	aGame giveCardTo: player2.
	
	acceleration applyToAllFrom:  player . 
	aGame throwNextShip . 
	redo from: player2 . 
	aGame throwNextShip . 
	aGame throwNextShip . 
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 1 .
	self assert: ((aGameBoard shipWith: 1) actualPosition currentLap) equals: 2 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 6 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentLap) equals: 2 .
		
	
	
	
]

{ #category : #tests }
CardsTests >> test020PlayWithRedoCardAndSpeedCard [
	| speed redo player player2 |
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	speed := Speed with: aGame .
	redo:= Redo with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: speed ; add: redo.
	player:=1.
	player2:=2.
	aGame giveCardTo: player.
	aGame giveCardTo: player2.

	speed from: player applyTo: player . 
	aGame throwNextShip . 
	redo from: player2 to: player2 . 
	aGame throwNextShip . 
	aGame throwNextShip . 
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 8 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 4 .
		
	
	
	
]

{ #category : #tests }
CardsTests >> test021PlayWithRedoCardAndCancellationCard [
	| speed1 speed2 cancellation redo player player2 |
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	speed1 := Speed with: aGame .
	speed2 := Speed with: aGame .
	cancellation := Cancellation with: aGame .
	redo:= Redo with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: speed1 ; add: speed2 ; add: cancellation ; add: redo  .
	player:=1.
	player2:=2.
	aGame giveCardTo: player.
	aGame giveCardTo: player2.
	aGame giveCardTo: player.
	aGame giveCardTo: player2.
	
	speed1 from: player applyTo: player. 
	aGame throwNextShip . "1-P4 2-P0"
	speed2 from: player2  applyTo: player2. 
	aGame throwNextShip . "1-P4 2-P6"
	cancellation  from: player applyTo: player2  cancelling: speed2 . 
	redo cancellationFrom: player2 to: player canceled: speed1.
	aGame throwNextShip . "1-P7 2-P6"
	aGame throwNextShip . "1-P7L1 2-P3L2"
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 7 .
	self assert: ((aGameBoard shipWith: 1) actualPosition currentLap) equals: 1 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 3 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentLap) equals: 2 .
		
	
	
	
]

{ #category : #tests }
CardsTests >> test022PlayWithRedoCardAndAnotherRedoCardWithPermanentLastCardWhenItsTheirTurn [
	| speed redo1 redo2 player player2 |
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	speed := Speed with: aGame .
	redo1:= Redo with: aGame .
	redo2:= Redo with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: speed ; add: redo1 ; add: redo2  .
	player:=1.
	player2:=2.
	aGame giveCardTo: player.
	aGame giveCardTo: player2.
	aGame giveCardTo: player2.

	speed  from: player applyTo: player .
	aGame throwNextShip . 
	redo1 from: player2  to: player2 .
	redo2 from: player2  to: player2 .
	aGame throwNextShip . 
	aGame throwNextShip . 
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 8 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 6 .
		
	
	
	
]

{ #category : #tests }
CardsTests >> test023PlayWithRedoCardAndAnotherRedoCardWithPermanentLastCardWhenItsNOTTheirTurn [
	| speed redo player player2 |

	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	speed := Speed with: aGame .
	redo:= Redo with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: speed; add: redo  .
	player:=1.
	player2:=2.
	aGame giveCardTo: player.
	aGame giveCardTo: player2.
	
	speed  from: player  applyTo: player .
	
	self should:  [redo from: player2] raise: Error withMessage: 'Cannot use permanent card when its not their turn'.
		
	
	
	
]

{ #category : #tests }
CardsTests >> test024Ship1WinsButShip2UsesRepeatWormHoleThenShip2ThrowAndWin [
	|ship ship2  repeat wormHole|
	self setUpGameWith: 2 andGameboardWith: 10 and: 1.
	self setUpLoadedDiceWith: #(1 1 ) and: #(6 5 ).
	wormHole := WormHole  new.
	repeat  := Repeat with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: repeat.
	aGameBoard add: wormHole at: 4.
	ship:= 1.
	ship2:=2.
	aGame giveCardTo: ship2.
	
	aGame throwNextShip . "P1 7 LAP1 P2 0 LAP1 "
	aGame throwNextShip . "P1 3 LAP1 P2 1 LAP1 "
	aGame throwNextShip . "P1 4 LAP2 P2 1 LAP1 --> P1 0 LAP2 P2 1 LAP1"
	
	self assert: aGame winner equals: 1. "Ship 1 has won"
	
	repeat from: ship2 to: ship. "P1 6 LAP1 P2 6 LAP1 "
	aGame throwNextShip . "P1 6 LAP1 P2 2 LAP2 "
	
	self assert: aGame winner equals: 2. "Ship 2 has finally won"
]

{ #category : #tests }
CardsTests >> test026PlayWithRedoaRepeatCardWithEffectWormHole [
	|player player2  repeat wormHole redo|
	
	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(2 1) and: #(2 4).
	wormHole := WormHole  new.
	repeat  := Repeat with: aGame .
	redo:= Redo with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: repeat ; add: redo  .
	aGameBoard add: wormHole at: 8.
	player:= 1.
	player2:=2.
	aGame giveCardTo: player.
	aGame giveCardTo: player2. 
	
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	repeat from: player  to: player  . 
	redo from: player2  to: player2 .
	
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 1 .
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 0 .
]

{ #category : #tests }
CardsTests >> test027PlayWithCancelletionCardForARedoOnAnOverload [
	| redo overload  player player2  cancellation |
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	cancellation:= Cancellation with: aGame .
	overload := Overload with: aGame .
	redo:= Redo with: aGame.
	self setUpLoadedDeck.
	aCollectionOfCards add: cancellation ; add: overload ; add: redo  .
	player:= 1.
	player2:=2.
	aGame giveCardTo: player.
	aGame giveCardTo: player.
	aGame giveCardTo: player2.

	overload  from: player  applyTo: player2 .
	aGame throwNextShip .
	redo from: player2 to: player .
	cancellation from: player applyTo: player cancelling: overload  .
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell)	 equals: 6 .
	self assert: ((aGameBoard shipWith: 2)actualPosition currentCell)	 equals: 6 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test028PlayWithCancellationCardForRedoCardOnASpeedCard [
	| speed redo player player2 cancellation  |
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	speed := Speed with: aGame .
	redo:= Redo with: aGame .
	cancellation := Cancellation with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: speed ; add: redo ; add: cancellation  .
	player:=1.
	player2:=2.
	aGame giveCardTo: player.
	aGame giveCardTo: player2.
	aGame giveCardTo: player.

	speed from: player applyTo: player . 
	aGame throwNextShip . 
	redo from: player2 to: player2 . 
	cancellation from: player applyTo: player2 cancelling: speed. 
	aGame throwNextShip . 
	aGame throwNextShip . 
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 8 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 2 .
		
	
	
	
]

{ #category : #tests }
CardsTests >> test029PlayWithCancellationCardForRedoOnAnAccelerationCard [

	| player player2  cancellation acceleration redo  |

	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	cancellation:= Cancellation with: aGame .
	acceleration := Acceleration  with: aGame .
	redo := Redo with: aGame.	
	self setUpLoadedDeck.
	aCollectionOfCards add: cancellation ; add: acceleration  ; add: redo  .
	player:= 1.
	player2:= 2.
	aGame giveCardTo: player.
	aGame giveCardTo: player.
	aGame giveCardTo: player2 .

	acceleration applyToAllFrom: player . 
	aGame throwNextShip .
	redo from: player2.
	aGame throwNextShip .
	cancellation from: player cancelling: acceleration .
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 8 .
]

{ #category : #tests }
CardsTests >> test030PlayWithCancelletionCardErrorIfTheCardIsNotInEffect [

	| redo overload player player2 cancellation  |
	
	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	cancellation := Cancellation with: aGame.
	overload := Overload with: aGame.
	redo := Redo with: aGame.
	self setUpLoadedDeck.
	aCollectionOfCards add: cancellation ; add: overload ; add: redo  .
	player := 1.
	player2 := 2.
	aGame giveCardTo: player.
	aGame giveCardTo: player.
	aGame giveCardTo: player2.

	overload from: player applyTo: player2.
	aGame throwNextShip.
	redo from: player2 to: player.
	
	self
		should: [ 
		cancellation from: player applyTo: player cancelling: redo ]
		raise: Error
		withMessage:
		'The card you want to cancel is not affecting the ship'
]

{ #category : #tests }
CardsTests >> test031ThrowErrorWhenTheSelectedCardIsNotInShipHand [
	| speed redo player player2 cancellation |
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	speed := Speed with: aGame .
	redo:= Redo with: aGame .
	cancellation := Cancellation with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: speed ; add: redo ; add: cancellation .
	player:=1.
	player2:=2.
	aGame giveCardTo: player.
	aGame giveCardTo: player2.

	speed from: player applyTo: player . 
	aGame throwNextShip . 
	redo from: player2 to: player2 . 
	
	self
		should: [ 
		cancellation from: player applyTo: player2 cancelling: speed ]
		raise: Error
		withMessage:
		'The card you want to use is not in your ships hand'
		
	
	
	
]

{ #category : #tests }
CardsTests >> test032ShipFallsInJailBecauseAnOverloadAndCantGetOut [
	| overload1 aJail  player player2  |
	
	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1 1 1) and: #(1 1 3 1 1).
	overload1 := Overload with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: overload1  .
	aJail := Jail new.
	player:=1.
	player2:=2.
	aGame giveCardTo: player2.
	aGameBoard add: aJail at: 4.

	aGame throwNextShip .
	overload1 from: player2 applyTo: player.
	aGame throwNextShip .
	aGame throwNextShip . "Cae en Jail"
	aGame throwNextShip .
	aGame throwNextShip . "No logra salir"
	aGame throwNextShip .
	aGame throwNextShip . "Tira una vez mas"
	
	self assert: ((aGameBoard shipWith: 1)actualPosition currentCell) equals: 4 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test033ShipFallsInJailBecauseAnOverloadAndCanGetOut [
	| overload1 aJail  player player2  |

	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1 1 4) and: #(1 1 1 1 4).
	overload1 := Overload with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: overload1   .
	aJail := Jail new .
	player:=1.
	player2:=2.
	aGame giveCardTo: player2.
	aGameBoard add: aJail at: 4.

	aGame throwNextShip .
	overload1 from: player2 applyTo: player.
	aGame throwNextShip .
	aGame throwNextShip . "Cae en Jail"
	aGame throwNextShip .
	aGame throwNextShip . "Logra salir"
	aGame throwNextShip .
	aGame throwNextShip . "Tira una vez mas"
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 8 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test034ShipFallsInJailBecauseASpeedUpAndCanGetOut [
	| speed aJail  player player2  |

	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1 1 4) and: #(1 1 1 1 4).
	speed := Speed with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: speed  .
	aJail := Jail new .
	player:=1.
	player2:=2.
	aGame giveCardTo: player2.
	aGameBoard add: aJail at: 5.

	aGame throwNextShip .
	speed from: player2 applyTo: player.
	aGame throwNextShip .
	aGame throwNextShip . "Cae en Jail"
	aGame throwNextShip .
	aGame throwNextShip . "Logra salir"
	aGame throwNextShip .
	aGame throwNextShip . "Tira una vez mas"
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 8 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test035ShipFallsInJailBecauseASpeedUpAndCantGetOut [
	| speed aJail  player player2 |

	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1 5 4) and: #(1 1 1 4 4).
	speed := Speed with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: speed   .
	aJail := Jail new .
	player:=1.
	player2:=2.
	aGame giveCardTo: player2.
	aGameBoard add: aJail at: 5.

	aGame throwNextShip .
	speed from: player2 applyTo: player.
	aGame throwNextShip .
	aGame throwNextShip . "Cae en Jail"
	aGame throwNextShip .
	aGame throwNextShip . "No logra salir"
	aGame throwNextShip .
	aGame throwNextShip . "Tira una vez mas"
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 5 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test036ShipFallsInJailBecauseAnAccelerationCanGetOut [
	| acceleration aJail  player player2  |

	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1 1 4) and: #(1 1 1 1 4).
	acceleration := Acceleration with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: acceleration .
	aJail := Jail new .
	player:=1.
	player2:=2.
	aGame giveCardTo: player2.
	aGameBoard add: aJail at: 5.

	aGame throwNextShip .
	acceleration applyToAllFrom:  player2.
	aGame throwNextShip .
	aGame throwNextShip . "Cae en Jail"
	aGame throwNextShip .
	aGame throwNextShip . "Logra salir"
	aGame throwNextShip .
	aGame throwNextShip . "Tira una vez mas"
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 8 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test037ShipFallsInJailBecauseAnAccelerationAndCantGetOut [
	| acceleration aJail  player player2  |

	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1 5 4) and: #(1 1 1 5 4).
	acceleration := Acceleration with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: acceleration .
	aJail := Jail new .
	player:=1.
	player2:=2.
	aGame giveCardTo: player2.
	aGameBoard add: aJail at: 5.

	aGame throwNextShip .
	acceleration applyToAllFrom:  player2.
	aGame throwNextShip .
	aGame throwNextShip . "Cae en Jail"
	aGame throwNextShip .
	aGame throwNextShip . "No logra salir"
	aGame throwNextShip .
	aGame throwNextShip . "Tira una vez mas"
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 5 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test038ShipFallsInJailAndSendsOtherShipToJailWithRepeat [
	| aJail  player player2 repeat  |
	
	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1) and: #(1 1).
	repeat := Repeat with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: repeat  .
	aJail := Jail new .
	player:=1.
	player2:=2.
	aGame giveCardTo: player.
	aGameBoard add: aJail at: 4.

	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip . "Cae en Jail"
	repeat from: player to: player2 . "Manda a Jail al player2"
	aGame throwNextShip . "No logra salir"
	aGame throwNextShip . "No logra salir"
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 4 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 4 .

	
	
	
	
]

{ #category : #tests }
CardsTests >> test039ShipUsesRedoOnARepeatThenSendsAnotherShipToJail [
	| aJail  player player2 player3 player4 repeat redo  |

	self setUpGameWith: 4 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 2 1) and: #(1 1 1 1).
	repeat := Repeat with: aGame  .
	redo := Redo with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: repeat ; add: redo  .
	aJail := Jail new .
	player :=1.
	player2 :=2.
	player3 := 3.
	player4 := 4.
	aGame giveCardTo: player.
	aGame giveCardTo: player3.
	aGameBoard add: aJail at: 4.

	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip . "1 Cae en Jail"
	repeat from: player to: player2 . "Manda a Jail al player2"
	redo from: player3 to: player4 . "Manda a Jail al player4"
	aGame throwNextShip . "2 No logra salir"
	aGame throwNextShip . "3 Se mueve"
	aGame throwNextShip . "4 No logra salir"
	aGame throwNextShip . "1 No logra salir"
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 4 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 4 .
	self assert: ((aGameBoard shipWith: 3) actualPosition currentCell) equals: 6 .
	self assert: ((aGameBoard shipWith: 4) actualPosition currentCell) equals: 4 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test041ShipUsesFreedomThenGetsOutOfJail [
	| aFreedom aJail  player |

	self setUpGameWith: 1 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	aFreedom := Freedom with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: aFreedom  .
	aJail := Jail new .
	player:= 1.
	aGame giveCardTo: player.
	aGameBoard add: aJail at: 4.

	aGame throwNextShip .
	aGame throwNextShip . "Cae en Jail"
	aFreedom from: player applyTo: player. "Se libera"
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 6 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test042ShipUsesFreedomOnAPlayerNotInJailThenError [
	| aFreedom aJail  player player2 |

	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	aFreedom := Freedom with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: aFreedom  .
	aJail := Jail new .
	player:= 1.
	player2:= 2.
	aGame giveCardTo: player.
	aGameBoard add: aJail at: 4.

	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip . "Cae en Jail"
	
	self
		should: [ 
		aFreedom from: player applyTo: player2 ]
		raise: Error
		withMessage:
		'The ship you want to free is not in Jail'
	
	
	
	
]

{ #category : #tests }
CardsTests >> test043ShipUsesFreedomAndAnotherShipRedoToBeFree [
	| aJail  player player2 redo aFreedom |

	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	redo := Redo with: aGame  .
	aFreedom := Freedom with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: redo ; add: aFreedom   .
	aJail := Jail new .
	player:=1.
	player2:=2.
	aGame giveCardTo:  player2.
	aGame giveCardTo:  player.
	aGameBoard add: aJail at: 4.

	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip . "1 Cae en Jail"
	aGame throwNextShip . "2 Cae en Jail"
	aFreedom from: player applyTo: player . 
	redo from: player2 to: player2 . 
	aGame throwNextShip . 
	aGame throwNextShip . 
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 6 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 6 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test044ShipUsesRedoOfARedoOfAFreedomThenIsFree [
	| aJail  player player2 player3 redo redo2 aFreedom|

	self setUpGameWith: 3 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	aFreedom := Freedom with: aGame .
	redo := Redo with: aGame  .
	redo2 := Redo with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: aFreedom; add: redo ; add: redo2  .
	aJail := Jail new .
	player:= 1.
	player2:= 2.
	player3:= 3.
	aGame giveCardTo:  player.
	aGame giveCardTo:  player2.
	aGame giveCardTo:  player3.
	aGameBoard add: aJail at: 4.

	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip . "1 Cae en Jail"
	aGame throwNextShip . "2 Cae en Jail"
	aGame throwNextShip . "3 Cae en Jail"
	aFreedom from: player applyTo: player . 
	redo from: player2 to: player2 . 
	redo2 from: player3 to: player3 . 
	aGame throwNextShip . 
	aGame throwNextShip . 
	aGame throwNextShip . 
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 6 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 6 .
	self assert: ((aGameBoard shipWith: 3) actualPosition currentCell) equals: 6 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test045OverloadRobustInstanceCreation [
	| overload |
	
	self
		should: [ 
		overload := Overload with: 2 . ]
		raise: Error
		withMessage:
		'The card must receive a ShipsGame instance'
	
	
]

{ #category : #tests }
CardsTests >> test046SpeedRobustInstanceCreation [
	| speed |
	
	self
		should: [ 
		speed := Speed with: 2 . ]
		raise: Error
		withMessage:
		'The card must receive a ShipsGame instance'
	
]

{ #category : #tests }
CardsTests >> test047AccelerationRobustInstanceCreation [
	| acceleration |
	
	self
		should: [ 
		acceleration := Acceleration with: 2 . ]
		raise: Error
		withMessage:
		'The card must receive a ShipsGame instance'
	
	
]

{ #category : #tests }
CardsTests >> test048CancellationRobustInstanceCreation [
	| cancellation |
	
	self
		should: [ 
		cancellation := Cancellation with: 2 . ]
		raise: Error
		withMessage:
		'The card must receive a ShipsGame instance'
	
	
]

{ #category : #tests }
CardsTests >> test049RedoRobustInstanceCreation [
	| redo |
	
	self
		should: [ 
		redo := Redo with: 2 . ]
		raise: Error
		withMessage:
		'The card must receive a ShipsGame instance'
	
	
]

{ #category : #tests }
CardsTests >> test050RepeatRobustInstanceCreation [
	| repeat |
	
	self
		should: [ 
		repeat := Repeat with: 2 . ]
		raise: Error
		withMessage:
		'The card must receive a ShipsGame instance'
	
	
]

{ #category : #tests }
CardsTests >> test051FreedomRobustInstanceCreation [
	| freedom |
	
	self
		should: [ 
		freedom := Freedom with: 2 . ]
		raise: Error
		withMessage:
		'The card must receive a ShipsGame instance'
	
	
]

{ #category : #tests }
CardsTests >> test053ReverseCardIsUsedThenTurnsAreReversed [
	| reverse ship1 |
	
	self setUpGameWith: 3 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	reverse := Reverse with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: reverse .
	ship1:= 1.
	aGame giveCardTo:  ship1.
	
	aGame throwNextShip .
	aGame throwNextShip .
	reverse applyFrom: ship1.
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 2 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 4 .
	self assert: ((aGameBoard shipWith: 3) actualPosition currentCell) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test054ReverseCardWithTurnsDoingACompleteRoundReversed [
	| reverse ship1 |
	
	self setUpGameWith: 3 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	reverse := Reverse with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: reverse .
	ship1:= 1.
	aGame giveCardTo:  ship1.
	
	aGame throwNextShip .
	aGame throwNextShip .
	reverse applyFrom: ship1.
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 4 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 4 .
	self assert: ((aGameBoard shipWith: 3) actualPosition currentCell) equals: 4 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test055ReverseCardAppliedBeforeFirstThrow [
	| reverse ship1 |
	
	self setUpGameWith: 3 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	reverse := Reverse with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: reverse .
	ship1:= 1.
	aGame giveCardTo:  ship1.
	
	reverse applyFrom: ship1.
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 2 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 0 .
	self assert: ((aGameBoard shipWith: 3) actualPosition currentCell) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test056TwoReverseCardsAppliedNothingChanges [
	| reverse  reverse2 ship1 ship2 |
	
	self setUpGameWith: 3 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	reverse := Reverse with: aGame.
	reverse2 := Reverse with: aGame.
	self setUpLoadedDeck.
	aCollectionOfCards add: reverse ; add: reverse2  .
	ship1:= 1.
	ship2:= 2.
	aGame giveCardTo: ship1.
	aGame giveCardTo: ship2.
	
	aGame throwNextShip.
	reverse applyFrom: ship1.
	reverse2 applyFrom: ship2.
	aGame throwNextShip.
	aGame throwNextShip.
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 2 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 2 .
	self assert: ((aGameBoard shipWith: 3) actualPosition currentCell) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test057RedoAReverseCardThenNothingChanges [
	| reverse  redo ship1 ship2 |
	
	self setUpGameWith: 3 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	reverse := Reverse with: aGame.
	redo := Redo with: aGame.
	self setUpLoadedDeck.
	aCollectionOfCards add: reverse ; add: redo  .
	ship1:= 1.
	ship2:= 2.
	aGame giveCardTo:  ship1.
	aGame giveCardTo:  ship2.
	
	aGame throwNextShip.
	reverse applyFrom: ship1.
	redo from: ship2.
	aGame throwNextShip.
	aGame throwNextShip.
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 2 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 2 .
	self assert: ((aGameBoard shipWith: 3) actualPosition currentCell) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test058ReverseRobustInstanceCreation [
	| reverse|
	
	self
		should: [ 
		reverse := Reverse with: 2 . ]
		raise: Error
		withMessage:
		'The card must receive a ShipsGame instance'
	
	
]

{ #category : #tests }
CardsTests >> test061SkipCardIsUsedThenShipWithTurnLosesIt [
	| skip ship1 |
	
	self setUpGameWith: 3 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	skip := Skip with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: skip .
	ship1:= 1.
	aGame giveCardTo: ship1.
	
	aGame throwNextShip .
	skip applyFrom: ship1.
	aGame throwNextShip .
	aGame throwNextShip.
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 4 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 0 .
	self assert: ((aGameBoard shipWith: 3) actualPosition currentCell) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test062ShipSkipsAllTurnsThenThrowsAgain [
	| skip skip2 ship1 |
	
	self setUpGameWith: 3 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	skip := Skip with: aGame  .
	skip2 := Skip with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: skip; add: skip2 .
	ship1:= 1.
	aGame giveCardTo: ship1.
	aGame giveCardTo: ship1.
	
	aGame throwNextShip .
	skip applyFrom: ship1.
	skip2 applyFrom: ship1.
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 4 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 0 .
	self assert: ((aGameBoard shipWith: 3) actualPosition currentCell) equals: 0 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test063SkipTurnBeforeFirstThrowThenSecondShipPlays [
	| skip  ship2 |
	
	self setUpGameWith: 3 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	skip := Skip with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: skip.
	ship2:= 2.
	aGame giveCardTo: ship2.
	
	skip applyFrom: ship2.
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 0 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 2 .
	self assert: ((aGameBoard shipWith: 3) actualPosition currentCell) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test064RedoASkipCardThenLastShipThrowsFirst [
	| skip  redo ship2 ship3 |
	self setUpGameWith: 3 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	skip := Skip with: aGame.
	redo := Redo with: aGame.
	self setUpLoadedDeck.
	aCollectionOfCards add: skip ; add: redo.
	ship2:= 2.
	ship3:= 3.
	aGame giveCardTo: ship2.
	aGame giveCardTo: ship3 .
	
	skip applyFrom: ship2.
	redo from: ship3.
	aGame throwNextShip.
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 0 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 0 .
	self assert: ((aGameBoard shipWith: 3) actualPosition currentCell) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test065SkipRobustInstanceCreation [
	| skip |

	self
		should: [ 
		skip := Skip with: 2 . ]
		raise: Error
		withMessage:
		'The card must receive a ShipsGame instance'
	
	
]

{ #category : #tests }
CardsTests >> test067DoubleCardIsUsedThenShipThrowsTwoTimes [
	| double ship1|
	
	self setUpGameWith: 3 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	double := Double with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: double .
	ship1:= 1.
	aGame giveCardTo: ship1.
	
	double applyFrom: ship1.
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip.
	aGame throwNextShip.
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 4 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 2 .
	self assert: ((aGameBoard shipWith: 3) actualPosition currentCell) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test068TwoDoubleCardAreUsedThenShipThrowsTwoTimes [
	| double double1 ship1 |
	
	self setUpGameWith: 3 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	double := Double with: aGame  .
	double1 := Double with: aGame  .
	self setUpLoadedDeck.
	aCollectionOfCards add: double ; add: double1 .
	ship1:= 1.
	aGame giveCardTo: ship1.
	aGame giveCardTo: ship1.
	
	double applyFrom: ship1.
	double1 applyFrom: ship1.
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip.
	aGame throwNextShip.
	aGame throwNextShip.
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 6 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 2 .
	self assert: ((aGameBoard shipWith: 3) actualPosition currentCell) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test069RedoADoubleCardThenShipThrowsTwoTimes [
	| double  redo ship1 |
	
	self setUpGameWith: 3 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	double := Double with: aGame.
	redo := Redo with: aGame.
	self setUpLoadedDeck.
	aCollectionOfCards add: double ; add: redo.
	ship1:= 1.
	aGame giveCardTo: ship1.
	aGame giveCardTo:  ship1.
	
	double applyFrom: ship1.
	redo from: ship1.
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip.
	aGame throwNextShip.
	aGame throwNextShip.
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 6 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 2 .
	self assert: ((aGameBoard shipWith: 3) actualPosition currentCell) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test070SkipAfterDoubleCardThenShipThrowsOneTime [
	| double  skip ship1 ship2 |
	
	self setUpGameWith: 3 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	self setUpLoadedDeck.
	
	double := Double with: aGame.
	skip := Skip with: aGame.
	aCollectionOfCards add: double ; add: skip.
	ship1:= 1.
	ship2:= 2.
	aGame giveCardTo: ship1.
	aGame giveCardTo: ship2.
	
	double applyFrom: ship1.
	skip applyFrom: ship2.
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip.
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 2 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 2 .
	self assert: ((aGameBoard shipWith: 3) actualPosition currentCell) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test071RedoASkipAfterDoubleCardThenFirstShipDoesntThrow [
	| double  skip ship1 ship2 redo  |
	
	self setUpGameWith: 3 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	self setUpLoadedDeck.
	double := Double with: aGame.
	skip := Skip with: aGame.
	redo := Redo with: aGame.
	aCollectionOfCards add: double ; add: skip ; add: redo.
	ship1:= 1.
	ship2:= 2.
	aGame giveCardTo: ship1.
	aGame giveCardTo: ship2.
	aGame giveCardTo: ship2.
	
	double applyFrom: ship1.
	skip applyFrom: ship2.
	redo from: ship2.
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 0 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 2 .
	self assert: ((aGameBoard shipWith: 3) actualPosition currentCell) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test072DoubleRobustInstanceCreation [
	| double |
	
	self
		should: [ 
		double := Double with: 2 . ]
		raise: Error
		withMessage:
		'The card must receive a ShipsGame instance'
	
	
]

{ #category : #tests }
CardsTests >> test073RepeatANullEffectHasNoEffect [
	| player player2  repeat aNullEffect|
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	aNullEffect := NullEffect new.
	repeat  := Repeat with: aGame .
	self setUpLoadedDeck.
	aCollectionOfCards add: repeat.
	aGameBoard add: aNullEffect at: 5 .
	player:= 1.
	player2:=2.
	aGame giveCardTo: player.	
	
	aGame throwNextShip .
	aGame throwNextShip .
	repeat from: player. 
	
	self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 3 .
	self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 5 .
]
