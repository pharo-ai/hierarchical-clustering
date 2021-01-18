"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #AIDendrogramLeaf,
	#superclass : #AIDendrogram,
	#instVars : [
		'element'
	],
	#category : #'AI-HierarchicalClustering-Dendrogram'
}

{ #category : #'instance creation' }
AIDendrogramLeaf class >> with: anElement [
	^ self new
		element: anElement;
		yourself
]

{ #category : #comparing }
AIDendrogramLeaf >> = aMLDendrogram [

	self == aMLDendrogram
		ifTrue: [ ^ true ].
	self class = aMLDendrogram class
		ifFalse: [ ^ false ].
	^ self element = aMLDendrogram element
]

{ #category : #accessing }
AIDendrogramLeaf >> element [
	
	^element
]

{ #category : #accessing }
AIDendrogramLeaf >> element: anObject [
	element := anObject
]

{ #category : #enumerating }
AIDendrogramLeaf >> elementsDo: aBlock [
	
	aBlock value: element
]

{ #category : #comparing }
AIDendrogramLeaf >> hash [ 

	^ self element hash
]

{ #category : #testing }
AIDendrogramLeaf >> isLeaf [

	^ true
]

{ #category : #enumerating }
AIDendrogramLeaf >> leavesDo: aBlock [
	
	aBlock value: self
]

{ #category : #accessing }
AIDendrogramLeaf >> left [
	
	^self
]

{ #category : #enumerating }
AIDendrogramLeaf >> nodesDo: aBlock [
	"does nothing"
	
	
]

{ #category : #seriation }
AIDendrogramLeaf >> orderLeafs [
	"do nothing"
	
	
]

{ #category : #accessing }
AIDendrogramLeaf >> right [
	
	^self
]

{ #category : #accessing }
AIDendrogramLeaf >> size [
	
	^1
]

{ #category : #seriation }
AIDendrogramLeaf >> swap [
	"does nothing"
	
	
]

{ #category : #accessing }
AIDendrogramLeaf >> threshold [
	
	^ Number zero
]
