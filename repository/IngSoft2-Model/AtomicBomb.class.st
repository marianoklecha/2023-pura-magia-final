Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBomb >> applyTo: aGameBoard for: aShip [

	| newShipPosition ship lap parsec |
	1 to: aGameBoard amountOfShipsPlaying do: [ :index |
		ship := aGameBoard shipWithNumber: index.
		lap := ship shipPosition currentLap.
		parsec := ship shipPosition currentParsec.
		newShipPosition := ShipPosition createWith: 0 at: lap and: parsec.
		ship changePosition: newShipPosition ].
	^self.
]
