Class {
	#name : #TurnsManager,
	#superclass : #Object,
	#instVars : [
		'turnToThrow',
		'amountToSum',
		'amountOfShips'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
TurnsManager class >> verifyCanInitializeWith: aNumberOfShips [ 
	(aNumberOfShips <= 0) ifTrue:[ Error signal: 'The amount of ships must be 1 or more' ]
]

{ #category : #initialization }
TurnsManager class >> with: aNumberOfShips [

	self verifyCanInitializeWith: aNumberOfShips.
	^ self new initializeWith: aNumberOfShips
]

{ #category : #action }
TurnsManager >> amountToSum [
	^ amountToSum
]

{ #category : #action }
TurnsManager >> change: anAmountToSum [
	amountToSum := anAmountToSum .
]

{ #category : #action }
TurnsManager >> changeTurns: aTurnsCollection [ 
	turnToThrow := aTurnsCollection.
]

{ #category : #initialization }
TurnsManager >> initializeWith: aNumberOfShips [ 
	amountOfShips := aNumberOfShips.
	amountToSum := 1.
	turnToThrow := OrderedCollection new.
	turnToThrow add: 1.
]

{ #category : #action }
TurnsManager >> nextShipNumber [

	| shipNumber |
	shipNumber := turnToThrow removeFirst.
	turnToThrow isEmpty ifTrue: [ self verifyNextTurnWith: shipNumber ].
	^ shipNumber
]

{ #category : #action }
TurnsManager >> turns [
	^turnToThrow.
]

{ #category : #action }
TurnsManager >> verifyIsTurnOf: aNumberOfShip [

	aNumberOfShip = turnToThrow first ifFalse: [ 
		Error signal: 'Cannot use permanent card when its not their turn' ]
]

{ #category : #action }
TurnsManager >> verifyMax: shipNumber [

	shipNumber > amountOfShips ifTrue: [ turnToThrow addLast: 1 ]
]

{ #category : #action }
TurnsManager >> verifyMin: shipNumber [

	shipNumber = 0 ifTrue: [ turnToThrow addLast: amountOfShips ]
]

{ #category : #action }
TurnsManager >> verifyNextTurnWith: aShipNumber [

	| shipNumber |
	shipNumber := aShipNumber + amountToSum.
	self verifyMax: shipNumber.
	self verifyMin: shipNumber.
	turnToThrow isEmpty ifTrue: [ turnToThrow addLast: shipNumber ]
]
