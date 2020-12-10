"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MLSimilarityItem,
	#superclass : #MLVectorItem,
	#category : #'MLHierarchicalClustering-Math'
}

{ #category : #'vector functions' }
MLSimilarityItem >> dist: anItem [
	
	^1 - (self vector cosine: anItem vector)
]

{ #category : #'distance functions' }
MLSimilarityItem >> similarity: anItem [
	
	^self vector cosine: anItem vector
]
