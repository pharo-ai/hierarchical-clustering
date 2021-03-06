Class {
	#name : #BaselineOfAIHierarchicalClustering,
	#superclass : #BaselineOf,
	#category : #BaselineOfAIHierarchicalClustering
}

{ #category : #baselines }
BaselineOfAIHierarchicalClustering >> baseline: spec [
  <baseline>
	spec
		for: #(common)
		do: [ 
			spec
				baseline: 'CollectionExtensions'
				with: [ spec repository: 'github://pharo-contributions/CollectionExtensions:v1.x.x/src' ];

				baseline: 'DataFrame'
				with: [ spec repository: 'github://PolyMathOrg/DataFrame/src' ];

				baseline: 'AILinearAlgebra'
				with: [ spec repository: 'github://pharo-ai/linear-algebra/src' ].

			spec 
				package: 'AI-HierarchicalClustering'	 		with: [ spec requires: #('CollectionExtensions' 'AILinearAlgebra' 'DataFrame') ];
				package: 'AI-HierarchicalClustering-Tests' 	with: [ spec requires: #('AI-HierarchicalClustering') ].
			spec 
				group: 'Core' 						with: #('AI-HierarchicalClustering');
				group: 'Tests' 						with: #('AI-HierarchicalClustering' 'AI-HierarchicalClustering-Tests');
				group: 'default' 					with: #('Core' 'Tests') ]
]
