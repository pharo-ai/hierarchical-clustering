"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #AIDendrogram,
	#superclass : #Collection,
	#instVars : [
		'parent',
		'depth'
	],
	#category : #'AI-HierarchicalClustering-Dendrogram'
}

{ #category : #examples }
AIDendrogram class >> example1 [
	<example>
	
	| input clusty |

	input := { 
		0.67000151 	@ -2.4288232  .
		-0.97060792 	@ -0.91638171 . 
		1.20387858 	@ -0.03940283 .
		-1.98986617 	@  0.36116279 .
		-2.2372045  	@ -0.09565332 . 
		0.81210612 	@ -2.42210087 }.
	clusty := AIClusterEngine with: input.
	clusty hierarchicalClusteringUsing: #averageLinkage.
	clusty dendrogram plot4

]

{ #category : #'instance creation' }
AIDendrogram class >> with: anElement [
	
	^AIDendrogramLeaf with: anElement
]

{ #category : #adding }
AIDendrogram >> add: newObject [
	
	self shouldNotImplement
]

{ #category : #'break into clusters' }
AIDendrogram >> breakAtThreshold: aNumber [
	
	| candidates |
	candidates := (self nodes select: [:each | each threshold < aNumber])
		, self leaves.
	^candidates reject: [:each | candidates includes: each parent]
]

{ #category : #'break into clusters' }
AIDendrogram >> breakInto: numberOfClusters [
	
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

{ #category : #accessing }
AIDendrogram >> depthFactor [

	^ 20
]

{ #category : #seriation }
AIDendrogram >> dist: dendrogram [
	
	| sum |
	sum := MLAccumulator sum.
	self elements
		cross: dendrogram elements
		do: [:a :b | sum add: (a dist: b)].
	^sum average
]

{ #category : #enumerating }
AIDendrogram >> do: aBlock [
	
	self elementsDo: aBlock
]

{ #category : #accessing }
AIDendrogram >> elements [
	
	| stream |
	stream := Array new writeStream.
	self elementsDo: [:each | stream nextPut: each].
	^stream contents
]

{ #category : #enumerating }
AIDendrogram >> elementsDo: aBlock [
	
	^self subclassResponsibility
]

{ #category : #accessing }
AIDendrogram >> heightFactor [

	^ 3
]

{ #category : #accessing }
AIDendrogram >> index [
	
	^self isRoot
		ifTrue: [1]
		ifFalse:
			[self isLeft
				ifTrue: [self parent index]
				ifFalse: [self parent index + self parent left size]]
]

{ #category : #testing }
AIDendrogram >> isLeaf [

	^ false
]

{ #category : #testing }
AIDendrogram >> isLeft [
	
	^self parent left == self
]

{ #category : #testing }
AIDendrogram >> isNode [

	^ false
]

{ #category : #testing }
AIDendrogram >> isRight [
	
	^self parent right == self
]

{ #category : #testing }
AIDendrogram >> isRoot [
	^ parent isNil
]

{ #category : #accessing }
AIDendrogram >> leaves [
	
	| stream |
	stream := Array new writeStream.
	self leavesDo: [:each | stream nextPut: each].
	^stream contents
]

{ #category : #enumerating }
AIDendrogram >> leavesDo: aBlock [
	
	^self subclassResponsibility
]

{ #category : #accessing }
AIDendrogram >> left [
	
	^self subclassResponsibility
]

{ #category : #'instance creation' }
AIDendrogram >> merge: dendrogram at: threshold [
	
	^AIDendrogramNode with: self with: dendrogram at: threshold
]

{ #category : #accessing }
AIDendrogram >> nodes [
	
	| stream |
	stream := Array new writeStream.
	self nodesDo: [:each | stream nextPut: each].
	^stream contents
]

{ #category : #enumerating }
AIDendrogram >> nodesDo: aBlock [
	
	^self subclassResponsibility
]

{ #category : #seriation }
AIDendrogram >> orderLeafs [
	
	^self subclassResponsibility
]

{ #category : #accessing }
AIDendrogram >> parent [
	
	^parent
]

{ #category : #accessing }
AIDendrogram >> parent: anObject [
	parent := anObject
]

{ #category : #removing }
AIDendrogram >> remove: oldObject ifAbsent: anExceptionBlock [
	
	self shouldNotImplement
]

{ #category : #accessing }
AIDendrogram >> right [
	
	^self subclassResponsibility
]

{ #category : #accessing }
AIDendrogram >> size [
	
	^self subclassResponsibility
]

{ #category : #private }
AIDendrogram >> species [
	
	^OrderedCollection
]

{ #category : #seriation }
AIDendrogram >> swap [
	
	^self subclassResponsibility
]

{ #category : #accessing }
AIDendrogram >> threshold [
	
	^self subclassResponsibility
]
