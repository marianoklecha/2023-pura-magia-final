Class {
	#name : #MoonWalk,
	#superclass : #Object,
	#instVars : [
		'amountOfCells',
		'numberOfCell'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
MoonWalk class >> verifyCanExistWith: aNumberOfCells [ 
	(aNumberOfCells <= 0)ifFalse:[ Error signal: 'The number of cells must be negative and lower than zero' ]
]

{ #category : #initialization }
MoonWalk class >> with: anAmountOfCells [
	self verifyCanExistWith: anAmountOfCells.
	^(self new) initializeWith: anAmountOfCells.
]

{ #category : #action }
MoonWalk >> applyEffectUsing: aGameBoard for: aChosenShip [

	| newCell shipPosition newShipPosition |
	1 to: aGameBoard amountOfShipsPlaying do: [ :number | 
		(aGameBoard shipWith: number) = aChosenShip ifFalse: [ 
			newCell := (aGameBoard shipWith: number) actualPosition currentCell + amountOfCells.
			shipPosition := (aGameBoard shipWith: number) actualPosition.
			newShipPosition := (aGameBoard positionManager) manageCellsOf: shipPosition at: newCell.
			(aGameBoard shipWith: number) changePosition: newShipPosition ] ].
	^self.
]

{ #category : #initialization }
MoonWalk >> initializeWith: anAmountOfCells [ 

	amountOfCells:= anAmountOfCells .
]

{ #category : #action }
MoonWalk >> with: aNumberOfCell [

	numberOfCell := aNumberOfCell .
]
