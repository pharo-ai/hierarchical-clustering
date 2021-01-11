"
A MLDistanceSquareTest is a test class for testing the behavior of MLDistanceSquare
"
Class {
	#name : #MLDistanceSquareTest,
	#superclass : #TestCase,
	#instVars : [
		'distanceMatrix'
	],
	#category : #'MLHierarchicalClustering-Tests-Math'
}

{ #category : #test }
MLDistanceSquareTest >> distanceSquare10Elements [
	" Answer a distance square matrix of ten elements manually built "
	
	^ MLDistanceSquare new
		items: (1 to: 10) asArray;
		partialColumns: {
			(self vectorClass withAll: #(0)) .
			self vectorClass withAll: #(1 0) .
			self vectorClass withAll: #(2 5 0) .
			self vectorClass withAll: #(3 6 8 0) .
			self vectorClass withAll: #(4 7 9 10 0) };
		yourself.
		
]

{ #category : #test }
MLDistanceSquareTest >> distanceSquare15Elements [
	" Answer a distance square matrix of 15 elements manually built "
	
	^ MLDistanceSquare new
		items: (1 to: 10) asArray;
		partialColumns: {
			(self vectorClass withAll: #(0)) .
			self vectorClass withAll: #(1 0) .
			self vectorClass withAll: #(2 6 0) .
			self vectorClass withAll: #(3 7 10 0) .
			self vectorClass withAll: #(4 8 11 13 0) .
			self vectorClass withAll: #(5 9 12 14 15 0) };
		yourself.
		
]

{ #category : #test }
MLDistanceSquareTest >> matrixClass [
	
	^ MLDistanceSquare
]

{ #category : #test }
MLDistanceSquareTest >> testAtAndPut [

	| validDs |
	
	validDs :=  self matrixClass from1D: #(1 2 3).
	self should: [ validDs at: 1 and: 1 put: 0 ] raise: Error.

]

{ #category : #test }
MLDistanceSquareTest >> testCopyClusteringData [

	| ds expected |
	
	ds :=  self matrixClass from1D: #(1 2 3).
	expected := { 
		self vectorClass with: 0 .
		self vectorClass withAll: #(1 0) .
		self vectorClass withAll: #(2 3 0) }.
	self assert: ds copyClusteringData equals: expected.


]

{ #category : #test }
MLDistanceSquareTest >> testDistanceBlock [

	| ds |
	
	ds :=  self matrixClass new.
	self assert: ds distanceBlock isNil.
	ds distanceBlock: [ : a : b | a + b ].
	self assert: (ds distanceBlock isKindOf: BlockClosure).
]

{ #category : #test }
MLDistanceSquareTest >> testInitializeFrom1D [

	| invalidItemsSizeCollection |
	
	self assert: (self matrixClass from1D: (1 to: 10) asArray) equals: self distanceSquare10Elements.
	self assert: (self matrixClass from1D: (1 to: 15) asArray) equals: self distanceSquare15Elements.

	invalidItemsSizeCollection := #(10 20).
	self should: [ self matrixClass from1D: invalidItemsSizeCollection ] raise: Error.
	invalidItemsSizeCollection := #(10 20 30 40).
	self should: [ self matrixClass from1D: invalidItemsSizeCollection ] raise: Error.
	invalidItemsSizeCollection := #(10 20 30 40 50).
	self should: [ self matrixClass from1D: invalidItemsSizeCollection ] raise: Error.
]

{ #category : #test }
MLDistanceSquareTest >> testItems [

	| ds newItems |
	
	ds :=  self matrixClass from1D: #(1 2 3).
	self assert: ds items equals: #(1 2 3).

	newItems := #(2 3 0).
	ds items: newItems.
	self assert: ds items equals: newItems.
]

{ #category : #test }
MLDistanceSquareTest >> testNewVectorOfSizeItemsFromDimensions [

	| ds vector |
	
	ds :=  self matrixClass new.
	vector := ds 
		newVectorOfSize: 1
		itemsFrom: (1 to: 10) asArray
		dimensions: 5.
	self assert: vector equals: (self vectorClass with: 0).
	vector := ds 
		newVectorOfSize: 5
		itemsFrom: (1 to: 10) asArray
		dimensions: 5.
	self assert: vector equals: (self vectorClass withAll: #(4 7 9 10 0)).
]

{ #category : #test }
MLDistanceSquareTest >> vectorClass [
	
	^ MLArrayVector
]
