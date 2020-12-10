"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MLDendrogramNode,
	#superclass : #MLDendrogram,
	#instVars : [
		'left',
		'right',
		'threshold'
	],
	#category : #'MLHierarchicalClustering-Dendrogram'
}

{ #category : #'instance creation' }
MLDendrogramNode class >> with: left with: right at: threshold [
	^ self new
		left: left;
		right: right;
		threshold: threshold;
		yourself
]

{ #category : #enumerating }
MLDendrogramNode >> elementsDo: aBlock [
	
	left elementsDo: aBlock.
	right elementsDo: aBlock
]

{ #category : #enumerating }
MLDendrogramNode >> leavesDo: aBlock [
	
	left leavesDo: aBlock.
	right leavesDo: aBlock
]

{ #category : #accessing }
MLDendrogramNode >> left [
	
	^left
]

{ #category : #accessing }
MLDendrogramNode >> left: anObject [
	left := anObject.
	anObject parent: self
]

{ #category : #enumerating }
MLDendrogramNode >> nodesDo: aBlock [
	
	aBlock value: self.
	left nodesDo: aBlock.
	right nodesDo: aBlock
]

{ #category : #seriation }
MLDendrogramNode >> orderLeafs [
	
	| a b c d array |
	a := self left left.
	b := self left right.
	c := self right left.
	d := self right right.
	array := Array
		with: (a dist: c) -> [self left swap]
		with:
			(a dist: d)
				->
					[self left swap.
					self right swap]
		with: (b dist: c) -> []
		with: (b dist: d) -> [self right swap].
		
	(array copy sort: [:el1 :el2 | el1 key < el2 key]) first value value.
	self left orderLeafs.
	self right orderLeafs
]

{ #category : #accessing }
MLDendrogramNode >> right [
	
	^right
]

{ #category : #accessing }
MLDendrogramNode >> right: anObject [
	right := anObject.
	anObject parent: self
]

{ #category : #accessing }
MLDendrogramNode >> size [
	
	^left size + right size
]

{ #category : #seriation }
MLDendrogramNode >> swap [
	
	| swap |
	swap := left.
	left := right.
	right := swap
]

{ #category : #accessing }
MLDendrogramNode >> threshold [
	
	^threshold
]

{ #category : #accessing }
MLDendrogramNode >> threshold: anObject [
	threshold := anObject
]
