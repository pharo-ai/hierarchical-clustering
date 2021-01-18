Extension { #name : #Collection }

{ #category : #'*AI-HierarchicalClustering' }
Collection >> cross: aCollection do: aBlock [

	self do: [:each |
		aCollection do: [:another |
			aBlock value: each value: another.
			]
		]
]
