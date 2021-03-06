"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #AIVectorItem,
	#superclass : #AIVectorDecorator,
	#instVars : [
		'item'
	],
	#category : #'AI-HierarchicalClustering-Math'
}

{ #category : #'instance creation' }
AIVectorItem class >> with: anElement and: aVector [
	
	^(self on: aVector)
		item: anElement;
		yourself
]

{ #category : #'instance creation' }
AIVectorItem class >> with: anElement andAll: aCollection [
	
	^(self on: (AIArrayVector withAll: aCollection))
		item: anElement;
		yourself
]

{ #category : #comparing }
AIVectorItem >> = anObject [
	
	^super = anObject
		or: [(anObject isKindOf: AIVectorItem) and: [self item = anObject item]]
]

{ #category : #'vector functions' }
AIVectorItem >> dist: anItem [
	
	^self vector dist: anItem vector
]

{ #category : #'as yet unclassified' }
AIVectorItem >> initializeDistanceSquare: anAIDistanceSquare from: aCollection [ 
	" Initialize anAIDistanceSquare based in the recever's element for aCollection items "

	anAIDistanceSquare initializeFromVectorItems: aCollection
]

{ #category : #accessing }
AIVectorItem >> item [
	
	^item
]

{ #category : #accessing }
AIVectorItem >> item: anObject [
	
	item := anObject
]

{ #category : #printing }
AIVectorItem >> printOn: aStream [
	
	item printOn: aStream
]

{ #category : #accessing }
AIVectorItem >> vector [
	
	^vector
]

{ #category : #accessing }
AIVectorItem >> vector: anObject [
	
	vector := anObject
]
