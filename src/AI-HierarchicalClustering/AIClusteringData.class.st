"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #AIClusteringData,
	#superclass : #AISymetricMatrix,
	#instVars : [
		'indices',
		'value',
		'clusters',
		'foundA0',
		'foundB0'
	],
	#category : #'AI-HierarchicalClustering-Core'
}

{ #category : #accessing }
AIClusteringData class >> linkageFunctions [
	" Answer a <Collection> of the receiver's available linkage functions selectors "
	
	^ self organization listAtCategoryNamed: #'linkage functions'
]

{ #category : #'instance creation' }
AIClusteringData class >> onDistanceSquare: distanceSquare [
	
	^ self basicNew
		initialize: distanceSquare;
		yourself
]

{ #category : #private }
AIClusteringData class >> vectorSpecies [
	
	^Array
]

{ #category : #'linkage functions' }
AIClusteringData >> averageLinkage [
	
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
AIClusteringData >> centroid [
	
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
AIClusteringData >> completeLinkage [
	
	self privateLinkage: [:index0 :valueA :valueB | valueA max: valueB]
]

{ #category : #accessing }
AIClusteringData >> dendrogram [
	" Answer an <AIDendrogramNode> representing the root node of the receiver's dendrogram "

	self assert: indices size equals: 1.
	^ clusters at: indices anyOne
]

{ #category : #private }
AIClusteringData >> findMinimum [
	"This method is written such that it uses primitives only."
	
	| columnVector |
	value := AIUnlimited positive.
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
AIClusteringData >> initialize: distanceMatrix [
	
	partialColumns := distanceMatrix copyClusteringData
		collect: [:each | AIClusteringVector withAll: each].
	value := foundA0 := foundB0 := nil.
	clusters := distanceMatrix collectDendrogramItems.
	indices := (1 to: partialColumns size) asArray.
	1
		to: partialColumns size
		do: [:n | (partialColumns at: n) unsetAt: n]
]

{ #category : #'initialize-release' }
AIClusteringData >> initializeRows: m columns: n [
	
	^self shouldNotImplement
]

{ #category : #'linkage functions' }
AIClusteringData >> meanLinkage [
	
	self privateLinkage: [:index0 :valueA :valueB | (valueA + valueB) / 2]
]

{ #category : #clustering }
AIClusteringData >> performClustering: linkageSelector [
	
	indices size - 1
		timesRepeat:
			["IncrementNotification signalWith: indices size."
			self findMinimum.
			self perform: linkageSelector].
	^self dendrogram
]

{ #category : #private }
AIClusteringData >> privateLinkage: aBlock [
	
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
AIClusteringData >> singleLinkage [
	
	self privateLinkage: [:index0 :valueA :valueB | valueA min: valueB]
]

{ #category : #private }
AIClusteringData >> unsetAt: row and: column [
	
	^row < column
		ifTrue: [(partialColumns at: column) unsetAt: row]
		ifFalse: [(partialColumns at: row) unsetAt: column]
]

{ #category : #'linkage functions' }
AIClusteringData >> wardsMethod [
	
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
