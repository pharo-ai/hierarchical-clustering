"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MLTimeWarpingEngine,
	#superclass : #Object,
	#instVars : [
		'vectorA',
		'vectorB',
		'distanceBlock'
	],
	#category : #'MLHierarchicalClustering-Core'
}

{ #category : #accessing }
MLTimeWarpingEngine >> distanceBlock [
	
	^distanceBlock
]

{ #category : #accessing }
MLTimeWarpingEngine >> distanceBlock: anObject [
	
	distanceBlock := anObject
]

{ #category : #accessing }
MLTimeWarpingEngine >> getCost [
	
	^self getCostMatrix last
]

{ #category : #private }
MLTimeWarpingEngine >> getCostMatrix [
	| cost matrix |
	matrix := MLDistanceSquare on: vectorA and: vectorB using: self distanceBlock.
	cost := MLArrayMatrix new: matrix dimension.
	cost at: 1 and: 1 put: (matrix at: 1 and: 1).
	2 to: cost rowSize do: [ :x | cost at: x and: 1 put: (cost at: x - 1 and: 1) + (matrix at: x and: 1) ].
	2 to: cost columnSize do: [ :y | cost at: 1 and: y put: (cost at: 1 and: y - 1) + (matrix at: 1 and: y) ].
	2 to: cost rowSize do: [ :x | 
		2 to: cost columnSize do: [ :y | 
			cost
				at: x
				and: y
				put:
					(matrix at: x and: y) +
						((cost at: x - 1 and: y - 1) min: ((cost at: x and: y - 1) min: (cost at: x - 1 and: y))) ] ].
	^ cost
]

{ #category : #accessing }
MLTimeWarpingEngine >> vectorA [
	
	^vectorA
]

{ #category : #accessing }
MLTimeWarpingEngine >> vectorA: anObject [
	
	vectorA := anObject
]

{ #category : #accessing }
MLTimeWarpingEngine >> vectorB [
	
	^vectorB
]

{ #category : #accessing }
MLTimeWarpingEngine >> vectorB: anObject [
	
	vectorB := anObject
]
