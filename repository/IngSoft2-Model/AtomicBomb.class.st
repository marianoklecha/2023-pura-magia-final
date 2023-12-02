Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBomb >> applyTo: aGameBoard for: aShip [

	| ship |
	1 to: aGameBoard amountOfShipsPlaying do: [ :number | 
		ship := aGameBoard shipWith: number.
		self positionAtStartFor: ship ].
	^ self
]

{ #category : #action }
AtomicBomb >> positionAtStartFor: aShip [

	| parsec lap newShipPosition |
	lap := aShip actualPosition currentLap.
	parsec := aShip actualPosition currentParsec.
	newShipPosition := ShipPosition createWith: 0 at: lap and: parsec.
	aShip changePosition: newShipPosition
]
