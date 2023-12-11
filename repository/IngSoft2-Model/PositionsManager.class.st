Class {
	#name : #PositionsManager,
	#superclass : #Object,
	#instVars : [
		'cells',
		'parsecs',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
PositionsManager class >> with: amountOfCells and: numberOfLaps [ 
	^(self new) initializeWith: amountOfCells and: numberOfLaps.
]

{ #category : #initialization }
PositionsManager >> cells [
	
	^cells
]

{ #category : #initialization }
PositionsManager >> cellsDividedIn: anAmountOfParsecs [

	self verifyCellsCanDivideIn: anAmountOfParsecs.
	parsecs := anAmountOfParsecs.
]

{ #category : #'manage move' }
PositionsManager >> change: aShipPosition changingLap: aResult [

	| result newLap newShipPosition |
	result := aResult.
	newLap := aShipPosition currentLap.
	[ result > cells ] whileTrue: [ 
		result := result - cells.
		newLap := newLap + 1 ].
	^ newShipPosition := ShipPosition createWith: result at: newLap and: aShipPosition currentParsec.
]

{ #category : #action }
PositionsManager >> change: aShipPosition using: aNewParsec [

	|newShipPosition  position newLap |
	newLap:=aShipPosition currentLap.
	position := aShipPosition currentCell . 
	^ newShipPosition := ShipPosition createWith: position   at: newLap and: (Parsecs with: aNewParsec).
]

{ #category : #action }
PositionsManager >> change: aShipPosition with: newCell [

	|newShipPosition newLap parsec|
	newLap:= aShipPosition currentLap.
	parsec := aShipPosition currentParsec .
	^ newShipPosition := ShipPosition createWith: newCell at: newLap and: parsec .
]

{ #category : #'manage action' }
PositionsManager >> change: aShipPosition withNegative: amountOfCells [ 

	|newShipPosition newCell newLap |
	newCell := amountOfCells.
	newLap := aShipPosition currentLap.
	[ newCell < 0 ] whileTrue: [
		(newLap = 1) ifTrue: [ ^ newShipPosition := ShipPosition createNew.].
		newCell := cells + newCell.
		newLap:= newLap - 1 .].
		^ newShipPosition := ShipPosition createWith: newCell at: newLap and: (aShipPosition currentParsec).
]

{ #category : #'manage action' }
PositionsManager >> change: aShipPosition withNegativeAmountOf: parsecsObtained [

	| newShipPosition newParsec cell |
	newParsec := parsecsObtained.
	cell := aShipPosition currentCell.
	[ newParsec < 0 ] whileTrue: [ 
		cell := cell - 1.
		newParsec := newParsec + parsecs ].
	newShipPosition := self manageCellsOf: aShipPosition at: cell.
	^ newShipPosition := ShipPosition createWith: newShipPosition currentCell
		                   at: newShipPosition currentLap and: (Parsecs with: newParsec).
]

{ #category : #'manage action' }
PositionsManager >> change: aShipPosition withParsecsDivisionLowThan: aParsecsAmount [

	| newParsec cell newShipPosition |
	newParsec := aParsecsAmount.
	cell := aShipPosition currentCell.
	[ newParsec > parsecs ] whileTrue: [ 
		cell := cell + 1.
		newParsec := newParsec - parsecs ].
	newShipPosition := self manageCellsOf: aShipPosition at: cell.
	^ newShipPosition := ShipPosition createWith: newShipPosition currentCell
		                   at: newShipPosition currentLap and: (Parsecs with: newParsec).
]

{ #category : #initialization }
PositionsManager >> initializeWith: anAmountOfCells and: numberOfLaps [ 

	cells := anAmountOfCells .
	laps := numberOfLaps .
	parsecs := 1.
]

{ #category : #initialization }
PositionsManager >> lapsToWin [

	^laps
]

{ #category : #'manage move' }
PositionsManager >> manageCellsOf: aShipPosition at: newCell [

	| newShipPosition |
	newShipPosition := ShipPosition createNew.
	newCell < 0 ifTrue: [ 
		newShipPosition := self change: aShipPosition withNegative: newCell ].
	(newCell <= cells and: newCell >= 0) ifTrue: [ 
		newShipPosition := self change: aShipPosition with: newCell ].
	newCell > cells ifTrue: [ 
		newShipPosition := self change: aShipPosition changingLap: newCell ].

	^ newShipPosition
]

{ #category : #'manage move' }
PositionsManager >> manageParsecsOf: aShipPosition at: aNewParsec [

	| newShipPosition result |
	newShipPosition := ShipPosition createNew .
	result := aNewParsec + aShipPosition currentParsec nominalValue.
	result < 0 ifTrue: [ 
		newShipPosition := self change: aShipPosition withNegativeAmountOf: result ].
	(result <= parsecs and: result >= 0) ifTrue: [ 
		newShipPosition := self change: aShipPosition using: result ].
	result > parsecs ifTrue: [ 
		newShipPosition := self change: aShipPosition withParsecsDivisionLowThan: result ].

	^ newShipPosition
]

{ #category : #action }
PositionsManager >> updateToGameCellsHaving: anAmountOfCells [

	| auxResult |
	auxResult := anAmountOfCells.
	[ auxResult > cells ] whileTrue: [ auxResult := auxResult - cells ].
	^ auxResult
]

{ #category : #initialization }
PositionsManager >> verifyCellsCanDivideIn: anAmountOfParsecs [ 

	(anAmountOfParsecs < 1) ifTrue:[ Error signal: 'The amount of parsecs cant be negative or zero' ]
]
