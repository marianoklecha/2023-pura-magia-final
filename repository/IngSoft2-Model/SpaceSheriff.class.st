Class {
	#name : #SpaceSheriff,
	#superclass : #Object,
	#instVars : [
		'dieCollection',
		'shipsInJail'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SpaceSheriff class >> with: aDieCollection [ 
	^(self new) initializeWith: aDieCollection.
]

{ #category : #action }
SpaceSheriff >> giveChanceToFree: aShip with: aDieResult [ 
	|highestResult|
	highestResult := 0.
	1 to: dieCollection size do: [:number | highestResult := highestResult + (dieCollection at: number) faces].
	(aDieResult = highestResult) ifTrue: [ 
		shipsInJail remove: aShip .
		^aDieResult
		 ] ifFalse:  [ ^ 0]
]

{ #category : #action }
SpaceSheriff >> initializeWith: aDieCollection [ 
	dieCollection := aDieCollection.
	shipsInJail := OrderedCollection new.
]

{ #category : #action }
SpaceSheriff >> isKeepingJailed: aShip [ 
	^(shipsInJail includes: aShip)
]

{ #category : #action }
SpaceSheriff >> jail: aShip [

	(shipsInJail includes: aShip) ifFalse: [ shipsInJail add: aShip ]
]

{ #category : #action }
SpaceSheriff >> verifyCardsEffectOn: aShip with: aCardsResult [ 
	(self isKeepingJailed: aShip) ifTrue: [ ^0 ] ifFalse: [ ^aCardsResult ] 
]

{ #category : #action }
SpaceSheriff >> verifyMoveOf: aShip with: aResult [ 
	(shipsInJail includes: aShip) ifTrue: [ ^ self giveChanceToFree: aShip with: aResult ] ifFalse: [ ^ aResult ]
]
