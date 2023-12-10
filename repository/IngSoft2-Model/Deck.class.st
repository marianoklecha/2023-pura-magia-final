Class {
	#name : #Deck,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Deck >> giveCard [
	|probabilities randomNumber|
	probabilities := #(0 10 20 30 40 50 60 70) .
	randomNumber:= 70 atRandom.
	( randomNumber >= (probabilities  at: 1) and: randomNumber < (probabilities at: 2))
		ifTrue: [^(Overload new) ].
	(randomNumber >= (probabilities  at: 2) and: randomNumber < (probabilities at: 3))
		ifTrue: [ ^(Speed new) ].
	(randomNumber >= (probabilities  at: 3) and: randomNumber < (probabilities at: 4))
		ifTrue: [ ^(Cancellation new) ].
	(randomNumber >= (probabilities  at: 4) and: randomNumber < (probabilities at: 5))
		ifTrue: [ ^(Redo new) ].
	(randomNumber >= (probabilities  at: 5) and: randomNumber < (probabilities at: 6))
		ifTrue: [ ^(Acceleration new)].
	(randomNumber >= (probabilities  at: 6) and: randomNumber <= (probabilities at: 7))
		ifTrue: [ ^(Repeat new) ].
	(randomNumber >= (probabilities  at: 7) and: randomNumber <= (probabilities at: 8))
		ifTrue: [ ^(Freedom new)].
]
