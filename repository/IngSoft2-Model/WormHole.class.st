Class {
	#name : #WormHole,
	#superclass : #Object,
	#instVars : [
		'numberOfCell'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
WormHole >> applyEffectUsing: aGameBoard for: aChosenShip [

	| newCell newShipPosition shipPosition |
	newCell := aChosenShip actualPosition currentCell - 4.
	shipPosition := aChosenShip actualPosition.
	newShipPosition := aGameBoard positionsManager manageCellsOf: shipPosition at: newCell.
	aChosenShip changePosition: newShipPosition.
	^ self
]

{ #category : #'instance creation' }
WormHole >> with: aNumberOfCell [

	numberOfCell := aNumberOfCell .
]
