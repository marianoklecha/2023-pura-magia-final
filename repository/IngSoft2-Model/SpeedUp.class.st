Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#instVars : [
		'numberOfCell'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedUp >> applyTo: aGameBoard for: aChosenShip [  
	|newCell newShipPosition shipPosition|
	newCell := (((aChosenShip actualPosition ) currentCell)+4).
	shipPosition := aChosenShip actualPosition .
	newShipPosition := (aGameBoard positionManager) manageCellsOf: shipPosition at: newCell.
	aChosenShip  changePosition: newShipPosition.
	^self.
]

{ #category : #action }
SpeedUp >> with: aNumberOfCell [
	numberOfCell := aNumberOfCell .
]
