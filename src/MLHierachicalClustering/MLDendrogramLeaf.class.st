"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MLDendrogramLeaf,
	#superclass : #MLDendrogram,
	#instVars : [
		'element'
	],
	#category : #MLHierachicalClustering
}

{ #category : #'instance creation' }
MLDendrogramLeaf class >> with: anElement [
	^ self new
		element: anElement;
		yourself
]

{ #category : #accessing }
MLDendrogramLeaf >> element [
	
	^element
]

{ #category : #accessing }
MLDendrogramLeaf >> element: anObject [
	element := anObject
]

{ #category : #enumerating }
MLDendrogramLeaf >> elementsDo: aBlock [
	
	aBlock value: element
]

{ #category : #enumerating }
MLDendrogramLeaf >> leavesDo: aBlock [
	
	aBlock value: self
]

{ #category : #accessing }
MLDendrogramLeaf >> left [
	
	^self
]

{ #category : #enumerating }
MLDendrogramLeaf >> nodesDo: aBlock [
	"does nothing"
	
	
]

{ #category : #seriation }
MLDendrogramLeaf >> orderLeafs [
	"do nothing"
	
	
]

{ #category : #accessing }
MLDendrogramLeaf >> right [
	
	^self
]

{ #category : #accessing }
MLDendrogramLeaf >> size [
	
	^1
]

{ #category : #seriation }
MLDendrogramLeaf >> swap [
	"does nothing"
	
	
]

{ #category : #accessing }
MLDendrogramLeaf >> threshold [
	
	^ Number zero
]
