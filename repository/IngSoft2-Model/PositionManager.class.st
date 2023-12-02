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
|result position newLap parsec newShipPosition|
	result := aResult. position := 0. newLap := 0. parsec := 0. newShipPosition := nil.

	[ result   > cells ] whileTrue: [ 
		position:=result-cells.
		newLap:= ((aShipPosition currentLap)+1) .
		parsec := aShipPosition currentParsec .
		newShipPosition := ShipPosition createWith: position at: newLap and: parsec .
		result := result - cells ].
	^newShipPosition .
]

{ #category : #'manage action' }
PositionManager >> change: aShipPosition withMoreParsecsThanMax: aResult [ 
	|result position newShipPosition newLap parsecsVar|
	result := aResult. position := 0. newLap := 0. parsecsVar := 0. newShipPosition := nil.
	
	[ result   > parsecs  ] whileTrue: [ 
		position:=aShipPosition currentCell +1.
		newShipPosition := self manageCellsOf: aShipPosition  at: position.
		position := newShipPosition currentCell .
		newLap := newShipPosition currentLap .
		parsecsVar := Parsecs with: (result-parsecs) .
		newShipPosition := ShipPosition createWith: position at: newLap and: parsecsVar  .
		result := result - parsecs ].
	^newShipPosition .
]

{ #category : #'manage action' }
PositionManager >> change: aShipPosition withNegative: aResult [ 
	|newShipPosition result position newLap parsec|
	result := aResult. position := 0. newLap := 0. parsec := 0. newShipPosition := nil.
	
	[ result   < 0 ] whileTrue: [ 
		(aShipPosition currentLap = 1) ifTrue: [ 
				newShipPosition := ShipPosition createNew.
				result :=0 .
			] ifFalse: [  
				position:=cells + result.
				newLap:= ((aShipPosition currentLap)-1) .
				parsec := aShipPosition currentParsec .
				newShipPosition := ShipPosition createWith: position at: newLap and: parsec .
				result := cells + result ] ].
		
		^newShipPosition 
]

{ #category : #'manage action' }
PositionManager >> change: aShipPosition withNegativeParsecs: aResult [ 
	|newShipPosition  result  position newLap parsecsVar |
	result := aResult. position := 0. newLap := 0. parsecsVar := 0. newShipPosition := nil.
	[ result   < 0 ] whileTrue: [ 
		
		position:=aShipPosition currentCell -1.
		newShipPosition := self manageCellsOf: aShipPosition  at: position.
		position := newShipPosition currentCell .
		newLap := newShipPosition currentLap .
		parsecsVar := Parsecs with: (result+parsecs) .
		newShipPosition := ShipPosition createWith: position at: newLap and: parsecsVar .
		result :=result + parsecs . 
		  ].
	^newShipPosition 
]

{ #category : #initialization }
PositionManager >> initializeWith: anAmountOfCells and: anAmountOfParsecs [ 
	cells := anAmountOfCells .
	parsecs := anAmountOfParsecs .
]

{ #category : #'manage move' }
PositionManager >> manageCellsOf: aShipPosition at: newCell [
	|newShipPosition  result playerPosition  newLap parsec|
	result := newCell. newLap := 0. parsec := 0. newShipPosition := nil.
	playerPosition := aShipPosition currentCell .
	
	(result   <= cells) ifTrue: [ 
		newLap:=aShipPosition currentLap.
		parsec := aShipPosition currentParsec .
		newShipPosition := ShipPosition createWith: result  at: newLap and: parsec .] .
	(result < 0 )ifTrue: [
		newShipPosition := self change: aShipPosition withNegative: result].
	(result > cells)ifTrue:[
		newShipPosition := self change: aShipPosition changingLap: result.
		].

	
	^ newShipPosition 

]

{ #category : #'manage move' }
PositionManager >> manageParsecsOf: aShipPosition at: aNewParsec [
|newShipPosition  result  position newLap |
	newLap := 0. newShipPosition := nil. position :=0.
	result := aNewParsec + (aShipPosition currentParsec )nominalValue . 
	(result   <= parsecs ) ifTrue: [ 
		newLap:=aShipPosition currentLap.
		position := aShipPosition currentCell . 
		newShipPosition := ShipPosition createWith: position   at: newLap and: (Parsecs with: aNewParsec)   .] .
	(result <0)ifTrue:[
		newShipPosition := self change: aShipPosition  withNegativeParsecs: result  .
		].
	(result   > parsecs) ifTrue:[
		newShipPosition := self change: aShipPosition  withMoreParsecsThanMax: result  .
		].
	
	^ newShipPosition 
]

{ #category : #action }
PositionManager >> updateResult: aResult [
	|auxResult|
	auxResult := aResult.
	[ auxResult  > cells ] whileTrue: [ 
		auxResult := auxResult - cells . 
	 ].

	^ auxResult .
]
