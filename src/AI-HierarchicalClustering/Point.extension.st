Extension { #name : #Point }

{ #category : #'*AI-HierarchicalClustering' }
Point >> initializeDistanceSquare: anAIDistanceSquare from: aCollection [ 
	" Initialize anAIDistanceSquare based in the recever's element for aCollection items "

	anAIDistanceSquare initializeFromPoints: aCollection
]
