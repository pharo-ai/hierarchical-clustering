"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #AIClusterEngineTest,
	#superclass : #TestCase,
	#category : #'AI-HierarchicalClustering-Tests-Core'
}

{ #category : #testing }
AIClusterEngineTest >> testCentroid [
	| input clusty clusters |
	input := #(#(1 2 3 5) #(11 12 15) #(21 22 23 25) #(31 32 35) #(41 42 43 45 47)).
	clusty := AIClusterEngine with: input flatten shuffle.
	clusty hierarchicalClusteringUsing: #centroid.
	clusters := clusty dendrogram breakInto: 5.
	self assert: clusters size equals: 5.
	self assert: (clusters anySatisfy: [ :each | each equalsTo: (input at: 1) ]).
	self assert: (clusters anySatisfy: [ :each | each equalsTo: (input at: 2) ]).
	self assert: (clusters anySatisfy: [ :each | each equalsTo: (input at: 3) ]).
	self assert: (clusters anySatisfy: [ :each | each equalsTo: (input at: 4) ]).
	self assert: (clusters anySatisfy: [ :each | each equalsTo: (input at: 5) ]).
	^ clusters
]

{ #category : #testing }
AIClusterEngineTest >> testClustering [
	| input clusty clusters |
	input := #(#(1 2 3 5) #(11 12 15) #(21 22 23 25) #(31 32 35) #(41 42 43 45 47)).
	clusty := AIClusterEngine with: input flatten shuffle.
	clusty hierarchicalClusteringUsing: #averageLinkage.
	clusters := clusty dendrogram breakInto: 5.
	self assert: clusters size equals: 5.
	self assert: (clusters anySatisfy: [ :each | each equalsTo: (input at: 1) ]).
	self assert: (clusters anySatisfy: [ :each | each equalsTo: (input at: 2) ]).
	self assert: (clusters anySatisfy: [ :each | each equalsTo: (input at: 3) ]).
	self assert: (clusters anySatisfy: [ :each | each equalsTo: (input at: 4) ]).
	self assert: (clusters anySatisfy: [ :each | each equalsTo: (input at: 5) ]).
	^ clusters
]

{ #category : #testing }
AIClusterEngineTest >> testClustering300Elements [
	
	| input clusty clusters |
	input := Random new next: 300.
	clusty := AIClusterEngine with: input.
	1
		to: 1
		do: [:n | clusty averageLinkage].
	clusters := clusty dendrogram breakInto: 10.
	^clusters
]

{ #category : #test }
AIClusterEngineTest >> testDendrogram [

	| input clusty expected |
	
	input := 	#(3 11 2 15 1 12).
	expected := AIDendrogramNode
		with: (AIDendrogramNode
			with: (AIDendrogramNode
				with: (AIDendrogramLeaf with: 3)
				with: (AIDendrogramLeaf with: 2)
				at: 1)
			with: (AIDendrogramLeaf with: 1)
			at: 1.5) 
		with: (AIDendrogramNode
			with: (AIDendrogramNode
				with: (AIDendrogramLeaf with: 11)
				with: (AIDendrogramLeaf with: 12)
				at: 1)
			with: (AIDendrogramLeaf with: 15)
			at: 3.5) 
		at: 10.666666666666664.
	
	clusty := AIClusterEngine with: input.
	
	self assert: clusty dendrogram equals: expected
]

{ #category : #test }
AIClusterEngineTest >> testDistanceMatrix [

	| input clusty |
	input := 	#(3 11 2 15 1 12).
	clusty := AIClusterEngine new distanceMatrix: (AIDistanceSquare on: input).
	self assert: (clusty distanceMatrix isKindOf: AIDistanceSquare)
]

{ #category : #test }
AIClusterEngineTest >> testItems [

	| input clusty |
	input := 	#(3 11 2 15 1 12).
	clusty := AIClusterEngine new distanceMatrix: (AIDistanceSquare on: input).
	self assert: clusty items equals: input.
]

{ #category : #testing }
AIClusterEngineTest >> testSeriationEngine [
	
	| input output |
	input := #(1 2 3 5 11 12 15 21 22 23 25 31 32 35 41 42 43 45 47).
	output := AISeriationEngine applyOn: input copy asArray shuffle.
	self assert: output = input | (output reverse = input)
]

{ #category : #testing }
AIClusterEngineTest >> testWardsMethod [
	| input clusty clusters |
	input := #(#(1 2 3 5) #(11 12 15) #(21 22 23 25) #(31 32 35) #(41 42 43 45 47)).
	clusty := AIClusterEngine with: input flatten shuffle.
	clusty hierarchicalClusteringUsing: #wardsMethod.
	clusters := clusty dendrogram breakInto: 5.
	self assert: clusters size equals: 5.
	self assert: (clusters anySatisfy: [ :each | each equalsTo: (input at: 1) ]).
	self assert: (clusters anySatisfy: [ :each | each equalsTo: (input at: 2) ]).
	self assert: (clusters anySatisfy: [ :each | each equalsTo: (input at: 3) ]).
	self assert: (clusters anySatisfy: [ :each | each equalsTo: (input at: 4) ]).
	self assert: (clusters anySatisfy: [ :each | each equalsTo: (input at: 5) ]).
	^ clusters
]
