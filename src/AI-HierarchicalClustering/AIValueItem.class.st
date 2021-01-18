"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #AIValueItem,
	#superclass : #Association,
	#category : #'AI-HierarchicalClustering-Core'
}

{ #category : #'distance functions' }
AIValueItem >> dist: anItem [
	
	^self value dist: anItem value
]

{ #category : #accessing }
AIValueItem >> item [
	
	^self key
]

{ #category : #accessing }
AIValueItem >> item: anObject [
	
	^self key: anObject
]

{ #category : #'distance functions' }
AIValueItem >> similarity: anItem [
	
	^self value similarity: anItem value
]
