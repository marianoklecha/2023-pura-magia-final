Class {
	#name : #Skip,
	#superclass : #Object,
	#instVars : [
		'shipsGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Skip class >> verifyCanInitializeWith: anInstance [ 
	(anInstance isKindOf: ShipsGame)ifFalse:[ Error signal: 'The card must receive a ShipsGame instance' ]
]

{ #category : #action }
Skip class >> with: aShipsGame [
	self verifyCanInitializeWith: aShipsGame.
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Skip >> apply: aGameBoard [

	| shipNumber turnsCollection amountOfShips|
	turnsCollection := shipsGame turnsManager turns.
	shipNumber := turnsCollection removeFirst.
	amountOfShips := aGameBoard amountOfShipsPlaying .
	turnsCollection isEmpty ifTrue: [
		turnsCollection:= self verifyConsistencyWith: shipNumber and: amountOfShips].
	shipsGame turnsManager changeTurns: turnsCollection .
]

{ #category : #action }
Skip >> applyFrom: aNumberOfShip [ 
	shipsGame chosen: self from: aNumberOfShip.
	shipsGame applyChosenCard.
]

{ #category : #action }
Skip >> initializeWith: aShipsGame [ 
	shipsGame := aShipsGame .
]

{ #category : #action }
Skip >> permanent [
	^false.
]

{ #category : #action }
Skip >> selected: aNumberOfShip [ 
	^self.
]

{ #category : #action }
Skip >> verifyConsistencyWith: aShipNumber and: amountOfShips [ 
		|shipNumber turnsCollection|
		turnsCollection := OrderedCollection new.
		shipNumber := aShipNumber + shipsGame turnsManager amountToSum .
		shipNumber > amountOfShips ifTrue: [ turnsCollection addLast: 1 ].
		shipNumber = 0 ifTrue: [ turnsCollection addLast: amountOfShips ]. 
		turnsCollection isEmpty ifTrue: [ turnsCollection addLast: shipNumber ].
		^turnsCollection
]

{ #category : #action }
Skip >> verifyUseWith: aNumberOfShip [ 	
	shipsGame verify: self IsInHandOf: aNumberOfShip.
	shipsGame chosenCard: self .
]
