Extension { #name : #Collection }

{ #category : #'*MLHierachicalClustering' }
Collection >> cross: aCollection do: aBlock [

	self do: [:each |
		aCollection do: [:another |
			aBlock value: each value: another.
			]
		]
]
