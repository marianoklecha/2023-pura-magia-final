Class {
	#name : #PositionManager,
	#superclass : #Object,
	#instVars : [
		'cells',
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
PositionManager class >> with: amountOfCells and: amountOfParsecs [ 
	^(self new) initializeWith: amountOfCells and: amountOfParsecs.
]

{ #category : #'manage move' }
PositionManager >> change: aShipPosition changingLap: aResult [

	| result newLap newShipPosition |
	result := aResult.
	newLap := aShipPosition currentLap.
	[ result > cells ] whileTrue: [ 
		result := result - cells.
		newLap := newLap + 1 ].
	^ newShipPosition := ShipPosition createWith: result at: newLap and: aShipPosition currentParsec.
]

{ #category : #action }
PositionManager >> change: aShipPosition using: aNewParsec [

	|newShipPosition  position newLap |
	newLap:=aShipPosition currentLap.
	position := aShipPosition currentCell . 
	^ newShipPosition := ShipPosition createWith: position   at: newLap and: (Parsecs with: aNewParsec).
]

{ #category : #action }
PositionManager >> change: aShipPosition with: newCell [

	|newShipPosition newLap parsec|
	newLap:= aShipPosition currentLap.
	parsec := aShipPosition currentParsec .
	^ newShipPosition := ShipPosition createWith: newCell at: newLap and: parsec .
]

{ #category : #'manage action' }
PositionManager >> change: aShipPosition withMoreParsecsThanMax: aResult [

	| newParsec cell newShipPosition |
	newParsec := aResult.
	cell := aShipPosition currentCell.
	[ newParsec > parsecs ] whileTrue: [ 
		cell := cell + 1.
		newParsec := newParsec - parsecs ].
	newShipPosition := self manageCellsOf: aShipPosition at: cell.
	^ newShipPosition := ShipPosition createWith: newShipPosition currentCell
		                   at: newShipPosition currentLap
		                   and: (Parsecs with: newParsec).
]

{ #category : #'manage action' }
PositionManager >> change: aShipPosition withNegative: aResult [ 

	|newShipPosition newCell newLap |
	newCell := aResult.
	newLap := aShipPosition currentLap.
	[ newCell < 0 ] whileTrue: [
		(newLap = 1) ifTrue: [ ^ newShipPosition := ShipPosition createNew.].
		newCell := cells + newCell.
		newLap:= newLap - 1 .].
		^ newShipPosition := ShipPosition createWith: newCell at: newLap and: (aShipPosition currentParsec).
]

{ #category : #'manage action' }
PositionManager >> change: aShipPosition withNegativeParsecs: aResult [

	| newShipPosition newParsec cell |
	newParsec := aResult.
	cell := aShipPosition currentCell.
	[ newParsec < 0 ] whileTrue: [ 
		cell := cell - 1.
		newParsec := newParsec + parsecs ].
	newShipPosition := self manageCellsOf: aShipPosition at: cell.
	^ newShipPosition := ShipPosition createWith: newShipPosition currentCell
		                   at: newShipPosition currentLap
		                   and: (Parsecs with: newParsec).
]

{ #category : #initialization }
PositionManager >> initializeWith: anAmountOfCells and: anAmountOfParsecs [ 

	cells := anAmountOfCells .
	parsecs := anAmountOfParsecs .
]

{ #category : #'manage move' }
PositionManager >> manageCellsOf: aShipPosition at: newCell [

	| newShipPosition |
	newShipPosition := ShipPosition createNew.
	newCell <= cells ifTrue: [ 
		newShipPosition := self change: aShipPosition with: newCell ].
	newCell < 0 ifTrue: [ 
		newShipPosition := self change: aShipPosition withNegative: newCell ].
	newCell > cells ifTrue: [ 
		newShipPosition := self change: aShipPosition changingLap: newCell ].

	^ newShipPosition
]

{ #category : #'manage move' }
PositionManager >> manageParsecsOf: aShipPosition at: aNewParsec [

	| newShipPosition result |
	newShipPosition := ShipPosition createNew .
	result := aNewParsec + aShipPosition currentParsec nominalValue.
	result <= parsecs ifTrue: [ 
		newShipPosition := self change: aShipPosition using: result ].
	result < 0 ifTrue: [ 
		newShipPosition := self change: aShipPosition withNegativeParsecs: result ].
	result > parsecs ifTrue: [ 
		newShipPosition := self change: aShipPosition withMoreParsecsThanMax: result ].

	^ newShipPosition
]

{ #category : #action }
PositionManager >> updateResult: aResult [

	| auxResult |
	auxResult := aResult.
	[ auxResult > cells ] whileTrue: [ auxResult := auxResult - cells ].

	^ auxResult
]
