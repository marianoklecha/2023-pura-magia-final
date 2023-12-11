Class {
	#name : #ProbabilityTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ProbabilityTests >> test001CheckDistributionOfEffectsIn5000GameboardsWithHyperJumpArrays [
| parsecs aProbability effectsProbabilities amountOfParsecsToMove collection1 parsc1 light1 parsc2 light2 |

parsecs := 4. 
aProbability := ProbabilityOfEffects with: 100.
parsc1 := Parsecs with: 7.
light1 := LightYears with: 9.
parsc2 := Parsecs with: 2.
light2 := LightYears with: 3.
amountOfParsecsToMove:= OrderedCollection new.
collection1:=OrderedCollection new.
collection1 add: parsc1 .
collection1 add: light1  .
collection1 add: parsc2   .
collection1 add: light2  .
amountOfParsecsToMove add: collection1 .
effectsProbabilities := aProbability calculate: #(40 20 20 10 8 2 0) forHyperJump: amountOfParsecsToMove.

self assert: ((effectsProbabilities at: 1) >39  and: (effectsProbabilities at: 1) < 40) .
self assert: ((effectsProbabilities at: 2) >19  and: (effectsProbabilities at: 2) < 21) .
self assert: ((effectsProbabilities at: 3) >19  and: (effectsProbabilities at: 3) < 21) .
self assert: ((effectsProbabilities at: 4) >9  and: (effectsProbabilities at: 4) < 11) .
self assert: ((effectsProbabilities at: 5) >7  and: (effectsProbabilities at: 5) < 9) .
self assert: ((effectsProbabilities at: 6) >1  and: (effectsProbabilities at: 6) < 3) .





  
]

{ #category : #tests }
ProbabilityTests >> test002CheckDifferentDistributionOfEffectsIn5000GameboardsWithHyperJumpArrays [
| parsecs aProbability effectsProbabilities parsc1 light1 parsc2 light2 amountOfParsecsToMove collection1 |

parsecs := 4. 
aProbability := ProbabilityOfEffects with: 100.
parsc1 := Parsecs with: 7.
light1 := LightYears with: 9.
parsc2 := Parsecs with: 2.
light2 := LightYears with: 3.
amountOfParsecsToMove:= OrderedCollection new.
collection1:=OrderedCollection new.
collection1 add: parsc1 .
collection1 add: light1  .
collection1 add: parsc2   .
collection1 add: light2  .
amountOfParsecsToMove add: collection1 .
effectsProbabilities := aProbability calculate: #(40 30 10 10 10 0 0) forHyperJump: amountOfParsecsToMove.

self assert: ((effectsProbabilities at: 1) >39  and: (effectsProbabilities at: 1) < 41) .
self assert: ((effectsProbabilities at: 2) >29  and: (effectsProbabilities at: 2) < 31) .
self assert: ((effectsProbabilities at: 3) >9  and: (effectsProbabilities at: 3) < 11) .
self assert: ((effectsProbabilities at: 4) >9  and: (effectsProbabilities at: 4) < 11) .
self assert: ((effectsProbabilities at: 5) >9  and: (effectsProbabilities at: 5) < 11) .
self assert: ((effectsProbabilities at: 6) >(-1)  and: (effectsProbabilities at: 6) < 1) .





  
]

{ #category : #tests }
ProbabilityTests >> test003CheckDifferentDistributionOfEffectsIn5000GameboardsWithCardAssignationCell [
| parsecs aProbability effectsProbabilities parsc1 light1 parsc2 light2 amountOfParsecsToMove collection1 |

parsecs := 4. 
aProbability := ProbabilityOfEffects with: 100.
parsc1 := Parsecs with: 7.
light1 := LightYears with: 9.
parsc2 := Parsecs with: 2.
light2 := LightYears with: 3.
amountOfParsecsToMove:= OrderedCollection new.
collection1:=OrderedCollection new.
collection1 add: parsc1 .
collection1 add: light1  .
collection1 add: parsc2   .
collection1 add: light2  .
amountOfParsecsToMove add: collection1 .

effectsProbabilities := aProbability calculate: #(30 20 20 10 8 2 10) forHyperJump: amountOfParsecsToMove.

self assert: ((effectsProbabilities at: 1) >29  and: (effectsProbabilities at: 1) < 31) .
self assert: ((effectsProbabilities at: 2) >19  and: (effectsProbabilities at: 2) < 21) .
self assert: ((effectsProbabilities at: 3) >19  and: (effectsProbabilities at: 3) < 21) .
self assert: ((effectsProbabilities at: 4) >9  and: (effectsProbabilities at: 4) < 11) .
self assert: ((effectsProbabilities at: 5) >7  and: (effectsProbabilities at: 5) < 9) .
self assert: ((effectsProbabilities at: 6) >1  and: (effectsProbabilities at: 6) < 3) .
self assert: ((effectsProbabilities at: 7) >9  and: (effectsProbabilities at: 7) < 11) .





  
]

{ #category : #tests }
ProbabilityTests >> test004CheckDistributionOfCardsIn5000Ships [
| aProbability effectsProbabilities min max|

min := 7.8.
max := 11.2.
aProbability := ProbabilityOfCards createNew.
effectsProbabilities := aProbability calculateProbabilities: #(0 10 20 30 40 50 60 70 80 90 100).

self assert: ((effectsProbabilities at: 1) >min  and: (effectsProbabilities at: 1) < max) .
self assert: ((effectsProbabilities at: 2) >min  and: (effectsProbabilities at: 2) < max) .
self assert: ((effectsProbabilities at: 3) >min and: (effectsProbabilities at: 3) < max) .
self assert: ((effectsProbabilities at: 4) >min and: (effectsProbabilities at: 4) < max) .
self assert: ((effectsProbabilities at: 5) >min  and: (effectsProbabilities at: 5) < max) .
self assert: ((effectsProbabilities at: 6) >min  and: (effectsProbabilities at: 6) < max) .
self assert: ((effectsProbabilities at: 7) >min  and: (effectsProbabilities at: 7) < max) .
self assert: ((effectsProbabilities at: 8) >min  and: (effectsProbabilities at: 8) < max) .
self assert: ((effectsProbabilities at: 9) >min  and: (effectsProbabilities at: 9) < max) .
self assert: ((effectsProbabilities at: 10) >min  and: (effectsProbabilities at: 10) < max) .





  
]
