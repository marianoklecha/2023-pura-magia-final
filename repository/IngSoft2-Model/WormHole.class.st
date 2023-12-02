Class {
	#name : #WormHole,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
WormHole >> applyTo: aGameBoard for: aChosenShip [
	|newCell newShipPosition shipPosition|
	newCell := (((aChosenShip actualPosition ) currentCell)-4).
	shipPosition := aChosenShip actualPosition .
	newShipPosition := (aGameBoard positionManager) manageCellsOf: shipPosition at: newCell.
	aChosenShip  changePosition: newShipPosition.
	^self.
]
