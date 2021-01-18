"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #AICorrelationSquare,
	#superclass : #AIDistanceSquare,
	#category : #'AI-HierarchicalClustering-Math'
}

{ #category : #constants }
AICorrelationSquare class >> defaultDistanceBlock [
	
	^[:a :b | a similarity: b]
]

{ #category : #private }
AICorrelationSquare class >> vectorSpecies [
	
	^AICorrelationVector
]

{ #category : #private }
AICorrelationSquare >> copyClusteringData [
	
	^partialColumns collect: [:each | each negated]
]
