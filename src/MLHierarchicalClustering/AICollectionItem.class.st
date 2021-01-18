"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #AICollectionItem,
	#superclass : #Collection,
	#instVars : [
		'item',
		'collection'
	],
	#category : #'MLHierarchicalClustering-Core'
}

{ #category : #adding }
AICollectionItem >> add: newObject [
	" *** This method was defined by Collection as a subclass responsibility.
	Replace its body with a proper implementation. *** "
	
	self error: 'Subclass responsibility stub not reimplemented'
]

{ #category : #accessing }
AICollectionItem >> collection [
	
	^collection
]

{ #category : #accessing }
AICollectionItem >> collection: anObject [
	
	collection := anObject
]

{ #category : #enumerating }
AICollectionItem >> do: aBlock [
	" *** This method was defined by Collection as a subclass responsibility.
	Replace its body with a proper implementation. *** "
	
	self error: 'Subclass responsibility stub not reimplemented'
]

{ #category : #accessing }
AICollectionItem >> item [
	
	^item
]

{ #category : #accessing }
AICollectionItem >> item: anObject [
	
	item := anObject
]

{ #category : #removing }
AICollectionItem >> remove: oldObject ifAbsent: anExceptionBlock [
	" *** This method was defined by Collection as a subclass responsibility.
	Replace its body with a proper implementation. *** "
	
	self error: 'Subclass responsibility stub not reimplemented'
]
