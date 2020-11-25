"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MLClusterEngine,
	#superclass : #Object,
	#instVars : [
		'distanceMatrix',
		'dendrogram'
	],
	#category : #MLHierachicalClustering
}

{ #category : #examples }
MLClusterEngine class >> numbers: aCollection [
	"MalClusterEngine numbers: #(1 2 9 0 7 2 4 3)"

	^ (self with: aCollection using: [ :a :b | (a - b) * (a - b) ]) averageLinkage elements
]

{ #category : #'instance creation' }
MLClusterEngine class >> with: aCollection [
	^ self withDistanceMatrix: (MLDistanceSquare on: aCollection)
]

{ #category : #'instance creation' }
MLClusterEngine class >> with: aCollection using: aDistanceBlock [
	^ self withDistanceMatrix: (MLDistanceSquare on: aCollection using: aDistanceBlock)
]

{ #category : #'instance creation' }
MLClusterEngine class >> withDistanceMatrix: distanceMatrix [
	^ self new
		distanceMatrix: distanceMatrix;
		yourself
]

{ #category : #clustering }
MLClusterEngine >> averageLinkage [
	^ self performClustering: #averageLinkage
]

{ #category : #clustering }
MLClusterEngine >> completeLinkage [
	^ self performClustering: #completeLinkage
]

{ #category : #accessing }
MLClusterEngine >> dendrogram [
	^ dendrogram ifNil: [ dendrogram := self averageLinkage ]
]

{ #category : #accessing }
MLClusterEngine >> distanceMatrix [
	^ distanceMatrix
]

{ #category : #accessing }
MLClusterEngine >> distanceMatrix: anObject [
	distanceMatrix := anObject
]

{ #category : #'private - deprecated' }
MLClusterEngine >> hierarchicalClusteringShowProgressUsing: selector [
	self deprecated: 'Uses #hierarchicalClusteringUsing: instead'.
	^ self hierarchicalClusteringUsing: selector
]

{ #category : #'private - deprecated' }
MLClusterEngine >> hierarchicalClusteringUsing: selector [
	^ self performClustering: selector
]

{ #category : #accessing }
MLClusterEngine >> items [
	^ distanceMatrix items
]

{ #category : #clustering }
MLClusterEngine >> performClustering: linkageSelector [
	^ dendrogram := (MLClusteringData onDistanceSquare: distanceMatrix) performClustering: linkageSelector
]

{ #category : #clustering }
MLClusterEngine >> singleLinkage [
	^ self performClustering: #singleLinkage
]
