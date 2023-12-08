Class {
	#name : #Jail,
	#superclass : #Object,
	#instVars : [
		'numberOfCell'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Jail >> applyTo: aGameBoard for: aShip [
	self check: aShip positionOn: aGameBoard.
	aGameBoard spaceSheriff jail: aShip.
	^self.
]

{ #category : #action }
Jail >> check: aShip positionOn: aGameBoard [ 
	|aShipPosition actualShipPosition|
	actualShipPosition := aShip actualPosition.
	(actualShipPosition currentCell = numberOfCell) ifFalse: [ 
		aShipPosition := aGameBoard positionManager manageCellsOf: actualShipPosition at: numberOfCell.
		aShip changePosition: aShipPosition.
		 ]
]

{ #category : #action }
Jail >> with: aNumberOfCell [
	numberOfCell := aNumberOfCell .
]
