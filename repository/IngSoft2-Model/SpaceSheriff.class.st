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

	| highestResult |
	highestResult := 0.
	dieCollection do: [ :each | 
		highestResult := highestResult + each faces ].
	aDieResult = highestResult ifFalse: [ ^ self ].
	shipsInJail remove: aShip
]

{ #category : #action }
SpaceSheriff >> initializeWith: aDieCollection [ 
	dieCollection := aDieCollection.
	shipsInJail := OrderedCollection new.
]

{ #category : #action }
SpaceSheriff >> isKeepingJailed: aShip [

	^ shipsInJail includes: aShip
]

{ #category : #action }
SpaceSheriff >> jail: aShip [

	(shipsInJail includes: aShip) ifFalse: [ shipsInJail add: aShip ]
]

{ #category : #action }
SpaceSheriff >> verifyMoveOf: aShip with: aResult [

	(shipsInJail includes: aShip)
		ifTrue: [ 
			self giveChanceToFree: aShip with: aResult.
			^ false ]
		ifFalse: [ ^ true ]
]
