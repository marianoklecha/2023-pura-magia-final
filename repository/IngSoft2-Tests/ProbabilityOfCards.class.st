Class {
	#name : #ProbabilityOfCards,
	#superclass : #Object,
	#instVars : [
		'totalOverloads',
		'totalSpeeds',
		'totalAccelerations',
		'totalCancellations',
		'totalRedos',
		'totalRepeats',
		'totalReverses',
		'totalSkips',
		'totalDoubles',
		'totalFreedoms',
		'totalCells',
		'amountOfCards'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #action }
ProbabilityOfCards class >> createNew [
	^(self new) initializeNew.
]

{ #category : #action }
ProbabilityOfCards >> addTotalAmountOfCells [

	|arrayWithTemporalVariables|
	arrayWithTemporalVariables := OrderedCollection new.
	arrayWithTemporalVariables add: totalOverloads ; add: totalSpeeds 
	; add: totalAccelerations ; add: totalCancellations ; add: totalRedos 
	; add: totalRepeats ; add: totalReverses ; add: totalSkips ;
	add: totalDoubles  ; add: totalFreedoms; add: totalCells.
	^arrayWithTemporalVariables
]

{ #category : #action }
ProbabilityOfCards >> amountOf: typeOfCard on: aShip [

	| count |
	count := 0.
	1 to: amountOfCards do: [ :index | 
		(((aShip shipCards cardsInHand) at: index) isKindOf: typeOfCard) ifTrue: [ 
			count := count + 1 ] ].

	^ count
]

{ #category : #action }
ProbabilityOfCards >> averageProbabilities: aCollectionOfTemporalVariables [ 
	
	| finalAverages sizeOfCollection total numberWithDecimals |
	finalAverages := OrderedCollection new.
	sizeOfCollection := aCollectionOfTemporalVariables size.

	1 to: sizeOfCollection - 1 do: [ :index | 
		numberWithDecimals := (aCollectionOfTemporalVariables at: index) / (aCollectionOfTemporalVariables at: sizeOfCollection).
		total := (numberWithDecimals * 100) asFloat.
		finalAverages add: total ].
	^ finalAverages
]

{ #category : #action }
ProbabilityOfCards >> calculateProbabilities: arrayOfEffectsProbabilities [

	|ships arrayWithTemporalVariables |
	ships := self createArrayOfShips: arrayOfEffectsProbabilities.
	ships do: [ :each | self countAmountOfCellsOf: each ].
	arrayWithTemporalVariables := self addTotalAmountOfCells.
	^ self averageProbabilities: arrayWithTemporalVariables .
]

{ #category : #action }
ProbabilityOfCards >> countAmountOfCellsOf: aShip [

	totalOverloads := totalOverloads + (self amountOf: Overload on: aShip).
	totalSpeeds := totalSpeeds + (self amountOf: Speed on: aShip). 
	totalAccelerations := totalAccelerations + (self amountOf: Acceleration on: aShip). 
	totalCancellations := totalCancellations + (self amountOf: Cancellation on: aShip). 
	totalRedos := totalRedos + (self amountOf: Redo on: aShip).
	totalRepeats := totalRepeats + (self amountOf: Repeat on: aShip).
	totalReverses := totalReverses + (self amountOf: Reverse on: aShip).
	totalSkips:= totalSkips + (self amountOf: Skip on: aShip).
	totalDoubles := totalDoubles + (self amountOf: Double on: aShip).
	totalFreedoms := totalFreedoms + (self amountOf: Freedom on: aShip).
	totalCells := totalCells + amountOfCards.
]

{ #category : #action }
ProbabilityOfCards >> createArrayOfShips: aCollection [

	| array ship deck|
	deck := Deck new.
	array := OrderedCollection new.
	1 to: 5000 do: [ :index |
		ship := Ship with: index.
		1 to: amountOfCards do: [ :number | ship add: (deck giveCard) ].
		array add: ship ].
	^ array
]

{ #category : #action }
ProbabilityOfCards >> initializeNew [

	totalOverloads := 0.
	totalSpeeds := 0. 
	totalAccelerations := 0. 
	totalCancellations := 0. 
	totalRedos := 0.
	totalRepeats := 0.
	totalReverses := 0.
	totalSkips:= 0.
	totalDoubles := 0.
	totalFreedoms := 0.
	totalCells := 0.
	amountOfCards := 500.
]
