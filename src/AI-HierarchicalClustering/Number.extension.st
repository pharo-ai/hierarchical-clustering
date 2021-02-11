Extension { #name : #Number }

{ #category : #'*AI-HierarchicalClustering' }
Number >> initializeDistanceSquare: anAIDistanceSquare from: aCollection [ 
	" Initialize anAIDistanceSquare based in the recever's element for aCollection items "

	anAIDistanceSquare initializeFromNumbers: aCollection
]
