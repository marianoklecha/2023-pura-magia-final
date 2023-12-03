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
