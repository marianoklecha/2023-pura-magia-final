Class {
	#name : #Repeat,
	#superclass : #Object,
	#instVars : [
		'chosenShip',
		'shipsGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Repeat class >> with: aShipsGame [ 
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Repeat >> apply: aGameBoard [ 
	|lastEffectUsed counter|
	counter:=1.
	lastEffectUsed:= aGameBoard lastEffectUsed  .
	lastEffectUsed applyTo: aGameBoard  for: chosenShip  .
	^(self)
]

{ #category : #action }
Repeat >> from: aNumberOfShip [
	shipsGame  chosen: self from: aNumberOfShip.
	shipsGame  applyChosenCard.
]

{ #category : #action }
Repeat >> from: aNumberOfShip to: aChosenNumberOfShip [
	shipsGame chosen: self from: aNumberOfShip.
	shipsGame cardDirectedTo: aChosenNumberOfShip.
	shipsGame applyChosenCard.
]

{ #category : #initialization }
Repeat >> initializeWith: aShipsGame [ 
	shipsGame := aShipsGame .
]

{ #category : #action }
Repeat >> permanent [
	^false.
]

{ #category : #validation }
Repeat >> permanent: aShipsGame verify: aNumberOfShip [

	aShipsGame verify: self IsInHandOf: aNumberOfShip.
	aShipsGame chosenCard: self.
	aShipsGame cardDirectedTo: aNumberOfShip
]

{ #category : #intance }
Repeat >> selected: aShipPosition [ 
	chosenShip:= aShipPosition.
]
