Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'numbers',
		'round'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
LoadedDie class >> with: numbers [ 
	^(self new) initializeWith: numbers
]

{ #category : #faces }
LoadedDie >> faces [

	|values highestValue|
	values := numbers sorted: [:value1 :value2 | value1 > value2].
	highestValue := values at: 1.
	^highestValue.
]

{ #category : #initialization }
LoadedDie >> initializeWith: aNumbers [

	numbers := aNumbers.
	round := 0.
]

{ #category : #action }
LoadedDie >> throw [

	| result |
	round := round + 1.
	round > numbers size ifTrue: [ round := 1 ].
	result := numbers at: round.
	^ result
]
