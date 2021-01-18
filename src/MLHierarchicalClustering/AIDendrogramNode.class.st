"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #AIDendrogramNode,
	#superclass : #AIDendrogram,
	#instVars : [
		'left',
		'right',
		'threshold'
	],
	#category : #'MLHierarchicalClustering-Dendrogram'
}

{ #category : #'instance creation' }
AIDendrogramNode class >> with: left with: right at: threshold [

	^ self new
		left: left;
		right: right;
		threshold: threshold;
		yourself
]

{ #category : #comparing }
AIDendrogramNode >> = aMLDendrogram [

	self == aMLDendrogram
		ifTrue: [ ^ true ].
	self class = aMLDendrogram class
		ifFalse: [ ^ false ].
	^ self left = aMLDendrogram left
		and: [ self right = aMLDendrogram right
		 and: [ self threshold = aMLDendrogram threshold ] ]
]

{ #category : #enumerating }
AIDendrogramNode >> elementsDo: aBlock [
	
	left elementsDo: aBlock.
	right elementsDo: aBlock
]

{ #category : #comparing }
AIDendrogramNode >> hash [ 
	"#hash is implemented, because #= is implemented"

	^ self left hash bitXor: (self right hash bitXor: self threshold hash)
]

{ #category : #testing }
AIDendrogramNode >> isNode [

	^ true
]

{ #category : #enumerating }
AIDendrogramNode >> leavesDo: aBlock [
	
	left leavesDo: aBlock.
	right leavesDo: aBlock
]

{ #category : #accessing }
AIDendrogramNode >> left [
	
	^left
]

{ #category : #accessing }
AIDendrogramNode >> left: anObject [
	left := anObject.
	anObject parent: self
]

{ #category : #enumerating }
AIDendrogramNode >> nodesDo: aBlock [
	
	aBlock value: self.
	left nodesDo: aBlock.
	right nodesDo: aBlock
]

{ #category : #seriation }
AIDendrogramNode >> orderLeafs [
	
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
AIDendrogramNode >> right [
	
	^right
]

{ #category : #accessing }
AIDendrogramNode >> right: anObject [
	right := anObject.
	anObject parent: self
]

{ #category : #accessing }
AIDendrogramNode >> size [
	
	^left size + right size
]

{ #category : #seriation }
AIDendrogramNode >> swap [
	
	| swap |
	swap := left.
	left := right.
	right := swap
]

{ #category : #accessing }
AIDendrogramNode >> threshold [
	
	^threshold
]

{ #category : #accessing }
AIDendrogramNode >> threshold: anObject [
	threshold := anObject
]
