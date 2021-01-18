"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #AIClusterEngineTest,
	#superclass : #TestCase,
	#category : #'AI-HierarchicalClustering-Tests'
}

{ #category : #testing }
AIClusterEngineTest >> testCentroid [
	| input clusty clusters |
	input := #(#(1 2 3 5) #(11 12 15) #(21 22 23 25) #(31 32 35) #(41 42 43 45 47)).
	clusty := MLClusterEngine with: input flatten shuffle.
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
	clusty := MLClusterEngine with: input flatten shuffle.
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
AIClusterEngineTest >> testClustering2 [
	| input clusty clusters |
	input := #(#(1 2 3 5) #(11 12 15) #(21 22 23 25) #(31 32 35) #(41 42 43 45 47)).
	clusty := MLClusterEngine with: input flatten shuffle.
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
AIClusterEngineTest >> testClustering300Elements [
	
	| input clusty clusters |
	input := Random new next: 300.
	clusty := MLClusterEngine with: input.
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
	expected := MLDendrogramNode
		with: (MLDendrogramNode
			with: (MLDendrogramNode
				with: (MLDendrogramLeaf with: 3)
				with: (MLDendrogramLeaf with: 2)
				at: 1)
			with: (MLDendrogramLeaf with: 1)
			at: 1.5) 
		with: (MLDendrogramNode
			with: (MLDendrogramNode
				with: (MLDendrogramLeaf with: 11)
				with: (MLDendrogramLeaf with: 12)
				at: 1)
			with: (MLDendrogramLeaf with: 15)
			at: 3.5) 
		at: 10.666666666666664.
	
	clusty := MLClusterEngine with: input.
	
	self assert: clusty dendrogram equals: expected
]

{ #category : #test }
AIClusterEngineTest >> testDistanceMatrix [

	| input clusty |
	input := 	#(3 11 2 15 1 12).
	clusty := MLClusterEngine new distanceMatrix: (MLDistanceSquare on: input).
	self assert: (clusty distanceMatrix isKindOf: MLDistanceSquare)
]

{ #category : #test }
AIClusterEngineTest >> testItems [

	| input clusty |
	input := 	#(3 11 2 15 1 12).
	clusty := MLClusterEngine new distanceMatrix: (MLDistanceSquare on: input).
	self assert: clusty items equals: input.
]

{ #category : #testing }
AIClusterEngineTest >> testSeriationEngine [
	
	| input output |
	input := #(1 2 3 5 11 12 15 21 22 23 25 31 32 35 41 42 43 45 47).
	output := MLSeriationEngine applyOn: input copy asArray shuffle.
	self assert: output = input | (output reverse = input)
]

{ #category : #testing }
AIClusterEngineTest >> testWardsMethod [
	| input clusty clusters |
	input := #(#(1 2 3 5) #(11 12 15) #(21 22 23 25) #(31 32 35) #(41 42 43 45 47)).
	clusty := MLClusterEngine with: input flatten shuffle.
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
