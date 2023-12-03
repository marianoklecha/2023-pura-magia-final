Class {
	#name : #Jail,
	#superclass : #Object,
	#instVars : [
		'shipsInJail'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Jail >> applyTo: aGameBoard for: aShip [ 
	aGameBoard spaceSheriff jail: aShip.
]

{ #category : #initialization }
Jail >> initializeWith: aCollection [ 
	shipsInJail := aCollection .
]

{ #category : #action }
Jail >> jail: aShip [ 
	(shipsInJail includes: aShip) ifFalse: [ 
		shipsInJail add: aShip ]
]
