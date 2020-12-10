"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MLDendrogram,
	#superclass : #Collection,
	#instVars : [
		'parent'
	],
	#category : #'MLHierarchicalClustering-Dendrogram'
}

{ #category : #'instance creation' }
MLDendrogram class >> with: anElement [
	
	^MLDendrogramLeaf with: anElement
]

{ #category : #adding }
MLDendrogram >> add: newObject [
	
	self shouldNotImplement
]

{ #category : #'break into clusters' }
MLDendrogram >> breakAtThreshold: aNumber [
	
	| candidates |
	candidates := (self nodes select: [:each | each threshold < aNumber])
		, self leaves.
	^candidates reject: [:each | candidates includes: each parent]
]

{ #category : #'break into clusters' }
MLDendrogram >> breakInto: numberOfClusters [
	
	| all candidates |
	"all := self nodes reverseSort: #threshold."
	all := self nodes sort: [:a :b | b threshold <= a threshold].
	candidates := IdentitySet with: all first.
	all
		do:
			[:each | 
			candidates remove: each.
			candidates add: each left.
			candidates add: each right.
			candidates size >= numberOfClusters ifTrue: [^candidates asArray]]
]

{ #category : #seriation }
MLDendrogram >> dist: dendrogram [
	
	| sum |
	sum := MLAccumulator sum.
	self elements
		cross: dendrogram elements
		do: [:a :b | sum add: (a dist: b)].
	^sum average
]

{ #category : #enumerating }
MLDendrogram >> do: aBlock [
	
	self elementsDo: aBlock
]

{ #category : #accessing }
MLDendrogram >> elements [
	
	| stream |
	stream := Array new writeStream.
	self elementsDo: [:each | stream nextPut: each].
	^stream contents
]

{ #category : #enumerating }
MLDendrogram >> elementsDo: aBlock [
	
	^self subclassResponsibility
]

{ #category : #accessing }
MLDendrogram >> index [
	
	^self isRoot
		ifTrue: [1]
		ifFalse:
			[self isLeft
				ifTrue: [self parent index]
				ifFalse: [self parent index + self parent left size]]
]

{ #category : #testing }
MLDendrogram >> isLeft [
	
	^self parent left == self
]

{ #category : #testing }
MLDendrogram >> isRight [
	
	^self parent right == self
]

{ #category : #testing }
MLDendrogram >> isRoot [
	^ parent isNil
]

{ #category : #accessing }
MLDendrogram >> leaves [
	
	| stream |
	stream := Array new writeStream.
	self leavesDo: [:each | stream nextPut: each].
	^stream contents
]

{ #category : #enumerating }
MLDendrogram >> leavesDo: aBlock [
	
	^self subclassResponsibility
]

{ #category : #accessing }
MLDendrogram >> left [
	
	^self subclassResponsibility
]

{ #category : #'instance creation' }
MLDendrogram >> merge: dendrogram at: threshold [
	
	^MLDendrogramNode with: self with: dendrogram at: threshold
]

{ #category : #accessing }
MLDendrogram >> nodes [
	
	| stream |
	stream := Array new writeStream.
	self nodesDo: [:each | stream nextPut: each].
	^stream contents
]

{ #category : #enumerating }
MLDendrogram >> nodesDo: aBlock [
	
	^self subclassResponsibility
]

{ #category : #seriation }
MLDendrogram >> orderLeafs [
	
	^self subclassResponsibility
]

{ #category : #accessing }
MLDendrogram >> parent [
	
	^parent
]

{ #category : #accessing }
MLDendrogram >> parent: anObject [
	parent := anObject
]

{ #category : #removing }
MLDendrogram >> remove: oldObject ifAbsent: anExceptionBlock [
	
	self shouldNotImplement
]

{ #category : #accessing }
MLDendrogram >> right [
	
	^self subclassResponsibility
]

{ #category : #accessing }
MLDendrogram >> size [
	
	^self subclassResponsibility
]

{ #category : #private }
MLDendrogram >> species [
	
	^OrderedCollection
]

{ #category : #seriation }
MLDendrogram >> swap [
	
	^self subclassResponsibility
]

{ #category : #accessing }
MLDendrogram >> threshold [
	
	^self subclassResponsibility
]
