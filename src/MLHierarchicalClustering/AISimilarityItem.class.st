"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #AISimilarityItem,
	#superclass : #AIVectorItem,
	#category : #'MLHierarchicalClustering-Math'
}

{ #category : #'vector functions' }
AISimilarityItem >> dist: anItem [
	
	^1 - (self vector cosine: anItem vector)
]

{ #category : #'distance functions' }
AISimilarityItem >> similarity: anItem [
	
	^self vector cosine: anItem vector
]
