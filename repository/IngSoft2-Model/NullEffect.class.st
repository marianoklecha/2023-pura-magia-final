Class {
	#name : #NullEffect,
	#superclass : #Object,
	#instVars : [
		'numberOfCell'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
NullEffect >> applyEffectUsing: aGameBoard for: aShip [ 

	^ self .
]

{ #category : #action }
NullEffect >> with: aNumberOfCell [

	numberOfCell := aNumberOfCell .
]
