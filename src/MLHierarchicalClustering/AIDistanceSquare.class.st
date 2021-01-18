"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #AIDistanceSquare,
	#superclass : #MLSymetricMatrix,
	#instVars : [
		'distanceBlock',
		'items',
		'dendrogram'
	],
	#category : #'MLHierarchicalClustering-Math'
}

{ #category : #constants }
AIDistanceSquare class >> defaultDistanceBlock [
	
	^[:a :b | a dist: b]
]

{ #category : #'instance creation' }
AIDistanceSquare class >> from1D: aCollection [
	" Answer a new instance of the receiver with partial matrix from oneDimensionCollection. Assume distances already calculated in oneDimensionCollection "
	
	^ self basicNew
		initializeFrom1D: aCollection;
		yourself.

]

{ #category : #'instance creation' }
AIDistanceSquare class >> on: items [
	
	^self
		on: items
		using: self defaultDistanceBlock
]

{ #category : #'instance creation' }
AIDistanceSquare class >> on: vectorA and: vectorB using: distanceBlock [
	
	[vectorA size = vectorB size] assert.
	^(self new: vectorA size)
		initialize: vectorA and: vectorB using: distanceBlock;
		yourself
]

{ #category : #'instance creation' }
AIDistanceSquare class >> on: items using: distanceBlock [
	
	^(self new: items size)
		initialize: items using: distanceBlock;
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
AIDistanceSquare >> copyClusteringData [
	
	^partialColumns collect: [:each | each copy]
]

{ #category : #accessing }
AIDistanceSquare >> dendrogram [
	dendrogram ifNil: [ self performSeriation ].
	^ dendrogram
]

{ #category : #accessing }
AIDistanceSquare >> distanceBlock [
	
	^distanceBlock
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
AIDistanceSquare >> initialize: someItems using: aDistanceBlock [
	
	items := someItems.
	distanceBlock := aDistanceBlock.
	partialColumns
		doWithIndex:
			[:vector :column | 
			vector
				putWithIndex:
					[:row | 
					distanceBlock
						value: (items at: column)
						value: (items at: row)]]
]

{ #category : #'initialize-release' }
AIDistanceSquare >> initializeFrom1D: aCollection [
	" Private - Assume aCollection to be 1D collection. Read items from it and set the receiver's lower triangular items ."
	
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
