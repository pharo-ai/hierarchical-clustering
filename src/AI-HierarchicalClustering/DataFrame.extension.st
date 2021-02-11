Extension { #name : #DataFrame }

{ #category : #'*AI-HierarchicalClustering' }
DataFrame >> initializeDistanceSquareFor: anAIDistanceSquare [
	" Initialize anAIDistanceSquare matrix using the receiver's contents "

	anAIDistanceSquare initializeFromDataFrame: self
]
