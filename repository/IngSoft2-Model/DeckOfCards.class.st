Class {
	#name : #DeckOfCards,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #creating }
DeckOfCards >> designateRandomCardTo: aNumberOfShip from: aGameBoard [ 
	|probabilities randomNumber|
	probabilities := #(0 10 20 30 40 50 60) .
		
		randomNumber:= 60 atRandom.
		
		( randomNumber >= (probabilities  at: 1) and: randomNumber < (probabilities at: 2)) ifTrue: [
			aGameBoard add: (Overload new) to: aNumberOfShip.
		 ].
	 (randomNumber >= (probabilities  at: 2) and: randomNumber < (probabilities at: 3)) ifTrue: [ 
			aGameBoard add: (Speed new) to: aNumberOfShip.
		 ].
	 (randomNumber >= (probabilities  at: 3) and: randomNumber < (probabilities at: 4)) ifTrue: [ 
			aGameBoard add: (Cancellation new) to: aNumberOfShip.
		 ].
	 (randomNumber >= (probabilities  at: 4) and: randomNumber < (probabilities at: 5)) ifTrue: [ 
			aGameBoard add: (Redo new) to: aNumberOfShip.
		 ].
	(randomNumber >= (probabilities  at: 5) and: randomNumber < (probabilities at: 6)) ifTrue: [ 
			aGameBoard add: (Acceleration new) to: aNumberOfShip. 
		 ].
	(randomNumber >= (probabilities  at: 6) and: randomNumber <= (probabilities at: 7)) ifTrue: [ 
			aGameBoard add: (Repeat new) to: aNumberOfShip. 
		 ].
]
