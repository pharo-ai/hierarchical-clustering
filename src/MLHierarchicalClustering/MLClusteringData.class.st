"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MLClusteringData,
	#superclass : #MLSymetricMatrix,
	#instVars : [
		'indices',
		'value',
		'clusters',
		'foundA0',
		'foundB0'
	],
	#category : #'MLHierarchicalClustering-Core'
}

{ #category : #'instance creation' }
MLClusteringData class >> onDistanceSquare: distanceSquare [
	
	^ self basicNew
		initialize: distanceSquare;
		yourself
]

{ #category : #private }
MLClusteringData class >> vectorSpecies [
	
	^Array
]

{ #category : #'linkage functions' }
MLClusteringData >> averageLinkage [
	
	| weightA weightB sizeA sizeB |
	sizeA := (clusters at: foundA0) size "asDouble"asFloat.
	sizeB := (clusters at: foundB0) size "asDouble"asFloat.
	weightA := sizeA / (sizeA + sizeB).
	weightB := sizeB / (sizeA + sizeB).
	self
		privateLinkage:
			[:index0 :valueA :valueB | valueA * weightA + (valueB * weightB)]
]

{ #category : #'linkage functions' }
MLClusteringData >> centroid [
	
	| weightA weightB sizeA sizeB valueC |
	sizeA := (clusters at: foundA0) size asFloat.
	sizeB := (clusters at: foundB0) size asFloat.
	weightA := sizeA / (sizeA + sizeB).
	weightB := sizeB / (sizeA + sizeB).
	valueC := (self at: foundA0 and: foundB0)
		- (sizeA * sizeB / (sizeA + sizeB) squared).
	self
		privateLinkage:
			[:index0 :valueA :valueB | valueA * weightA + (valueB * weightB) - valueC]
]

{ #category : #'linkage functions' }
MLClusteringData >> completeLinkage [
	
	self privateLinkage: [:index0 :valueA :valueB | valueA max: valueB]
]

{ #category : #accessing }
MLClusteringData >> dendrogram [
	self assert: indices size = 1.
	^ clusters at: indices anyOne
]

{ #category : #private }
MLClusteringData >> findMinimum [
	"This method is written such that it uses primitives only."
	
	| columnVector |
	value := MLUnlimited positive.
	2
		to: indices size
		do:
			[:column | 
			columnVector := partialColumns at: (indices at: column).
			columnVector min < value
				ifTrue:
					[value := columnVector min.
					foundB0 := indices at: column.
					foundA0 := columnVector found]]
]

{ #category : #'initialize-release' }
MLClusteringData >> initialize: distanceMatrix [
	
	partialColumns := distanceMatrix copyClusteringData
		collect: [:each | MLClusteringVector withAll: each].
	value := foundA0 := foundB0 := nil.
	clusters := distanceMatrix items
		collect: [:item | MLDendrogram with: item].
	indices := (1 to: partialColumns size) asArray.
	1
		to: partialColumns size
		do: [:n | (partialColumns at: n) unsetAt: n]
]

{ #category : #'initialize-release' }
MLClusteringData >> initializeRows: m columns: n [
	
	^self shouldNotImplement
]

{ #category : #'linkage functions' }
MLClusteringData >> meanLinkage [
	
	self privateLinkage: [:index0 :valueA :valueB | (valueA + valueB) / 2]
]

{ #category : #clustering }
MLClusteringData >> performClustering: linkageSelector [
	
	indices size - 1
		timesRepeat:
			["IncrementNotification signalWith: indices size."
			self findMinimum.
			self perform: linkageSelector].
	^self dendrogram
]

{ #category : #private }
MLClusteringData >> privateLinkage: aBlock [
	
	indices := indices copyRemoveAtIndex: (indices indexOf: foundB0).
	indices
		do:
			[:index0 | 
			index0 = foundA0
				ifFalse:
					[self
						at: foundA0
						and: index0
						put:
							(aBlock
								value: index0
								value: (self at: foundA0 and: index0)
								value: (self at: foundB0 and: index0))].
			self unsetAt: foundB0 and: index0].
	clusters
		at: foundA0
		put:
			((clusters at: foundA0)
				merge: (clusters at: foundB0)
				at: value).
	clusters at: foundB0 put: nil
]

{ #category : #'linkage functions' }
MLClusteringData >> singleLinkage [
	
	self privateLinkage: [:index0 :valueA :valueB | valueA min: valueB]
]

{ #category : #private }
MLClusteringData >> unsetAt: row and: column [
	
	^row < column
		ifTrue: [(partialColumns at: column) unsetAt: row]
		ifFalse: [(partialColumns at: row) unsetAt: column]
]

{ #category : #'linkage functions' }
MLClusteringData >> wardsMethod [
	
	| sizeA sizeB valueC sizeC weightA weightB weightC |
	sizeA := (clusters at: foundA0) size asFloat.
	sizeB := (clusters at: foundB0) size asFloat.
	valueC := self at: foundA0 and: foundB0.
	self
		privateLinkage:
			[:index0 :valueA :valueB | 
			sizeC := (clusters at: index0) size.
			weightA := (sizeA + sizeC) / (sizeA + sizeB + sizeC).
			weightB := (sizeB + sizeC) / (sizeA + sizeB + sizeC).
			weightC := sizeC / (sizeA + sizeB + sizeC).
			valueA * weightA + (valueB * weightB) - (valueC * weightC)]
]
