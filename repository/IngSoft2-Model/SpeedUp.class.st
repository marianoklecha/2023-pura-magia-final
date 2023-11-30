Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedUp >> applyTo: aGameBoard for: aChosenShip [  
	|newCell newShipPosition shipPosition|
	newCell := (((aChosenShip shipPosition ) currentCell)+4).
	shipPosition := aChosenShip shipPosition .
	newShipPosition := (aGameBoard positionManager) manageCellsOf: shipPosition at: newCell.
	aChosenShip  changePosition: newShipPosition.
	^self.
]
