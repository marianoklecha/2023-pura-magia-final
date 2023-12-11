Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#instVars : [
		'numberOfCell'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBomb >> applyEffectUsing: aGameBoard for: aShip [

	| ship |
	1 to: aGameBoard amountOfShipsPlaying do: [ :number | 
		ship := aGameBoard shipWith: number.
		(aGameBoard spaceSheriff isKeepingJailed: ship) ifFalse: [ 
			ship changePosition: (self positionAtStartFor: ship) ] ].
	^ self
]

{ #category : #action }
AtomicBomb >> positionAtStartFor: aShip [

	| parsec lap newShipPosition |
	lap := aShip actualPosition currentLap.
	parsec := aShip actualPosition currentParsec.
	^ newShipPosition := ShipPosition createWith: 0 at: lap and: parsec.
]

{ #category : #action }
AtomicBomb >> with: aNumberOfCell [

	numberOfCell := aNumberOfCell
]
