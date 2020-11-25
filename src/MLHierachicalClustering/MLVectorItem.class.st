"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MLVectorItem,
	#superclass : #MLVectorDecorator,
	#instVars : [
		'item'
	],
	#category : #MLHierachicalClustering
}

{ #category : #'instance creation' }
MLVectorItem class >> with: anElement and: aVector [
	
	^(self on: aVector)
		item: anElement;
		yourself
]

{ #category : #'instance creation' }
MLVectorItem class >> with: anElement andAll: aCollection [
	
	^(self on: (MLArrayVector withAll: aCollection))
		item: anElement;
		yourself
]

{ #category : #comparing }
MLVectorItem >> = anObject [
	
	^super = anObject
		or: [(anObject isKindOf: MLVectorItem) and: [self item = anObject item]]
]

{ #category : #'vector functions' }
MLVectorItem >> dist: anItem [
	
	^self vector dist: anItem vector
]

{ #category : #accessing }
MLVectorItem >> item [
	
	^item
]

{ #category : #accessing }
MLVectorItem >> item: anObject [
	
	item := anObject
]

{ #category : #printing }
MLVectorItem >> printOn: aStream [
	
	item printOn: aStream
]

{ #category : #accessing }
MLVectorItem >> vector [
	
	^vector
]

{ #category : #accessing }
MLVectorItem >> vector: anObject [
	
	vector := anObject
]
