"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MLValueItem,
	#superclass : #Association,
	#category : #MLHierachicalClustering
}

{ #category : #'distance functions' }
MLValueItem >> dist: anItem [
	
	^self value dist: anItem value
]

{ #category : #accessing }
MLValueItem >> item [
	
	^self key
]

{ #category : #accessing }
MLValueItem >> item: anObject [
	
	^self key: anObject
]

{ #category : #'distance functions' }
MLValueItem >> similarity: anItem [
	
	^self value similarity: anItem value
]
