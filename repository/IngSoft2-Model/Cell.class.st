Class {
	#name : #Cell,
	#superclass : #Object,
	#instVars : [
		'effect',
		'numberCell'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Cell class >> with: aSpecialEffect and: aNumberOfCell [ 
	^(self new)initializeWith: aSpecialEffect and: aNumberOfCell.
]

{ #category : #initialization }
Cell >> initializeWith: anEffect and: aNumberOfCell [ 
	effect := anEffect.
	numberCell := aNumberOfCell. 
	 
]

{ #category : #validation }
Cell >> numberOfSpecialCell [
	^numberCell .
]

{ #category : #validation }
Cell >> typeOfSpecialEffect [
	^effect .
]
