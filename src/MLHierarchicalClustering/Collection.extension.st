Extension { #name : #Collection }

{ #category : #'*MLHierarchicalClustering' }
Collection >> cross: aCollection do: aBlock [

	self do: [:each |
		aCollection do: [:another |
			aBlock value: each value: another.
			]
		]
]
