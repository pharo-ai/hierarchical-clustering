"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MLCollectionItem,
	#superclass : #Collection,
	#instVars : [
		'item',
		'collection'
	],
	#category : #MLHierachicalClustering
}

{ #category : #adding }
MLCollectionItem >> add: newObject [
	" *** This method was defined by Collection as a subclass responsibility.
	Replace its body with a proper implementation. *** "
	
	self error: 'Subclass responsibility stub not reimplemented'
]

{ #category : #accessing }
MLCollectionItem >> collection [
	
	^collection
]

{ #category : #accessing }
MLCollectionItem >> collection: anObject [
	
	collection := anObject
]

{ #category : #enumerating }
MLCollectionItem >> do: aBlock [
	" *** This method was defined by Collection as a subclass responsibility.
	Replace its body with a proper implementation. *** "
	
	self error: 'Subclass responsibility stub not reimplemented'
]

{ #category : #accessing }
MLCollectionItem >> item [
	
	^item
]

{ #category : #accessing }
MLCollectionItem >> item: anObject [
	
	item := anObject
]

{ #category : #removing }
MLCollectionItem >> remove: oldObject ifAbsent: anExceptionBlock [
	" *** This method was defined by Collection as a subclass responsibility.
	Replace its body with a proper implementation. *** "
	
	self error: 'Subclass responsibility stub not reimplemented'
]
