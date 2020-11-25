"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MLClusteringVector,
	#superclass : #MLArrayVector,
	#type : #variable,
	#instVars : [
		'min',
		'found'
	],
	#category : #MLHierachicalClustering
}

{ #category : #accessing }
MLClusteringVector >> at: index put: aNumber [
	super at: index put: aNumber.
	(found isNotNil and: [ found = index or: [ aNumber < min ] ])
		ifTrue: [ found := nil ].
	^ aNumber
]

{ #category : #accessing }
MLClusteringVector >> found [
	
	^found
]

{ #category : #accessing }
MLClusteringVector >> min [
	found ifNil: [ self update ].
	^ min
]

{ #category : #accessing }
MLClusteringVector >> unsetAt: index [
	super at: index put: MLUnlimited positive.
	found = index ifTrue: [ found := nil ]
]

{ #category : #private }
MLClusteringVector >> update [
	min := MLUnlimited positive.
	self
		doWithIndex: [ :each :ind | 
			each < min
				ifTrue: [ min := each.
					found := ind ] ]
]
