"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MLSeriationEngine,
	#superclass : #Object,
	#instVars : [
		'elements'
	],
	#category : #MLHierarchicalClustering
}

{ #category : #'instance creation' }
MLSeriationEngine class >> applyOn: elements [
	
	^(self with: elements) defaultAlgorithm
]

{ #category : #'instance creation' }
MLSeriationEngine class >> with: elements [
	
	^(self new)
		elements: elements;
		yourself
]

{ #category : #algorithm }
MLSeriationEngine >> defaultAlgorithm [
	
	^self orderDendrogramLeaves
]

{ #category : #accessing }
MLSeriationEngine >> elements [
	
	^elements
]

{ #category : #accessing }
MLSeriationEngine >> elements: anObject [
	
	elements := anObject
]

{ #category : #algorithm }
MLSeriationEngine >> orderDendrogramLeaves [
	
	| clusty |
	clusty := MLClusterEngine with: elements.
	clusty hierarchicalClusteringUsing: #averageLinkage.
	^clusty dendrogram orderLeafs asArray
]
