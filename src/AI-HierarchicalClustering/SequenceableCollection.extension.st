Extension { #name : #SequenceableCollection }

{ #category : #'*AI-HierarchicalClustering' }
SequenceableCollection >> copyRemoveAtIndex: index [
	"Return a copt of the receiver without the element at index."

	| newSequenceableCollection |
	newSequenceableCollection := self species withSize: self size - 1.
	newSequenceableCollection
		replaceFrom: 1
		to: index - 1
		with: self
		startingAt: 1.
	newSequenceableCollection
		replaceFrom: index
		to: self size - 1
		with: self
		startingAt: index +1.
	^newSequenceableCollection
]

{ #category : #'*AI-HierarchicalClustering' }
SequenceableCollection >> initializeDistanceSquareFor: anAIDistanceSquare [
	" Initialize anAIDistanceSquare matrix using the receiver's contents "

	self anyOne initializeDistanceSquare: anAIDistanceSquare from: self
]

{ #category : #'*AI-HierarchicalClustering' }
SequenceableCollection >> reverseSort: aSortBlock [
	"-- yet another selector for #sortReverse: --"
	"-- not deprecated, since both writings are reasonable --"

	self sortReverse: aSortBlock.
]

{ #category : #'*AI-HierarchicalClustering' }
SequenceableCollection >> sortReverse: aSortBlock [
	"Sort the receiver in-place in reversed order using aSortBlock, which can be one
	of: a closure with two agrument, a closure with one argument or a symbol."

	self sort: [:a :b | aSortBlock value: b. aSortBlock value: a]
]
