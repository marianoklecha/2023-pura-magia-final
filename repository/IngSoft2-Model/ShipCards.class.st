Class {
	#name : #ShipCards,
	#superclass : #Object,
	#instVars : [
		'aCollectionOfCards',
		'aCollectionOfCardsForMe'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
ShipCards class >> createNew [
	^(self new) initializeNew.
]

{ #category : #adding }
ShipCards >> add: aCard [ 
	aCollectionOfCards add: aCard.
]

{ #category : #action }
ShipCards >> cardsForMe [
	^aCollectionOfCardsForMe.
]

{ #category : #action }
ShipCards >> cardsInHand [
	^aCollectionOfCards
]

{ #category : #initialization }
ShipCards >> initializeNew [
	aCollectionOfCards := OrderedCollection new.
	aCollectionOfCardsForMe := OrderedCollection new.
]

{ #category : #action }
ShipCards >> resultOfCards [

	| result |
	result := 0.
	aCollectionOfCardsForMe do: [ :each | 
		result := result + each amountToChange ].
	^ result
]

{ #category : #action }
ShipCards >> store: aCardChosenForMe [ 
	aCollectionOfCardsForMe add: aCardChosenForMe.
]

{ #category : #action }
ShipCards >> verifyThatIncludes: aCard [

	| anArrayOfCards |
	anArrayOfCards := self cardsInHand.
	(anArrayOfCards includes: aCard) ifFalse: [ 
		Error signal: 'The card you want to use is not in your ships hand' ]
]
