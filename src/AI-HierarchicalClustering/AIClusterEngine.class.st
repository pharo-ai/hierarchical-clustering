"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #AIClusterEngine,
	#superclass : #Object,
	#instVars : [
		'distanceMatrix',
		'dendrogram'
	],
	#category : #'AI-HierarchicalClustering-Core'
}

{ #category : #examples }
AIClusterEngine class >> numbers: aCollection [
	" AIClusterEngine numbers: #(1 2 9 0 7 2 4 3) "

	^ (self with: aCollection using: [ :a :b | (a - b) * (a - b) ]) averageLinkage elements
]

{ #category : #'instance creation' }
AIClusterEngine class >> on1D: anObject [
	" Answer a new instance of the receiver wrapping anObject as the receiver's distance matrix "

	^ self withDistanceMatrix: (AIDistanceSquare on1D: anObject)
]

{ #category : #'instance creation' }
AIClusterEngine class >> with: anObject [
	" Answer a new instance of the receiver wrapping anObject as the receiver's distance matrix "

	^ self withDistanceMatrix: (AIDistanceSquare on: anObject)
]

{ #category : #'instance creation' }
AIClusterEngine class >> with: aCollection using: aDistanceBlock [
	" Answer a new engine using aDistanceBlock containing the code to calculate distance between elements in aCollection "

	^ self withDistanceMatrix: (AIDistanceSquare on: aCollection using: aDistanceBlock)
]

{ #category : #'instance creation' }
AIClusterEngine class >> withDistanceMatrix: distanceMatrix [
	^ self new
		distanceMatrix: distanceMatrix;
		yourself
]

{ #category : #clustering }
AIClusterEngine >> averageLinkage [
	^ self performClustering: #averageLinkage
]

{ #category : #clustering }
AIClusterEngine >> completeLinkage [
	^ self performClustering: #completeLinkage
]

{ #category : #accessing }
AIClusterEngine >> dendrogram [
	^ dendrogram ifNil: [ dendrogram := self averageLinkage ]
]

{ #category : #accessing }
AIClusterEngine >> distanceMatrix [
	^ distanceMatrix
]

{ #category : #accessing }
AIClusterEngine >> distanceMatrix: anObject [
	distanceMatrix := anObject
]

{ #category : #'private - deprecated' }
AIClusterEngine >> hierarchicalClusteringShowProgressUsing: selector [
	self deprecated: 'Uses #hierarchicalClusteringUsing: instead'.
	^ self hierarchicalClusteringUsing: selector
]

{ #category : #'private - deprecated' }
AIClusterEngine >> hierarchicalClusteringUsing: selector [
	^ self performClustering: selector
]

{ #category : #accessing }
AIClusterEngine >> items [
	^ distanceMatrix items
]

{ #category : #clustering }
AIClusterEngine >> performClustering: linkageSelector [
	^ dendrogram := (AIClusteringData onDistanceSquare: distanceMatrix) performClustering: linkageSelector
]

{ #category : #clustering }
AIClusterEngine >> singleLinkage [
	^ self performClustering: #singleLinkage
]
