"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #AISimilarityItemTest,
	#superclass : #TestCase,
	#category : #'AI-HierarchicalClustering-Tests-Core'
}

{ #category : #'As yet unclassified' }
AISimilarityItemTest >> testDistance [
	| a b c elements engine clusters |
	a := AIVectorItem with: #a and: #(1 0).
	b := AIVectorItem with: #b and: #(0 1).
	c := AIVectorItem with: #c and: #(0 7).
	elements := Array with: a with: b with: c.
	engine := AIClusterEngine with: elements.
	engine hierarchicalClusteringUsing: #averageLinkage.
	clusters := engine dendrogram breakInto: 2.
	self assert: clusters size equals: 2.
	self assert: (clusters select: [ :each | each size = 1 ]) size equals: 1.
	self assert: (clusters select: [ :each | each size = 2 ]) size equals: 1.
	self assert: ((clusters select: [ :each | each size = 1 ]) first includes: c).
	self assert: ((clusters select: [ :each | each size = 2 ]) first includes: a).
	self assert: ((clusters select: [ :each | each size = 2 ]) first includes: b)
]

{ #category : #'As yet unclassified' }
AISimilarityItemTest >> testSimilarity [
	| a b c elements engine clusters |
	a := AISimilarityItem with: #a and: #(1 0).
	b := AISimilarityItem with: #b and: #(0 1).
	c := AISimilarityItem with: #c and: #(0 7).
	elements := Array with: a with: b with: c.
	engine := AIClusterEngine with: elements.
	engine hierarchicalClusteringUsing: #averageLinkage.
	clusters := engine dendrogram breakInto: 2.
	self assert: clusters size equals: 2.
	self assert: (clusters select: [ :each | each size = 1 ]) size equals: 1.
	self assert: (clusters select: [ :each | each size = 2 ]) size equals: 1.
	self assert: ((clusters select: [ :each | each size = 1 ]) first includes: a).
	self assert: ((clusters select: [ :each | each size = 2 ]) first includes: b).
	self assert: ((clusters select: [ :each | each size = 2 ]) first includes: c)
]
