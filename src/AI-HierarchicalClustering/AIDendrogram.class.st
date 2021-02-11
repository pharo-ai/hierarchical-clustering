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
AIDendrogram class >> exampleAvgLinkageFromNumbers [
	<example>
	
	self exampleFromNumbersWithLinkage: #averageLinkage 

]

{ #category : #examples }
AIDendrogram class >> exampleAvgLinkageFromNumbersInDataFrame [
	<example>
	
	self exampleFromNumbersWithLinkage: #averageLinkage 

]

{ #category : #examples }
AIDendrogram class >> exampleAvgLinkageFromPoints [
	<example>
	
	self exampleFromPointsWithLinkage: #averageLinkage 

]

{ #category : #examples }
AIDendrogram class >> exampleCentroidLinkageFromPoints [
	<example>
	
	self exampleFromPointsWithLinkage: #centroid 

]

{ #category : #examples }
AIDendrogram class >> exampleCompleteLinkageFromPoints [
	<example>
	
	self exampleFromPointsWithLinkage: #completeLinkage

]

{ #category : #examples }
AIDendrogram class >> exampleFromNumbersInDataFrameWithLinkage: aSelector [
	<example>
	
	| clusty |

	clusty := AIClusterEngine with: self sampleDataFrame.
	clusty perform: #hierarchicalClusteringUsing: with: aSelector.
	clusty plotDendrogram

]

{ #category : #examples }
AIDendrogram class >> exampleFromNumbersWithLinkage: aSelector [
	<example>
	
	| clusty |

	clusty := AIClusterEngine with: self sampleNumbers.
	clusty perform: #hierarchicalClusteringUsing: with: aSelector.
	clusty plotDendrogram

]

{ #category : #examples }
AIDendrogram class >> exampleFromPointsWithLinkage: aSelector [
	<example>
	
	| clusty |

	clusty := AIClusterEngine with: self samplePoints.
	clusty perform: #hierarchicalClusteringUsing: with: aSelector.
	clusty plotDendrogram

]

{ #category : #examples }
AIDendrogram class >> exampleMeanLinkageFromPoints [
	<example>
	
	self exampleFromPointsWithLinkage: #meanLinkage 

]

{ #category : #examples }
AIDendrogram class >> exampleSingleLinkageFromPoints [
	<example>
	
	self exampleFromPointsWithLinkage: #singleLinkage.

]

{ #category : #examples }
AIDendrogram class >> exampleWardsFromPoints [
	<example>
	
	self exampleFromPointsWithLinkage: #wardsMethod 

]

{ #category : #examples }
AIDendrogram class >> sampleDataFrame [
	" Answer a <DataFrame> of samples for examples "

	^ DataFrame readFromCsv: '"State","Murder","Assault","UrbanPop","Rape"
Alabama,13.2,236,58,21.2
Alaska,10,263,48,44.5
Arizona,8.1,294,80,31
Arkansas,8.8,190,50,19.5
California,9,276,91,40.6
Colorado,7.9,204,78,38.7
Connecticut,3.3,110,77,11.1
Delaware,5.9,238,72,15.8
Florida,15.4,335,80,31.9
Georgia,17.4,211,60,25.8
Hawaii,5.3,46,83,20.2
Idaho,2.6,120,54,14.2
Illinois,10.4,249,83,24
Indiana,7.2,113,65,21
Iowa,2.2,56,57,11.3
Kansas,6,115,66,18
Kentucky,9.7,109,52,16.3
Louisiana,15.4,249,66,22.2
Maine,2.1,83,51,7.8
Maryland,11.3,300,67,27.8
Massachusetts,4.4,149,85,16.3
Michigan,12.1,255,74,35.1
Minnesota,2.7,72,66,14.9
Mississippi,16.1,259,44,17.1
Missouri,9,178,70,28.2
Montana,6,109,53,16.4
Nebraska,4.3,102,62,16.5
Nevada,12.2,252,81,46
New Hampshire,2.1,57,56,9.5
New Jersey,7.4,159,89,18.8
New Mexico,11.4,285,70,32.1
New York,11.1,254,86,26.1
North Carolina,13,337,45,16.1
North Dakota,0.8,45,44,7.3
Ohio,7.3,120,75,21.4
Oklahoma,6.6,151,68,20
Oregon,4.9,159,67,29.3
Pennsylvania,6.3,106,72,14.9
Rhode Island,3.4,174,87,8.3
South Carolina,14.4,279,48,22.5
South Dakota,3.8,86,45,12.8
Tennessee,13.2,188,59,26.9
Texas,12.7,201,80,25.5
Utah,3.2,120,80,22.9
Vermont,2.2,48,32,11.2
Virginia,8.5,156,63,20.7
Washington,4,145,73,26.2
West Virginia,5.7,81,39,9.3
Wisconsin,2.6,53,66,10.8
Wyoming,6.8,161,60,15.6
'
]

{ #category : #examples }
AIDendrogram class >> sampleNumbers [
	" Answer a <Collection> of sample Numbers for examples "

	^ #(1 2 3 5 11 12 15 21 22 23 25 31 32 35 41 42 43 45 47).

]

{ #category : #examples }
AIDendrogram class >> samplePoints [
	" Answer a <Collection> of sample points for examples "

	^ { 
		0.670 		@ -2.428 .
		-0.970 	@ -0.916 . 
		1.203 		@ -0.039 .
		-1.989 	@  0.361 .
		-2.237  	@ -0.096 . 
		0.812 		@ -2.422 
		}.
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
	sum := AIAccumulator sum.
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
