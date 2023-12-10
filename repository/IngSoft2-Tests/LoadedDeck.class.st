Class {
	#name : #LoadedDeck,
	#superclass : #Object,
	#instVars : [
		'collectionOfCards'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #action }
LoadedDeck class >> with: aCollectionOfCards [
	^(self new) initializeWith: aCollectionOfCards.
]

{ #category : #action }
LoadedDeck >> giveCard [
	^collectionOfCards removeFirst.
]

{ #category : #initialization }
LoadedDeck >> initializeWith: aCollectionOfCards [ 
	collectionOfCards := aCollectionOfCards.
]
