Class {
	#name : #MoonWalk,
	#superclass : #Object,
	#instVars : [
		'amountOfCells'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
MoonWalk class >> with: anAmountOfCells [ 
	^(self new) initializeWith: anAmountOfCells.
]

{ #category : #action }
MoonWalk >> applyTo: aGameBoard for: aChosenShip [
	| newCell shipPosition newShipPosition |
	
	1 to: aGameBoard amountOfShipsPlaying do: [ :index | 
		(aGameBoard shipWithNumber: index) = aChosenShip ifFalse: [ 
			newCell := (aGameBoard shipWithNumber: index) shipPosition currentCell + amountOfCells.
			shipPosition := (aGameBoard shipWithNumber: index) shipPosition.
			newShipPosition := (aGameBoard positionManager) manageCellsOf: shipPosition at: newCell.
			(aGameBoard shipWithNumber: index) changePosition: newShipPosition ] ].
	^self.
]

{ #category : #initialization }
MoonWalk >> initializeWith: anAmountOfCells [ 
	amountOfCells:= anAmountOfCells .
]
