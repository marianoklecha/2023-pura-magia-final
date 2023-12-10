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
TurnsManager >> doubleActualTurn [
	turnToThrow addLast: (turnToThrow first).
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
	self verifyNextTurnWith: shipNumber.
	^shipNumber.
	
]

{ #category : #action }
TurnsManager >> reverseTurnsOrder [
	amountToSum := amountToSum*(-1).
]

{ #category : #action }
TurnsManager >> skipTurn [
	self nextShipNumber.
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
	turnToThrow isEmpty ifFalse: [ ^ self ].
	shipNumber := aShipNumber + amountToSum.
	self verifyMax: shipNumber.
	self verifyMin: shipNumber.
	turnToThrow isEmpty ifTrue: [ turnToThrow addLast: shipNumber ]
]
