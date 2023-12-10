Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'numberOfShip',
		'aShipPosition',
		'aShipCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Ship class >> verifyCanExistWith: aNumber [ 
	(aNumber < 1) ifTrue: [ Error signal: 'Ship number cant be negative or zero' ]
]

{ #category : #initialization }
Ship class >> with: aNumberOfShip [ 
	self verifyCanExistWith: aNumberOfShip.
	^(self new) initializeWith: aNumberOfShip.
]

{ #category : #action }
Ship >> actualPosition [
	^aShipPosition.
]

{ #category : #adding }
Ship >> add: aCard [ 
	aShipCards add: aCard.
]

{ #category : #action }
Ship >> changePosition: aNewShipPosition [  
	aShipPosition := aNewShipPosition.
]

{ #category : #initialization }
Ship >> initializeWith: aNumberOfShip [ 
	numberOfShip:= aNumberOfShip.
	aShipPosition:= ShipPosition createNew.
	aShipCards := ShipCards createNew.
]

{ #category : #validation }
Ship >> numberOfShip [
	^ numberOfShip
]

{ #category : #action }
Ship >> resultOfCards [
	^(aShipCards resultOfCards).
]

{ #category : #validation }
Ship >> shipCards [
	^aShipCards.
]

{ #category : #action }
Ship >> throw: aCollectionOfDices [
	| result |
	result := 0.
	self verifyIsPossibleToThrow: aCollectionOfDices.
	aCollectionOfDices do: [ :each | result := result + each throw ].

	^ result
]

{ #category : #action }
Ship >> verifyIsPossibleToThrow: aCollection [

	(aCollection isKindOf: OrderedCollection)
		ifTrue: [ 
			(((aCollection at: 1) isKindOf: LoadedDie) or:
				 ((aCollection at: 1) isKindOf: Die)) ifFalse: [ 
				Error signal: 'There is no die to throw' ] ]
		ifFalse: [ Error signal: 'There is no die to throw' ]
]
