"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #AISeriationEngine,
	#superclass : #Object,
	#instVars : [
		'elements'
	],
	#category : #'AI-HierarchicalClustering-Core'
}

{ #category : #'instance creation' }
AISeriationEngine class >> applyOn: elements [
	
	^(self with: elements) defaultAlgorithm
]

{ #category : #'instance creation' }
AISeriationEngine class >> with: elements [
	
	^(self new)
		elements: elements;
		yourself
]

{ #category : #algorithm }
AISeriationEngine >> defaultAlgorithm [
	
	^self orderDendrogramLeaves
]

{ #category : #accessing }
AISeriationEngine >> elements [
	
	^elements
]

{ #category : #accessing }
AISeriationEngine >> elements: anObject [
	
	elements := anObject
]

{ #category : #algorithm }
AISeriationEngine >> orderDendrogramLeaves [
	
	| clusty |
	clusty := AIClusterEngine with: elements.
	clusty hierarchicalClusteringUsing: #averageLinkage.
	^clusty dendrogram orderLeafs asArray
]
