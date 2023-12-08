Class {
	#name : #ProbabilityOfEffects,
	#superclass : #Object,
	#instVars : [
		'amountOfCells'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
ProbabilityOfEffects class >> with: aNumber [ 
	^(self new) initializeWith: aNumber.
]

{ #category : #action }
ProbabilityOfEffects >> amountOf: typeOfSpecialEffect on: aGameBoard [ 
	
	| count |
	count := 0.
	1 to: 100 do: [ :aNumberOfCell | 
		((aGameBoard specialEffectAtCell: aNumberOfCell) isKindOf: typeOfSpecialEffect) ifTrue: [ 
			count := count + 1 ] ].

	^ count
]

{ #category : #calculating }
ProbabilityOfEffects >> averageProbabilities: aCollectionOfTemporalVariables [

	| finalAverages sizeOfCollection total numberWithDecimals |
	finalAverages := OrderedCollection new.
	sizeOfCollection := aCollectionOfTemporalVariables size.

	1 to: sizeOfCollection - 1 do: [ :index | 
		numberWithDecimals := (aCollectionOfTemporalVariables at: index) / (aCollectionOfTemporalVariables at: sizeOfCollection).
		total := (numberWithDecimals * 100) asFloat.
		finalAverages add: total ].

	^ finalAverages
]

{ #category : #calculating }
ProbabilityOfEffects >> calculate: arrayOfEffectsProbabilities forHyperJump: aCollectionOfDifferentParsecs [ 
	|gameboards totalWormHoles totalSpeedUps totalMoonWalks totalHyperJumps totalAtomicBombs totalEmptyCells totalCells finalArray arrayWithTemporalVariables totalSpecialCardsCells|
	gameboards := self createArrayOfGameBoards: arrayOfEffectsProbabilities forHyperJump: aCollectionOfDifferentParsecs .
	
		totalWormHoles := 0.
		totalSpeedUps := 0. 
		totalMoonWalks := 0. 
		totalHyperJumps := 0. 
		totalAtomicBombs := 0. 
		totalEmptyCells := 0.
		totalSpecialCardsCells := 0.
		totalCells:= 0.
		
	   gameboards do: [ :each | 
		totalWormHoles := totalWormHoles + (self amountOf: WormHole on: each).
		totalSpeedUps := totalSpeedUps + (self amountOf: SpeedUp on: each). 
		totalMoonWalks := totalMoonWalks + (self amountOf: MoonWalk on: each). 
		totalHyperJumps := totalHyperJumps + (self amountOf: HyperJump on: each). 
		totalAtomicBombs := totalAtomicBombs + (self amountOf: AtomicBomb on: each).
		totalSpecialCardsCells := totalSpecialCardsCells + (self amountOf: CardAssignation on: each).
		totalEmptyCells := totalEmptyCells + (self amountOf: NullEffect on: each).
		
		
		totalCells:= amountOfCells + totalCells.].
		
	
	arrayWithTemporalVariables := OrderedCollection new.
	arrayWithTemporalVariables add: totalEmptyCells.
	arrayWithTemporalVariables add: totalWormHoles.
	arrayWithTemporalVariables add: totalSpeedUps.
	arrayWithTemporalVariables add: totalMoonWalks.
	arrayWithTemporalVariables add: totalHyperJumps.
	arrayWithTemporalVariables add: totalAtomicBombs.
	arrayWithTemporalVariables add: totalSpecialCardsCells.
	arrayWithTemporalVariables add: totalCells.
	
	
	finalArray := self averageProbabilities: arrayWithTemporalVariables .
	
	^ finalArray
]

{ #category : #creation }
ProbabilityOfEffects >> createArrayOfGameBoards: arrayOfEffectsProbabilites forHyperJump: aCollectionOfDifferentParsecs [

	| array |
	array := OrderedCollection new.
	1 to: 5000 do: [ :index | 
		array add: ((GameBoard with: 100 and: 1) addEffectsUsing: arrayOfEffectsProbabilites
		andForHyperJump: aCollectionOfDifferentParsecs) ].

	^ array
]

{ #category : #creation }
ProbabilityOfEffects >> createCollectionFrom: aCollection [

	| newCollection |
	newCollection := OrderedCollection new.
	newCollection add: (aCollection at: 1).
	2 to: aCollection size do: [ :index | 
		newCollection add:
			(newCollection at: index - 1) + (aCollection at: index) ].


	^ newCollection
]

{ #category : #creation }
ProbabilityOfEffects >> initializeWith: aNumber [ 
	amountOfCells := aNumber
]
