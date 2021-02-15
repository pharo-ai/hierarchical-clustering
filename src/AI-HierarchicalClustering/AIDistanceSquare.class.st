"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #AIDistanceSquare,
	#superclass : #AISymetricMatrix,
	#instVars : [
		'distanceBlock',
		'items',
		'dendrogram'
	],
	#category : #'AI-HierarchicalClustering-Math'
}

{ #category : #'instance creation' }
AIDistanceSquare class >> on1D: aCollection [
	" Answer a new distance square matrix for aCollection of the receiver configured with a default distance "

	^ (self new: aCollection size)
		initializeFrom1D: aCollection;
		yourself
]

{ #category : #'instance creation' }
AIDistanceSquare class >> on: anObject [
	" Answer a new distance square matrix for anObject of the receiver configured with a default distance "

	^ (self new: anObject size)
		initializeFrom: anObject;
		yourself
]

{ #category : #'instance creation' }
AIDistanceSquare class >> on: vectorA and: vectorB using: distanceBlock [
	
	[vectorA size = vectorB size] assert.
	^(self new: vectorA size)
		initialize: vectorA and: vectorB using: distanceBlock;
		yourself
]

{ #category : #'instance creation' }
AIDistanceSquare class >> on: aCollection using: distanceBlock [
	" Answer a new distance square matrix on aCollection items and with distanceBlock to obtain the distance between element vectors "

	^ (self on: aCollection)
		distanceBlock: distanceBlock
		yourself
]

{ #category : #accessing }
AIDistanceSquare >> at: row and: column put: aNumber [
	
	^self noModificationError
]

{ #category : #accessing }
AIDistanceSquare >> at: row at: column put: aNumber [
	
	(partialColumns at: row) at: column put: aNumber
]

{ #category : #private }
AIDistanceSquare >> checkInvariant [
	
	^super checkInvariant
		and:
			[(distanceBlock respondsTo: #value:value:) and: [items isCollection]]
]

{ #category : #private }
AIDistanceSquare >> collectDendrogramItems [
	
	^ items asArrayOfRows collect: [ : item | AIDendrogram with: item ]
]

{ #category : #private }
AIDistanceSquare >> copyClusteringData [
	
	^partialColumns collect: [:each | each copy]
]

{ #category : #constants }
AIDistanceSquare >> defaultDistanceBlock [
	
	^[:a :b | a dist: b]
]

{ #category : #accessing }
AIDistanceSquare >> dendrogram [
	dendrogram ifNil: [ self performSeriation ].
	^ dendrogram
]

{ #category : #accessing }
AIDistanceSquare >> distanceBlock [
	" Answer a <BlockClosure> with the default behavior for calculating distance between receiver's elements "

	^ distanceBlock
		ifNil: [ distanceBlock := self defaultDistanceBlock ]
]

{ #category : #accessing }
AIDistanceSquare >> distanceBlock: anObject [
	
	distanceBlock := anObject
]

{ #category : #'initialize-release' }
AIDistanceSquare >> initialize: vectorA and: vectorB using: aDistanceBlock [
	
	items := nil.
	distanceBlock := aDistanceBlock.
	partialColumns
		doWithIndex:
			[:vector :column | 
			vector
				putWithIndex:
					[:row | 
					distanceBlock
						value: (vectorA at: column)
						value: (vectorB at: row)]]
]

{ #category : #'initialize-release' }
AIDistanceSquare >> initializeFrom1D: aCollection [
	" Private - Assume aCollection to be 1D (flat) collection. Read items from it and set the receiver's lower triangular matrix "
	
	| dimension colSize |
	colSize := aCollection size.
	items := aCollection.
	dimension := (colSize findNK pairsCollect: [ :n :k | n ]) min.
	dimension * (dimension - 1)	~= (colSize * 2)
			ifTrue: [ self error: 'Collection size must be compatible with binomial coefficient (n take: 2), for n >= 2' ].
	self partialColumns: (Array new: dimension).
	1
		to: dimension
		do: [ :index | 
			self partialColumns
				at: index
				put: (self newVectorOfSize: index itemsFrom: aCollection dimensions: dimension) ]

]

{ #category : #'initialize-release' }
AIDistanceSquare >> initializeFrom: anObject [
	" Private - anObject should know how to initialize for the receiver's lower triangular items ."

	anObject initializeDistanceSquareFor: self



]

{ #category : #'initialize-release' }
AIDistanceSquare >> initializeFromDataFrame: aDataFrame [
	" Private - Read items from aCollection and set the receiver's lower triangular items applying the distance formula between vectors in the data frame."

	items := aDataFrame.
	partialColumns doWithIndex: [ :vector :column | 
		vector putWithIndex: [ : row |
			self distanceBlock
					value: ((aDataFrame at: column) values) asVector
					value: ((aDataFrame at: row) values) asVector ] ]


]

{ #category : #'initialize-release' }
AIDistanceSquare >> initializeFromNumbers: aCollection [
	" Private - Assume aCollection to be 1D (flat) collection. Read items from it and set the receiver's lower triangular matrix "
	
	items := aCollection.
	partialColumns doWithIndex: [ :vector :column | 
		vector putWithIndex: [ :row | 
			self distanceBlock
				value: (items at: column)
				value: (items at: row) ] ]

]

{ #category : #'initialize-release' }
AIDistanceSquare >> initializeFromPoints: someItems [ 
	
	items := someItems.
	partialColumns doWithIndex: [ :vector :column | 
		vector putWithIndex: [ :row | 
			self distanceBlock
				value: (items at: column)
				value: (items at: row) ] ]
]

{ #category : #'as yet unclassified' }
AIDistanceSquare >> initializeFromVectorItems: aCollection [ 

	items := aCollection.
	partialColumns doWithIndex: [:vector :column | 
		vector putWithIndex: [ :row | 
					self distanceBlock
						value: (items at: column)
						value: (items at: row)]]
]

{ #category : #accessing }
AIDistanceSquare >> items [
	
	^items
]

{ #category : #accessing }
AIDistanceSquare >> items: anObject [
	items := anObject
]

{ #category : #private }
AIDistanceSquare >> newVectorOfSize: i itemsFrom: aCollection dimensions: n [
	" Private - Answer a new vector of i size with items from aCollection, read as condensed indices.
	To get each element (from aCollection) in the new vector, the number of elements to the left and above is obtained for each position, depending of the dimensions of the whole receiver (a squareform matrix) and the requested vector size (each row in the current iteration) "

	| vector |
	
	vector := self vectorSpecies new: i.
	1 
		to: i
		do: [ : j | 
			j = i
				ifTrue: [ vector at: i put: 0 ]
				ifFalse: [ vector at: j put: (aCollection at: ((n * (j - 1)) - (j - 1 * j / 2) + (i - j))) ] ].
	^ vector
]

{ #category : #actions }
AIDistanceSquare >> performSeriation [
	| newOrder |
	dendrogram := (AIClusterEngine withDistanceMatrix: self) averageLinkage.
	newOrder := self dendrogram orderLeafs asArray.
	self rearrange: newOrder
]

{ #category : #private }
AIDistanceSquare >> rearrange: newItems [
	
	| newColumns indices |
	[items equalsTo: newItems] assert.	"create new column vectors."
	newColumns := partialColumns collect: [:each | each copyEmpty: each size].	"get the new order of indices."
	indices := newItems collect: [:each | items indexOf: each].	"map the distances into to the new vectors."
	newColumns
		doWithIndex:
			[:vector :column | 
			vector
				putWithIndex:
					[:row | 
					self
						at: (indices at: column)
						and: (indices at: row)]].	"update state of object and check invariant"
	partialColumns := newColumns.
	items := newItems.	"items := newItems."
	[self checkInvariant] assert
]
