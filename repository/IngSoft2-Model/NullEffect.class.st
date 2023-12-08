Class {
	#name : #NullEffect,
	#superclass : #Object,
	#instVars : [
		'numberOfCell'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
NullEffect >> applyTo: aGameBoard for: aShip [ 
	^ self .
]

{ #category : #action }
NullEffect >> numberOfSpecialCell [
	^numberOfCell .
]

{ #category : #action }
NullEffect >> with: aNumberOfCell [
	numberOfCell := aNumberOfCell .
]
