Class {
	#name : #EffectsTests,
	#superclass : #TestCase,
	#instVars : [
		'aGame',
		'cells',
		'numberOfLaps',
		'amountOfPlayers',
		'aGameBoard',
		'arrayOfDie',
		'numbers',
		'anotherNumbers',
		'die1',
		'die2',
		'aCollectionOfCards',
		'loadedDeck'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
EffectsTests >> setUpGameWith:  anAmountOfPlayers andGameboardWith: anAmountOfCells and: laps [
	cells:= anAmountOfCells .
	numberOfLaps:= laps.
	amountOfPlayers := anAmountOfPlayers .
	aGameBoard := GameBoard with: cells and: numberOfLaps.
	aGameBoard cellsDividedIn: 1.
	aGame:= ShipsGame with: amountOfPlayers and: aGameBoard.
]

{ #category : #running }
EffectsTests >> setUpLoadedDeck [
	aCollectionOfCards := OrderedCollection new.
	loadedDeck := LoadedDeck with: aCollectionOfCards.
	aGame useCardsFrom: loadedDeck.
]

{ #category : #running }
EffectsTests >> setUpLoadedDiceWith: array1 and: array2 [
	
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
EffectsTests >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [
	self
		should: anErrorBlock 
		raise: anExceptionClass 
		withExceptionDo: [ :error |
			self assert: error messageText equals: anErrorMessage 
			 ].
]

{ #category : #tests }
EffectsTests >> test031GameUsingSpeedUpEffect [
| speedUp|

speedUp:= SpeedUp new.
self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
aGameBoard add: speedUp at: 3.

aGame throwNextShip.
aGame throwNextShip.

self assert: ((aGameBoard specialEffectAt: 3) isKindOf:  SpeedUp) .





  
]

{ #category : #tests }
EffectsTests >> test032GamePlayerFallsInSpeedUpEffectThenChangePosition [
| speedUp|

speedUp:= SpeedUp new.
self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
aGameBoard add: speedUp at: 3.

aGame throwNextShip.

self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 7 .





  
]

{ #category : #tests }
EffectsTests >> test033GameUsingWormHoleEffect [
|wormHole|

wormHole:= WormHole new.
self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
aGameBoard add: wormHole at: 7.

aGame throwNextShip.
aGame throwNextShip.

self assert: ((aGameBoard specialEffectAt: 7) isKindOf:  WormHole) .





  
]

{ #category : #tests }
EffectsTests >> test034GamePlayerFallsInWormHoleEffectThenChangePosition [
| wormHole|

wormHole:= WormHole  new.
self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(6 4 ).
aGameBoard add: wormHole at: 7.

aGame throwNextShip.

self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 3 .





  
]

{ #category : #tests }
EffectsTests >> test034bisGamePlayerFallsInWormHoleEffectThenChangePosition [
| wormHole|
wormHole:= WormHole  new.

self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(1 4 ).
aGameBoard add: wormHole at: 2.

aGame throwNextShip .

self assert: ((aGameBoard shipWith: 1) actualPosition currentCell)  equals: 0 .
self assert: ((aGameBoard shipWith: 1) actualPosition currentLap) equals: 1 .





  
]

{ #category : #tests }
EffectsTests >> test035GamePlayAndCheckWinner [
| wormHole|

self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(6 4 ).
wormHole:= WormHole  new.

aGame throwNextShip.
aGame throwNextShip.
aGame throwNextShip.

self assert: aGame winner equals: 1 .





  
]

{ #category : #tests }
EffectsTests >> test036GamePlayerFallsInWormHoleAndThenSpeedUpOnlyWornHoleApplied [
| wormHole speedUp|

self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(6 4 ).
wormHole:= WormHole  new.
speedUp := SpeedUp new.
aGameBoard add: wormHole at: 7.
aGameBoard add: speedUp at: 3.

aGame throwNextShip .

self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 3 .





  
]

{ #category : #tests }
EffectsTests >> test037GameUsingMoonWalk [
|aMoonWalk|

self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
aMoonWalk := MoonWalk new.
aGameBoard add: aMoonWalk at: 2.

aGame throwNextShip.
aGame throwNextShip.

self assert: ((aGameBoard specialEffectAt: 2) isKindOf:  MoonWalk) .





  
]

{ #category : #tests }
EffectsTests >> test038GamePlayerFallsInMoonWalkEffectThenChangePositionOfOtherPlayers [

|aMoonWalk|

self setUpGameWith: 3 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(1 4 ).
aMoonWalk := MoonWalk with: -3.
aGameBoard add: aMoonWalk at: 2 .

aGame throwNextShip.

self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 0 .
self assert: ((aGameBoard shipWith: 2) actualPosition currentLap) equals: 1 .
self assert: ((aGameBoard shipWith: 3) actualPosition currentCell) equals: 0 .
self assert: ((aGameBoard shipWith: 3) actualPosition currentLap) equals: 1 .
self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 2 .
self assert: ((aGameBoard shipWith: 1) actualPosition currentLap) equals: 1 
]

{ #category : #tests }
EffectsTests >> test039GameHasTwoDifferentMoonWalksandDifferentPlayersFallInto [

|aMoonWalk anotherMoonWalk|

self setUpGameWith: 3 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(1 6 ).
aMoonWalk := MoonWalk with: -3.
anotherMoonWalk := MoonWalk with: -2.
aGameBoard add: aMoonWalk at: 2 .
aGameBoard add: anotherMoonWalk at: 7 .

aGame throwNextShip. "2L1 0L1 0L1 "
aGame throwNextShip. "0L1 7L1 0L1 "

self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 7 .
self assert: ((aGameBoard shipWith: 3) actualPosition currentCell)  equals: 0 .
self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 0 .






  
]

{ #category : #tests }
EffectsTests >> test040GameHasTwoDifferentMoonWalksandDifferentPlayersFallIntoAndCheckLaps [

|aMoonWalk anotherMoonWalk|

self setUpGameWith: 3 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(1 6 ).
aMoonWalk := MoonWalk with: -3.
anotherMoonWalk := MoonWalk with: -2.
aGameBoard add: aMoonWalk at: 2 .
aGameBoard add: anotherMoonWalk at: 7 .

aGame throwNextShip. 
aGame throwNextShip. 

self assert: ((aGameBoard shipWith: 2) actualPosition currentLap) equals: 1 .
self assert: ((aGameBoard shipWith: 3) actualPosition currentLap) equals: 1 .
self assert: ((aGameBoard shipWith: 1) actualPosition currentLap) equals: 1 .






  
]

{ #category : #tests }
EffectsTests >> test041GameUsingAtomicBomb [
|anAtomicBomb|

self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
anAtomicBomb := AtomicBomb new.
aGameBoard add: anAtomicBomb at: 8.

aGame throwNextShip .
aGame throwNextShip.

self assert: ((aGameBoard specialEffectAt: 8) isKindOf:  AtomicBomb ) .





  
]

{ #category : #tests }
EffectsTests >> test042GameUsingAtomicBombAllPlayersMovedToCellZero [

|anAtomicBomb|

self setUpGameWith: 3 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 1) and: #(1 4 7).
anAtomicBomb := AtomicBomb new.
aGameBoard add: anAtomicBomb at: 8 .

aGame throwNextShip.
aGame throwNextShip.
aGame throwNextShip.

self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 0 .
self assert: ((aGameBoard shipWith: 2) actualPosition currentLap) equals: 1 .
self assert: ((aGameBoard shipWith: 3) actualPosition currentCell) equals: 0 .
self assert: ((aGameBoard shipWith: 3) actualPosition currentLap)  equals: 1 .
self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 0 .
self assert: ((aGameBoard shipWith: 1) actualPosition currentLap) equals: 1 .





  
]

{ #category : #tests }
EffectsTests >> test044GameUsingHyperJump [
| hyperJump amountOfParsecsToMove parsc1 light1 parsc2 light2 collection1 |

self setUpGameWith: 2 andGameboardWith: 8 and: 2.
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
aGameBoard cellsDividedIn: 4.
aGameBoard shipsCanThrowUsing: arrayOfDie .
aGameBoard add: hyperJump  at: 3 .

aGame throwNextShip.
aGame throwNextShip.

self assert: (((aGameBoard shipWith: 1) actualPosition currentParsec) nominalValue ) equals: 4  .
self assert: (((aGameBoard shipWith: 2) actualPosition currentParsec) nominalValue ) equals: 3  .





  
]

{ #category : #tests }
EffectsTests >> test045GameUsingHyperJumpWhenCellChangeThanksToTheEffect [
| hyperJump amountOfParsecsToMove parsc1 light1 parsc2 light2 collection1 |

self setUpGameWith: 2 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 2 ).
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

aGame throwNextShip.

self assert: (((aGameBoard shipWith: 1)actualPosition currentParsec) nominalValue ) equals: 3  .
self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 4  .





  
]

{ #category : #tests }
EffectsTests >> test046PlayerFallsInHyperJumpAndChangeLapCellAndParsec [
| hyperJump amountOfParsecsToMove parsc1 light1 parsc2 light2 collection1 |

self setUpGameWith: 2 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(7 2 ).
parsc1 := Parsecs with: 7.
light1 := LightYears with: 9.
parsc2 := Parsecs with: 2.
light2 := LightYears with: 3.
amountOfParsecsToMove:= OrderedCollection new.
collection1:=OrderedCollection new.
collection1 add: parsc1; add: light1; add: parsc2; add: light2  .
amountOfParsecsToMove add: collection1 .
hyperJump := HyperJump with: amountOfParsecsToMove .
aGameBoard cellsDividedIn: 4.
aGameBoard shipsCanThrowUsing: arrayOfDie .
aGameBoard add: hyperJump  at: 8 .

aGame throwNextShip.

self assert: (((aGameBoard shipWith: 1)actualPosition currentParsec) nominalValue ) equals: 3  .
self assert: ((aGameBoard shipWith: 1) actualPosition currentCell)  equals: 1  .
self assert: ((aGameBoard shipWith: 1) actualPosition currentLap)  equals: 2  .





  
]

{ #category : #tests }
EffectsTests >> test047HyperJumpCausesNegativeParsecsThenChangePosition [
| hyperJump amountOfParsecsToMove parsc1 light1 parsc2 light2 collection1 |

self setUpGameWith: 2 andGameboardWith: 8 and: 2.
parsc1 := Parsecs with: -7.
light1 := LightYears with: -9.
parsc2 := Parsecs with: -1.
light2 := LightYears with: -3.
amountOfParsecsToMove:= OrderedCollection new.
collection1:=OrderedCollection new.
collection1 add: light2 ; add: parsc2 ; add: light1 ;add: parsc1  .
amountOfParsecsToMove add: collection1 .
hyperJump := HyperJump with: amountOfParsecsToMove .
arrayOfDie := OrderedCollection new.
arrayOfDie add: (LoadedDie with: #(1 1)); add: (LoadedDie with: #(2 2)).
aGameBoard cellsDividedIn: 4.
aGameBoard shipsCanThrowUsing: arrayOfDie .
aGameBoard add: hyperJump  at: 3 .

aGame throwNextShip.

self assert: (((aGameBoard shipWith: 1) actualPosition currentParsec) nominalValue ) equals: 3  .
self assert:  ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 2.





  
]

{ #category : #tests }
EffectsTests >> test048GameUsingHyperJumpWithMultipleArrayWithParsecs [
| hyperJump  arrayOfPosibilities parsc1 light1 parsc2 light2 parsc3 parsc4 amountOfParsecsToMove collection1 collection2 |

self setUpGameWith: 2 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 2 ).
arrayOfPosibilities:= #(#(7 3 2 1) #(-3 -4)).
parsc1 := Parsecs with: 7.
light1 := LightYears with: 9.
parsc2 := Parsecs with: 2.
light2 := LightYears with: 3.
parsc3 := Parsecs with: -3.
parsc4 := Parsecs with: -4.
amountOfParsecsToMove:= OrderedCollection new.
collection1:=OrderedCollection new.
collection2:=OrderedCollection new.
collection1 add: parsc1; add: light1; add: parsc2; add: light2 .
collection2 add: parsc3 ; add: parsc4 .
amountOfParsecsToMove add: collection1;add: collection2 .
hyperJump := HyperJump with: amountOfParsecsToMove .
aGameBoard cellsDividedIn: 4.
aGameBoard shipsCanThrowUsing: arrayOfDie .
aGameBoard add: hyperJump  at: 3 .

aGame throwNextShip.

self assert: (( ((aGameBoard shipWith: 1) actualPosition currentCell) = 4)  or: (((aGameBoard shipWith: 1) actualPosition currentCell) = 2)).





  
]

{ #category : #tests }
EffectsTests >> test051HyperJumpWithACollectionOutOfOrderThenRaiseAnException [
| amountOfParsecsToMove parsc1 light1 parsc2 light2 collection1 |

self setUpGameWith: 2 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 2 ).
parsc1 := Parsecs with: 4.
light1 := LightYears with: 3.
parsc2 := Parsecs with: 2.
light2 := LightYears with: 3.
amountOfParsecsToMove:= OrderedCollection new.
collection1:=OrderedCollection new.
collection1 add: parsc1; add: light1;  add: parsc2;  add: light2  .
amountOfParsecsToMove add: collection1 .

self should:[ HyperJump with: amountOfParsecsToMove ] raise: Error withMessage: 'Cannot create HyperJump with a collection out of order'.





  
]

{ #category : #tests }
EffectsTests >> test052GameUsingNullEffect [
| nullEffect |

nullEffect := NullEffect new.
self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
aGameBoard add: nullEffect at: 3.

self assert: ((aGameBoard specialEffectAt: 3) isKindOf:  NullEffect) .





  
]

{ #category : #tests }
EffectsTests >> test053GameUsingJail [
|aJail|

self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
aJail := Jail new.
aGameBoard add: aJail at: 8.

self assert: ((aGameBoard specialEffectAt: 8) isKindOf:  Jail ) .





  
]

{ #category : #tests }
EffectsTests >> test054ShipFallsInJailAndCantGetOut [
|aJail|

self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(7 3 ).
aJail := Jail new.
aGameBoard add: aJail at: 8.

aGame throwNextShip .
aGame throwNextShip .

self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 8.





  
]

{ #category : #tests }
EffectsTests >> test055ShipFallsInJailAndCanGetOutByHighestThrow [
|aJail|

self setUpGameWith: 1 andGameboardWith: 10 and: 2.
self setUpLoadedDiceWith: #(1 9 1) and: #(7 9 2).
aJail := Jail new.
aGameBoard add: aJail at: 8.

aGame throwNextShip .
aGame throwNextShip .
aGame throwNextShip .

self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 1.





  
]

{ #category : #tests }
EffectsTests >> test056ShipFallsInJailByFallingInWormHoleAndCanMove [
|aJail aWormhole|

self setUpGameWith: 1 andGameboardWith: 10 and: 2.
self setUpLoadedDiceWith: #(1 9 1) and: #(7 9 2).
aJail := Jail new.
aWormhole := WormHole new.
aGameBoard add: aWormhole at: 8.
aGameBoard add: aJail at: 4.

aGame throwNextShip .
aGame throwNextShip .

self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 2.





  
]

{ #category : #tests }
EffectsTests >> test057ShipFallsInJailByFallingInSpeedUpAndCanMove [
|aJail aSpeedUp|

self setUpGameWith: 1 andGameboardWith: 10 and: 2.
self setUpLoadedDiceWith: #(1 1 1) and: #(3 1 1).
aJail := Jail new.
aSpeedUp := SpeedUp new.
aGameBoard add: aSpeedUp at: 4.
aGameBoard add: aJail at: 8.

aGame throwNextShip .
aGame throwNextShip .
aGame throwNextShip .

self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 2.





  
]

{ #category : #tests }
EffectsTests >> test058ShipFallsInJailByFallingInHyperJumpAndCanMove [
| hyperJump amountOfParsecsToMove parsc1 light1 parsc2 light2 collection1 aJail|

self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 2 ).
parsc1 := Parsecs with: 6.
light1 := LightYears with: 9.
parsc2 := Parsecs with: 2.
light2 := LightYears with: 3.
amountOfParsecsToMove:= OrderedCollection new.
collection1:=OrderedCollection new.
collection1 add: parsc1; add: light1; add: parsc2; add: light2  .
amountOfParsecsToMove add: collection1 .
hyperJump := HyperJump with: amountOfParsecsToMove .
aJail := Jail new.
aGameBoard cellsDividedIn: 4.
aGameBoard shipsCanThrowUsing: arrayOfDie .
aGameBoard add: hyperJump  at: 3 .
aGameBoard add: aJail at: 4.

aGame throwNextShip.
aGame throwNextShip.

self assert: ((aGameBoard shipWith: 1) actualPosition currentCell ) equals: 7  .





  
]

{ #category : #tests }
EffectsTests >> test059ShipFallsInJailAndAtomicBombDoesNotMoveIt [
|aJail anAtomicBomb|

self setUpGameWith: 2 andGameboardWith: 10 and: 2.
self setUpLoadedDiceWith: #(1 1 1) and: #(7 3 1).
aJail := Jail new.
anAtomicBomb := AtomicBomb new.
aGameBoard add: anAtomicBomb at: 4.
aGameBoard add: aJail at: 8.

aGame throwNextShip .
aGame throwNextShip .
 
self assert: ((aGameBoard shipWith: 1) actualPosition currentCell) equals: 8.
self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 0.





  
]

{ #category : #tests }
EffectsTests >> test060MoonWalkRobustInstanceCreation [
|aMoonWalk|

self
	should: [ 
	aMoonWalk := MoonWalk with: 5 . ]
	raise: Error
	withMessage:
	'The number of cells must be negative and lower than zero'





  
]

{ #category : #tests }
EffectsTests >> test061ShipFallsInJailAndUsesDoubleToGetOut [
|aJail aDouble|

self setUpGameWith: 2 andGameboardWith: 10 and: 2.
self setUpLoadedDiceWith: #(1 9 1) and: #(7 9 2).
self setUpLoadedDeck .
aJail := Jail new.
aDouble := Double with: aGame.
aCollectionOfCards add: aDouble.
aGameBoard add: aJail at: 8.
aGame giveCardTo: 1.

aDouble applyFrom: 1.
aGame throwNextShip .
aGame throwNextShip .

self deny: ((aGameBoard spaceSheriff) isKeepingJailed: 1).
self assert: ((aGameBoard shipWith: 2) actualPosition currentCell) equals: 0.





  
]
