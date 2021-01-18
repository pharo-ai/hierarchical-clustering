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
	super at: index put: AIUnlimited positive.
	found = index ifTrue: [ found := nil ]
]

{ #category : #private }
AIClusteringVector >> update [
	min := AIUnlimited positive.
	self
		doWithIndex: [ :each :ind | 
			each < min
				ifTrue: [ min := each.
					found := ind ] ]
]
