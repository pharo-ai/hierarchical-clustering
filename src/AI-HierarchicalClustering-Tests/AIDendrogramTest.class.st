"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #AIDendrogramTest,
	#superclass : #TestCase,
	#instVars : [
		'dendrogram'
	],
	#category : #'AI-HierarchicalClustering-Tests-Core'
}

{ #category : #running }
AIDendrogramTest >> setUp [
	| ab cd ef abcd efg |
	super setUp.
	ab := (AIDendrogram with: #a) merge: (AIDendrogram with: #b) at: 1.
	cd := (AIDendrogram with: #c) merge: (AIDendrogram with: #d) at: 2.
	ef := (AIDendrogram with: #e) merge: (AIDendrogram with: #f) at: 3.
	abcd := ab merge: cd at: 4.
	efg := ef merge: (AIDendrogram with: #g) at: 5.
	dendrogram := abcd merge: efg at: 7	"#(((a 1 b) 4 (c 2 d)) 7 ((e 3 f) 5 g))"
]

{ #category : #test }
AIDendrogramTest >> testAllLeaves [
	self assert: dendrogram elements size equals: 7.
	self assert: dendrogram elements equals: #(#a #b #c #d #e #f #g)
]

{ #category : #test }
AIDendrogramTest >> testIndex [
	self assert: dendrogram index equals: 1.
	self assert: dendrogram left index equals: 1.
	self assert: dendrogram right index equals: 5.
	self assert: dendrogram left left index equals: 1.
	self assert: dendrogram left right index equals: 3.
	self assert: dendrogram right left index equals: 5.
	self assert: dendrogram right right index equals: 7
]

{ #category : #test }
AIDendrogramTest >> testSize [
	self assert: dendrogram size equals: 7.
	self assert: dendrogram left size equals: 4.
	self assert: dendrogram right size equals: 3.
	self assert: dendrogram left left size equals: 2.
	self assert: dendrogram left right size equals: 2.
	self assert: dendrogram right left size equals: 2.
	self assert: dendrogram right right size equals: 1
]
