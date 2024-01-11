"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #AIClusteringVector,
	#superclass : #AIArrayVector,
	#type : #variable,
	#instVars : [
		'min',
		'found'
	],
	#category : #'AI-HierarchicalClustering-Math'
}

{ #category : #accessing }
AIClusteringVector >> at: index put: aNumber [
	super at: index put: aNumber.
	(found isNotNil and: [ found = index or: [ aNumber < min ] ])
		ifTrue: [ found := nil ].
	^ aNumber
]

{ #category : #accessing }
AIClusteringVector >> found [
	
	^found
]

{ #category : #accessing }
AIClusteringVector >> min [
	found ifNil: [ self update ].
	^ min
]

{ #category : #accessing }
AIClusteringVector >> unsetAt: index [
	super at: index put: Float infinity.
	found = index ifTrue: [ found := nil ]
]

{ #category : #private }
AIClusteringVector >> update [

	min := Float infinity.
	self doWithIndex: [ :each :ind | "This was originally `each < min` but a lot of time we compare a float to an integer and it is faster to ask a float to compare itself to an integer than the other way around because it tries to cast the float as a fraction."
		min >= each ifTrue: [
			min := each.
			found := ind ] ]
]
