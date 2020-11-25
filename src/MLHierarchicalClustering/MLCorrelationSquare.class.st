"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MLCorrelationSquare,
	#superclass : #MLDistanceSquare,
	#category : #MLHierarchicalClustering
}

{ #category : #constants }
MLCorrelationSquare class >> defaultDistanceBlock [
	
	^[:a :b | a similarity: b]
]

{ #category : #private }
MLCorrelationSquare class >> vectorSpecies [
	
	^MLCorrelationVector
]

{ #category : #private }
MLCorrelationSquare >> copyClusteringData [
	
	^partialColumns collect: [:each | each negated]
]
