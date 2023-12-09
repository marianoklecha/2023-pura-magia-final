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
		'arrayOfDie'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
CardsTests >> setUpGameWith:  anAmountOfPlayers andGameboardWith: anAmountOfCells and: laps [
	cells:= anAmountOfCells .
	numberOfLaps:= laps.
	amountOfPlayers := anAmountOfPlayers .
	
	aGameBoard := GameBoard with: cells and: numberOfLaps.
	aGame:= ShipsGame with: amountOfPlayers and: aGameBoard.
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
	
	aGameBoard cellsWith: 0 and: arrayOfDie  .
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
CardsTests >> test001TypeCardOverloadExistsThenAssert [
	
	|cardOverload|
	cardOverload := Overload new.
	
	self assert: (cardOverload  isKindOf:  Overload ) .
]

{ #category : #tests }
CardsTests >> test002TypeCardASpeedExistsThenAssert [
	
	|cardSpeed|
	cardSpeed := Speed new.
	
	self assert: (cardSpeed  isKindOf:  Speed ) .
]

{ #category : #tests }
CardsTests >> test003TypeCardAccelerationExistsThenAssert [
	
	|cardAcceleration|
	cardAcceleration  := Acceleration new.
	
	self assert: (cardAcceleration   isKindOf:  Acceleration ) .
]

{ #category : #tests }
CardsTests >> test004TypeCardCancellationExistsThenAssert [
	
	|cardCancellation|
	cardCancellation := Acceleration new.
	
	self assert: (cardCancellation isKindOf:  Acceleration ) .
]

{ #category : #tests }
CardsTests >> test005TypeCardRepeatExistsThenAssert [
	
	|cardRepeat|
	cardRepeat  := Repeat new.
	
	self assert: (cardRepeat  isKindOf:  Repeat ) .
]

{ #category : #tests }
CardsTests >> test006PlayerStartTheGameThen2OverloadCardsAreAsigned [
	| overload1  overload2 player |
	self setUpGameWith: 1 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	
	overload1 := Overload with: aGame .
	overload2 := Overload with: aGame .	
	player:= 1.
	aGameBoard add: overload1 to: player.
	aGameBoard add: overload2 to: player.

	self assert: (((((aGameBoard shipWith: 1)shipCards ) cardsInHand ) at: 3) isKindOf: Overload).
	self assert: (((((aGameBoard shipWith: 1)shipCards ) cardsInHand ) at: 4) isKindOf: Overload).
	
	
]

{ #category : #tests }
CardsTests >> test007PlayerStartTheGameWith2OverloadCardsThenApplyEffect [
	| overload1 overload2  player player2 |
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	overload1 := Overload with: aGame  .
	overload2 := Overload with: aGame .
	player:=1.
	player2:=2.
	aGameBoard add: overload1 to: player.
	aGameBoard add: overload2 to: player2.

	overload1 from: player applyTo: player2. 	
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: (aGameBoard cellOfShip: 2) equals: 6 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test008PlayerStartTheGameWith2OSpeedCardsThenApplyEffectToThemSelf [
	| speed1 speed2  player player2 |
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	speed1 := Speed with: aGame.
	speed2 := Speed with: aGame.
	player:= 1.
	player2:=2.
	aGameBoard add: speed1 to: player.
	aGameBoard add: speed2 to: player2.

	aGame throwNextShip .
	aGame throwNextShip .	
	speed1 from: player applyTo: player.
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: (aGameBoard cellOfShip:  1) equals: 7 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test009PlayerStartTheGameWith2OAcelerationCardsThenApplyEffect [
	| acceleration1 acceleration2 player player2 |
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	acceleration1  := Acceleration with: aGame .
	acceleration2  := Acceleration with: aGame .
	player:= 1.
	player2:=2.
	aGameBoard add: acceleration1 to: player.
	aGameBoard add: acceleration2 to: player2.
		
	aGame throwNextShip .
	aGame throwNextShip .
	acceleration1 applyToAllFrom: player.
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: (aGameBoard cellOfShip: 1) equals: 7 .
	self assert: (aGameBoard lapOfShip: 1) equals: 1 .
	self assert: (aGameBoard cellOfShip: 2) equals: 3 .
	self assert: (aGameBoard lapOfShip: 2) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test010PlayWithCancelletionCardForOverload [
	| overload  player player2  cancellation|
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	cancellation:= Cancellation with: aGame .
	overload := Overload with: aGame .
	player:= 1.
	player2:=2.
	aGameBoard add: overload to: player.
	aGameBoard add: cancellation to: player2.

	overload  from: player  applyTo: player2 .
	cancellation from: player2 applyTo: player2 canceled: overload .
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: (aGameBoard cellOfShip: 2) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test011PlayWithCancelletionCardForSpeed [
	|player player2  cancellation speed|
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	cancellation:= Cancellation with: aGame.
	speed := Speed with: aGame .
	player:= 1.
	player2:=2.
	aGameBoard add: speed  to: player.
	aGameBoard add: cancellation to: player2.
	
	speed from: player applyTo: player . 
	aGame throwNextShip .
	aGame throwNextShip .
	cancellation from: player2  applyTo: player  canceled: speed .	
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: (aGameBoard cellOfShip: 1) equals: 7 .
]

{ #category : #tests }
CardsTests >> test012PlayWithCancelletionCardForAcceleration [
	| player player2  cancellation acceleration|

	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	cancellation:= Cancellation with: aGame .
	acceleration := Acceleration  with: aGame .
	player:= 1.
	player2:=2.
	aGameBoard add: acceleration  to: player.
	aGameBoard add: cancellation to: player2.

	acceleration applyToAllFrom: player . 
	aGame throwNextShip .
	aGame throwNextShip .
	cancellation from: player2 canceled: acceleration .
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: (aGameBoard cellOfShip: 1) equals: 7 .
]

{ #category : #tests }
CardsTests >> test013PlayWithRepeatCardEffectSpeedUpToThemself [
	|player player2   repeat speedUp|

	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	speedUp := SpeedUp new.
	repeat  := Repeat with: aGame .
	aGameBoard add: speedUp at: 3.
	player:= 1.
	player2:=2.
	aGameBoard add: repeat   to: player.

	aGame throwNextShip .
	repeat from: player to: player . 
	aGame throwNextShip .
	
	self assert: (aGameBoard cellOfShip: 1) equals: 3 .
]

{ #category : #tests }
CardsTests >> test014PlayWithRepeatCardEffectWormHole [
	|player player2  repeat wormHole|
	
	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1 1) and: #(1 6 3 1).
	wormHole := WormHole  new.
	repeat  := Repeat with: aGame .
	aGameBoard add: wormHole at: 6.
	player:= 1.
	player2:=2.
	aGameBoard add: repeat   to: player.
	
	aGame throwNextShip . "Cae en 2"
	aGame throwNextShip . "Cae en 7"
	aGame throwNextShip . "Cae en Wormhole"
	repeat from: player  to: player2  . 
		
	self assert: (aGameBoard cellOfShip: 2) equals: 3 .
]

{ #category : #tests }
CardsTests >> test015PlayWithRepeatCardEffectMoonWalk [
	|player player2 repeat moonWalk|
	
	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	moonWalk := MoonWalk with: -3.
	repeat  := Repeat with: aGame .
	aGameBoard add: moonWalk at: 6.
	player:= 1.
	player2:=2.
	aGameBoard add: repeat   to: player.
	
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	repeat from: player to: player2 . 
	
	self assert: (aGameBoard cellOfShip: 2) equals: 2 .
]

{ #category : #tests }
CardsTests >> test016PlayWithRepeatCardEffectAtomicBomb [
	| player player2  repeat anAtomicBomb|
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	anAtomicBomb := AtomicBomb new.
	repeat  := Repeat with: aGame .
	aGameBoard add: anAtomicBomb at: 5 .
	player:= 1.
	player2:=2.
	aGameBoard add: repeat   to: player.	
	
	aGame throwNextShip .
	aGame throwNextShip .
	repeat from: player. 
	
	self assert: (aGameBoard cellOfShip: 2) equals: 0 .
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
	aGameBoard cellsWith: 4 and: arrayOfDie .
	repeat  := Repeat with: aGame.
	aGameBoard add: hyperJump at: 3 .
	player:= 1.
	player2:=2.
	aGameBoard add: repeat   to: player.
	
	aGame throwNextShip .
	repeat  from: player  to: player .
			
	self assert: (aGameBoard cellOfShip: 1) equals: 5 .
	self assert: (aGameBoard lapOfShip: 1) equals: 1 .
]

{ #category : #tests }
CardsTests >> test018PlayWithRedoCardAndOverloadCard [
	| overload redo player player2 |
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	overload := Overload  with: aGame .
	redo:= Redo with: aGame .
	player:=1.
	player2:=2.
	aGameBoard add: overload to: player.
	aGameBoard add: redo to: player2.
	
	overload from: player applyTo: player2 . 
	aGame throwNextShip . 
	redo  from: player2 to: player .
	aGame throwNextShip . 
	aGame throwNextShip . 
	aGame throwNextShip .
	
	self assert: (aGameBoard cellOfShip: 1) equals: 4 .
	self assert: (aGameBoard cellOfShip: 2) equals: 6 .
		
	
	
	
]

{ #category : #tests }
CardsTests >> test019PlayWithRedoCardAndAccelerationCard [
	| acceleration redo player player2 |
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	acceleration := Acceleration with: aGame .
	redo:= Redo with: aGame .
	player:=1.
	player2:=2.
	aGameBoard add: acceleration to: player.
	aGameBoard add: redo to: player2.
	
	acceleration applyToAllFrom:  player . 
	aGame throwNextShip . 
	redo from: player2 . 
	aGame throwNextShip . 
	aGame throwNextShip . 
	aGame throwNextShip .
	
	self assert: (aGameBoard cellOfShip: 1) equals: 1 .
	self assert: (aGameBoard lapOfShip: 1) equals: 2 .
	self assert: (aGameBoard cellOfShip: 2) equals: 6 .
	self assert: (aGameBoard lapOfShip: 2) equals: 2 .
		
	
	
	
]

{ #category : #tests }
CardsTests >> test020PlayWithRedoCardAndSpeedCard [
	| speed redo player player2 |
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	speed := Speed with: aGame .
	redo:= Redo with: aGame .
	player:=1.
	player2:=2.
	aGameBoard add: speed to: player.
	aGameBoard add: redo to: player2.

	speed from: player applyTo: player . 
	aGame throwNextShip . 
	redo from: player2 to: player2 . 
	aGame throwNextShip . 
	aGame throwNextShip . 
	aGame throwNextShip .
	
	self assert: (aGameBoard cellOfShip: 1) equals: 8 .
	self assert: (aGameBoard cellOfShip: 2) equals: 4 .
		
	
	
	
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
	player:=1.
	player2:=2.
	aGameBoard add: speed1 to: player.
	aGameBoard add: cancellation to: player.
	aGameBoard add: redo to: player2.
	aGameBoard add: speed2 to: player2.
	
	speed1 from: player applyTo: player. 
	aGame throwNextShip . "1-P4 2-P0"
	speed2 from: player2  applyTo: player2. 
	aGame throwNextShip . "1-P4 2-P6"
	cancellation  from: player applyTo: player2  canceled: speed2 . 
	redo cancellationFrom: player2 to: player canceled: speed1.
	aGame throwNextShip . "1-P7 2-P6"
	aGame throwNextShip . "1-P7L1 2-P3L2"
	
	self assert: (aGameBoard cellOfShip: 1) equals: 7 .
	self assert: (aGameBoard lapOfShip: 1) equals: 1 .
	self assert: (aGameBoard cellOfShip: 2) equals: 3 .
	self assert: (aGameBoard lapOfShip: 2) equals: 2 .
		
	
	
	
]

{ #category : #tests }
CardsTests >> test022PlayWithRedoCardAndAnotherRedoCardWithPermanentLastCardWhenItsTheirTurn [
	| speed redo1 redo2 player player2 |
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	speed := Speed with: aGame .
	redo1:= Redo with: aGame .
	redo2:= Redo with: aGame .
	player:=1.
	player2:=2.
	aGameBoard add: speed to: player.
	aGameBoard add: redo1 to: player2.
	aGameBoard add: redo2 to: player2.

	speed  from: player applyTo: player .
	aGame throwNextShip . 
	redo1 from: player2  to: player2 .
	redo2 from: player2  to: player2 .
	aGame throwNextShip . 
	aGame throwNextShip . 
	aGame throwNextShip .
	
	self assert: (aGameBoard cellOfShip: 1) equals: 8 .
	self assert: (aGameBoard cellOfShip: 2) equals: 6 .
		
	
	
	
]

{ #category : #tests }
CardsTests >> test023PlayWithRedoCardAndAnotherRedoCardWithPermanentLastCardWhenItsNOTTheirTurn [
	| speed redo player player2 |

	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	speed := Speed with: aGame .
	redo:= Redo with: aGame .
	player:=1.
	player2:=2.
	aGameBoard add: speed to: player.
	aGameBoard add: redo to: player2.
	
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
	aGameBoard add: wormHole at: 4.
	ship:= 1.
	ship2:=2.
	aGameBoard add: repeat to: ship2.
	
	aGame throwNextShip . "P1 7 LAP1 P2 0 LAP1 "
	aGame throwNextShip . "P1 3 LAP1 P2 1 LAP1 "
	aGame throwNextShip . "P1 4 LAP2 P2 1 LAP1 --> P1 0 LAP2 P2 1 LAP1"
	
	self assert: aGame winner equals: 1. "Ship 1 has won"
	
	repeat from: ship2 to: ship. "P1 6 LAP1 P2 6 LAP1 "
	aGame throwNextShip . "P1 6 LAP1 P2 2 LAP2 "
	
	self assert: aGame winner equals: 2. "Ship 2 has finally won"
]

{ #category : #tests }
CardsTests >> test025CreateADeckThatGivesARandomCardToAShipFromTheGameboard [
	|aDeckOfCards aNumberOfShip|
	
	self setUpGameWith:  1 andGameboardWith: 10 and: 1.
	aDeckOfCards := DeckOfCards new.
	aNumberOfShip := 1.
	
	aDeckOfCards designateRandomCardTo: aNumberOfShip from: aGameBoard .
	
	self assert: (aGameBoard shipWith: aNumberOfShip)shipCards cardsInHand size equals: 2+1 "Two are random"
]

{ #category : #tests }
CardsTests >> test026PlayWithRedoaRepeatCardWithEffectWormHole [
	|player player2  repeat wormHole redo|
	
	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(2 1) and: #(2 4).
	wormHole := WormHole  new.
	repeat  := Repeat with: aGame .
	redo:= Redo with: aGame .
	aGameBoard add: wormHole at: 8.
	player:= 1.
	player2:=2.
	aGameBoard add: repeat to: player.
	aGameBoard add: redo to: player2. 
	
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	repeat from: player  to: player2  . 
	redo from: player2  to: player .
	
	self assert: (aGameBoard cellOfShip: 2) equals: 1 .
	self assert: (aGameBoard cellOfShip: 1) equals: 0 .
]

{ #category : #tests }
CardsTests >> test027PlayWithCancelletionCardForARedoOnAnOverload [
	| redo overload  player player2  cancellation|
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	cancellation:= Cancellation with: aGame .
	overload := Overload with: aGame .
	redo:= Redo with: aGame.
	player:= 1.
	player2:=2.
	aGameBoard add: overload to: player.
	aGameBoard add: cancellation to: player.
	aGameBoard add: redo to: player2.

	overload  from: player  applyTo: player2 .
	aGame throwNextShip .
	redo from: player2 to: player .
	cancellation from: player applyTo: player canceled: overload  .
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: (aGameBoard cellOfShip: 1)	 equals: 6 .
	self assert: (aGameBoard cellOfShip: 2)	 equals: 6 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test028PlayWithCancellationCardForRedoCardOnASpeedCard [
	| speed redo player player2 cancellation|
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	speed := Speed with: aGame .
	redo:= Redo with: aGame .
	cancellation := Cancellation with: aGame .
	player:=1.
	player2:=2.
	aGameBoard add: speed to: player.
	aGameBoard add: redo to: player2.
	aGameBoard add: cancellation to: player.

	speed from: player applyTo: player . 
	aGame throwNextShip . 
	redo from: player2 to: player2 . 
	cancellation from: player applyTo: player2 canceled: speed. 
	aGame throwNextShip . 
	aGame throwNextShip . 
	aGame throwNextShip .
	
	self assert: (aGameBoard cellOfShip: 1) equals: 8 .
	self assert: (aGameBoard cellOfShip: 2) equals: 2 .
		
	
	
	
]

{ #category : #tests }
CardsTests >> test029PlayWithCancellationCardForRedoOnAnAccelerationCard [

	| player player2  cancellation acceleration redo|

	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	cancellation:= Cancellation with: aGame .
	acceleration := Acceleration  with: aGame .
	redo := Redo with: aGame.	
	player:= 1.
	player2:= 2.
	aGameBoard add: acceleration  to: player.
	aGameBoard add: cancellation to: player.
	aGameBoard add: redo to: player2 .

	acceleration applyToAllFrom: player . 
	aGame throwNextShip .
	redo from: player2.
	aGame throwNextShip .
	cancellation from: player canceled: acceleration .
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: (aGameBoard cellOfShip: 1) equals: 8 .
]

{ #category : #tests }
CardsTests >> test030PlayWithCancelletionCardErrorIfTheCardIsNotInEffect [

	| redo overload player player2 cancellation |
	
	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	cancellation := Cancellation with: aGame.
	overload := Overload with: aGame.
	redo := Redo with: aGame.
	player := 1.
	player2 := 2.
	aGameBoard add: overload to: player.
	aGameBoard add: cancellation to: player.
	aGameBoard add: redo to: player2.

	overload from: player applyTo: player2.
	aGame throwNextShip.
	redo from: player2 to: player.
	
	self
		should: [ 
		cancellation from: player applyTo: player canceled: redo ]
		raise: Error
		withMessage:
		'The card you want to cancel is not affecting the ship'
]

{ #category : #tests }
CardsTests >> test031ThrowErrorWhenTheSelectedCardIsNotInShipHand [
	| speed redo player player2 cancellation|
	
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	speed := Speed with: aGame .
	redo:= Redo with: aGame .
	cancellation := Cancellation with: aGame .
	player:=1.
	player2:=2.
	aGameBoard add: speed to: player.
	aGameBoard add: redo to: player2.

	speed from: player applyTo: player . 
	aGame throwNextShip . 
	redo from: player2 to: player2 . 
	
	self
		should: [ 
		cancellation from: player applyTo: player2 canceled: speed ]
		raise: Error
		withMessage:
		'The card you want to use is not in your ships hand'
		
	
	
	
]

{ #category : #tests }
CardsTests >> test032ShipFallsInJailBecauseAnOverloadAndCantGetOut [
	| overload1 aJail  player player2 |
	
	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1 1 1) and: #(1 1 3 1 1).
	overload1 := Overload with: aGame  .
	aJail := Jail new.
	player:=1.
	player2:=2.
	aGameBoard add: overload1 to: player2.
	aGameBoard add: aJail at: 4.

	aGame throwNextShip .
	overload1 from: player2 applyTo: player.
	aGame throwNextShip .
	aGame throwNextShip . "Cae en Jail"
	aGame throwNextShip .
	aGame throwNextShip . "No logra salir"
	aGame throwNextShip .
	aGame throwNextShip . "Tira una vez mas"
	
	self assert: (aGameBoard cellOfShip: 1) equals: 4 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test033ShipFallsInJailBecauseAnOverloadAndCanGetOut [
	| overload1 aJail  player player2 |

	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1 1 4) and: #(1 1 1 1 4).
	overload1 := Overload with: aGame  .
	aJail := Jail new .
	player:=1.
	player2:=2.
	aGameBoard add: overload1 to: player2.
	aGameBoard add: aJail at: 4.

	aGame throwNextShip .
	overload1 from: player2 applyTo: player.
	aGame throwNextShip .
	aGame throwNextShip . "Cae en Jail"
	aGame throwNextShip .
	aGame throwNextShip . "Logra salir"
	aGame throwNextShip .
	aGame throwNextShip . "Tira una vez mas"
	
	self assert: (aGameBoard cellOfShip: 1) equals: 8 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test034ShipFallsInJailBecauseASpeedUpAndCanGetOut [
	| speed aJail  player player2 |

	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1 1 4) and: #(1 1 1 1 4).
	speed := Speed with: aGame  .
	aJail := Jail new .
	player:=1.
	player2:=2.
	aGameBoard add: speed to: player2.
	aGameBoard add: aJail at: 5.

	aGame throwNextShip .
	speed from: player2 applyTo: player.
	aGame throwNextShip .
	aGame throwNextShip . "Cae en Jail"
	aGame throwNextShip .
	aGame throwNextShip . "Logra salir"
	aGame throwNextShip .
	aGame throwNextShip . "Tira una vez mas"
	
	self assert: (aGameBoard cellOfShip: 1) equals: 8 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test035ShipFallsInJailBecauseASpeedUpAndCantGetOut [
	| speed aJail  player player2 |

	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1 5 4) and: #(1 1 1 4 4).
	speed := Speed with: aGame  .
	aJail := Jail new .
	player:=1.
	player2:=2.
	aGameBoard add: speed to: player2.
	aGameBoard add: aJail at: 5.

	aGame throwNextShip .
	speed from: player2 applyTo: player.
	aGame throwNextShip .
	aGame throwNextShip . "Cae en Jail"
	aGame throwNextShip .
	aGame throwNextShip . "No logra salir"
	aGame throwNextShip .
	aGame throwNextShip . "Tira una vez mas"
	
	self assert: (aGameBoard cellOfShip: 1) equals: 5 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test036ShipFallsInJailBecauseAnAccelerationCanGetOut [
	| acceleration aJail  player player2 |

	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1 1 4) and: #(1 1 1 1 4).
	acceleration := Acceleration with: aGame  .
	aJail := Jail new .
	player:=1.
	player2:=2.
	aGameBoard add: acceleration to: player2.
	aGameBoard add: aJail at: 5.

	aGame throwNextShip .
	acceleration applyToAllFrom:  player2.
	aGame throwNextShip .
	aGame throwNextShip . "Cae en Jail"
	aGame throwNextShip .
	aGame throwNextShip . "Logra salir"
	aGame throwNextShip .
	aGame throwNextShip . "Tira una vez mas"
	
	self assert: (aGameBoard cellOfShip: 1) equals: 8 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test037ShipFallsInJailBecauseAnAccelerationAndCantGetOut [
	| acceleration aJail  player player2 |

	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1 5 4) and: #(1 1 1 5 4).
	acceleration := Acceleration with: aGame  .
	aJail := Jail new .
	player:=1.
	player2:=2.
	aGameBoard add: acceleration to: player2.
	aGameBoard add: aJail at: 5.

	aGame throwNextShip .
	acceleration applyToAllFrom:  player2.
	aGame throwNextShip .
	aGame throwNextShip . "Cae en Jail"
	aGame throwNextShip .
	aGame throwNextShip . "No logra salir"
	aGame throwNextShip .
	aGame throwNextShip . "Tira una vez mas"
	
	self assert: (aGameBoard cellOfShip: 1) equals: 5 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test038ShipFallsInJailAndSendsOtherShipToJailWithRepeat [
	| aJail  player player2 repeat|
	
	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1) and: #(1 1).
	repeat := Repeat with: aGame  .
	aJail := Jail new .
	player:=1.
	player2:=2.
	aGameBoard add: repeat to: player.
	aGameBoard add: aJail at: 4.

	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip . "Cae en Jail"
	repeat from: player to: player2 . "Manda a Jail al player2"
	aGame throwNextShip . "No logra salir"
	aGame throwNextShip . "No logra salir"
	
	self assert: (aGameBoard cellOfShip: 1) equals: 4 .
	self assert: (aGameBoard cellOfShip: 2) equals: 4 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test039ShipUsesRedoOnARepeatThenSendsAnotherShipToJail [
	| aJail  player player2 player3 player4 repeat redo|

	self setUpGameWith: 4 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 2 1) and: #(1 1 1 1).
	repeat := Repeat with: aGame  .
	redo := Redo with: aGame .
	aJail := Jail new .
	player :=1.
	player2 :=2.
	player3 := 3.
	player4 := 4.
	aGameBoard add: repeat to: player.
	aGameBoard add: redo to: player3.
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
	
	self assert: (aGameBoard cellOfShip: 1) equals: 4 .
	self assert: (aGameBoard cellOfShip: 2) equals: 4 .
	self assert: (aGameBoard cellOfShip: 3) equals: 6 .
	self assert: (aGameBoard cellOfShip: 4) equals: 4 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test040TypeCardFreedomExistsThenAssert [
	
	|freedom|
	freedom := Freedom new.
	
	self assert: (freedom  isKindOf:  Freedom) .
]

{ #category : #tests }
CardsTests >> test041ShipUsesFreedomThenGetsOutOfJail [
	| aFreedom aJail  player |

	self setUpGameWith: 1 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	aFreedom := Freedom with: aGame  .
	aJail := Jail new .
	player:= 1.
	aGameBoard add: aFreedom to: player.
	aGameBoard add: aJail at: 4.

	aGame throwNextShip .
	aGame throwNextShip . "Cae en Jail"
	aFreedom from: player applyTo: player. "Se libera"
	aGame throwNextShip .
	
	self assert: (aGameBoard cellOfShip: 1) equals: 6 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test042ShipUsesFreedomOnAPlayerNotInJailThenError [
	| aFreedom aJail  player player2 |

	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	aFreedom := Freedom with: aGame  .
	aJail := Jail new .
	player:= 1.
	player2:= 2.
	aGameBoard add: aFreedom to: player.
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
	| aJail  player player2 redo aFreedom|

	self setUpGameWith: 2 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	redo := Redo with: aGame  .
	aFreedom := Freedom with: aGame .
	aJail := Jail new .
	player:=1.
	player2:=2.
	aGameBoard add: aFreedom to: player.
	aGameBoard add: redo to: player2.
	aGameBoard add: aJail at: 4.

	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip . "1 Cae en Jail"
	aGame throwNextShip . "2 Cae en Jail"
	aFreedom from: player applyTo: player . 
	redo from: player2 to: player2 . 
	aGame throwNextShip . 
	aGame throwNextShip . 
	
	self assert: (aGameBoard cellOfShip: 1) equals: 6 .
	self assert: (aGameBoard cellOfShip: 2) equals: 6 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test044ShipUsesRedoOfARedoOfAFreedomThenIsFree [
	| aJail  player player2 player3 redo redo2 aFreedom|

	self setUpGameWith: 3 andGameboardWith: 10 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	aFreedom := Freedom with: aGame .
	redo := Redo with: aGame  .
	redo2 := Redo with: aGame  .
	aJail := Jail new .
	player:= 1.
	player2:= 2.
	player3:= 3.
	aGameBoard add: aFreedom to: player.
	aGameBoard add: redo to: player2.
	aGameBoard add: redo2 to: player3.
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
	
	self assert: (aGameBoard cellOfShip: 1) equals: 6 .
	self assert: (aGameBoard cellOfShip: 2) equals: 6 .
	self assert: (aGameBoard cellOfShip: 3) equals: 6 .
	
	
	
	
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
CardsTests >> test052TypeCardReverseExists [
	
	|reverse|
	reverse := Reverse new.
	self assert: (reverse  isKindOf:  Reverse ) .
]

{ #category : #tests }
CardsTests >> test053ReverseCardIsUsedThenTurnsAreReversed [
	| reverse ship1 |
	
	self setUpGameWith: 3 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	reverse := Reverse with: aGame  .
	ship1:= 1.
	aGameBoard add: reverse to: ship1.
	
	aGame throwNextShip .
	aGame throwNextShip .
	reverse applyFrom: ship1.
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: (aGameBoard cellOfShip: 1) equals: 2 .
	self assert: (aGameBoard cellOfShip: 2) equals: 4 .
	self assert: (aGameBoard cellOfShip: 3) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test054ReverseCardWithTurnsDoingACompleteRoundReversed [
	| reverse ship1 |
	
	self setUpGameWith: 3 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	reverse := Reverse with: aGame  .
	ship1:= 1.
	aGameBoard add: reverse to: ship1.
	
	aGame throwNextShip .
	aGame throwNextShip .
	reverse applyFrom: ship1.
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: (aGameBoard cellOfShip: 1) equals: 4 .
	self assert: (aGameBoard cellOfShip: 2) equals: 4 .
	self assert: (aGameBoard cellOfShip: 3) equals: 4 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test055ReverseCardAppliedBeforeFirstThrow [
	| reverse ship1 |
	
	self setUpGameWith: 3 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	reverse := Reverse with: aGame  .
	ship1:= 1.
	aGameBoard add: reverse to: ship1.
	
	reverse applyFrom: ship1.
	aGame throwNextShip .
	aGame throwNextShip .
	
	self assert: (aGameBoard cellOfShip: 1) equals: 2 .
	self assert: (aGameBoard cellOfShip: 2) equals: 0 .
	self assert: (aGameBoard cellOfShip: 3) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test056TwoReverseCardsAppliedNothingChanges [
	| reverse  reverse2 ship1 ship2|
	
	self setUpGameWith: 3 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	reverse := Reverse with: aGame.
	reverse2 := Reverse with: aGame.
	ship1:= 1.
	ship2:= 2.
	aGameBoard add: reverse to: ship1.
	aGameBoard add: reverse2 to: ship2.
	
	aGame throwNextShip.
	reverse applyFrom: ship1.
	reverse2 applyFrom: ship2.
	aGame throwNextShip.
	aGame throwNextShip.
	
	self assert: (aGameBoard cellOfShip: 1) equals: 2 .
	self assert: (aGameBoard cellOfShip: 2) equals: 2 .
	self assert: (aGameBoard cellOfShip: 3) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test057RedoAReverseCardThenNothingChanges [
	| reverse  redo ship1 ship2|
	
	self setUpGameWith: 3 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	reverse := Reverse with: aGame.
	redo := Redo with: aGame.
	ship1:= 1.
	ship2:= 2.
	aGameBoard add: reverse to: ship1.
	aGameBoard add: redo to: ship2.
	
	aGame throwNextShip.
	reverse applyFrom: ship1.
	redo from: ship2.
	aGame throwNextShip.
	aGame throwNextShip.
	
	self assert: (aGameBoard cellOfShip: 1) equals: 2 .
	self assert: (aGameBoard cellOfShip: 2) equals: 2 .
	self assert: (aGameBoard cellOfShip: 3) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test058ReverseRobustInstanceCreation [
	| reverse |
	
	self
		should: [ 
		reverse := Reverse with: 2 . ]
		raise: Error
		withMessage:
		'The card must receive a ShipsGame instance'
	
	
]

{ #category : #tests }
CardsTests >> test059SameCardInstanceIsGivenToDifferentShipsThenError [
	|reverse ship1 ship2|
	
	self setUpGameWith: 3 andGameboardWith: 8 and: 2.
	self setUpLoadedDiceWith: #(1 1 1) and: #(1 1 1).
	reverse := Reverse with: aGame.
	
	ship1:= 1.
	ship2:= 2.
	aGameBoard add: reverse to: ship1.
	
	self
		should: [ 
		aGameBoard add: reverse to: ship2. ]
		raise: Error
		withMessage:
		'The card was already assigned to a ship'
	
	
	
	
]
