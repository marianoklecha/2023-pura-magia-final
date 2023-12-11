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

	(collectionOfCards isEmpty) ifTrue: [ Error signal: 'Deck has no more cards' ].
	^collectionOfCards removeFirst.
]

{ #category : #initialization }
LoadedDeck >> initializeWith: aCollectionOfCards [ 

	collectionOfCards := aCollectionOfCards.
]
