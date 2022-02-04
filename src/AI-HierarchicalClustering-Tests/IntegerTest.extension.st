Extension { #name : #IntegerTest }

{ #category : #'*AI-HierarchicalClustering-Tests' }
IntegerTest >> testFindNK [

	self assert: 6 findNK equals:  #(6 1 6 5 4 2).
	self assert: 10 findNK equals: #(10 1 10 9 5 2 5 3).
	self assert: 21 findNK equals: #(21 1 21 20 7 2 7 5).
	
	self should: [ 1 findNK ] raise: Error.
	self should: [ 0 findNK ] raise: Error.
]
